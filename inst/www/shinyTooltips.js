/**
 * shinyTooltips.js
 * Lightweight tooltip system for Shiny applications
 * Version: 0.1.0
 */

(function() {
  'use strict';

  // Tooltip registry to track active tooltips
  const tooltipRegistry = new Map();
  let tooltipContainer = null;

  /**
   * Initialize the tooltip system when DOM is ready
   */
  function initTooltipSystem() {
    // Find or create tooltip container
    tooltipContainer = document.getElementById('shiny-tooltips-root');
    
    if (!tooltipContainer) {
      console.warn('shinyTooltips: Root container not found. Did you call use_shiny_tooltips()?');
      return;
    }

    // Load all tooltip definitions from the page
    loadTooltipDefinitions();

    // Set up mutation observer to catch dynamically added tooltips
    observeTooltipDefinitions();
  }

  /**
   * Load all tooltip definitions from script tags
   */
  function loadTooltipDefinitions() {
    const definitions = document.querySelectorAll('script.shiny-tooltip-definition');
    
    definitions.forEach(script => {
      try {
        const tooltipDef = JSON.parse(script.textContent);
        registerTooltip(tooltipDef);
      } catch (error) {
        console.error('shinyTooltips: Failed to parse tooltip definition', error);
      }
    });
  }

  /**
   * Observe DOM for dynamically added tooltip definitions
   */
  function observeTooltipDefinitions() {
    const observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        mutation.addedNodes.forEach(node => {
          if (node.nodeType === 1) { // Element node
            if (node.classList && node.classList.contains('shiny-tooltip-definition')) {
              try {
                const tooltipDef = JSON.parse(node.textContent);
                registerTooltip(tooltipDef);
              } catch (error) {
                console.error('shinyTooltips: Failed to parse tooltip definition', error);
              }
            }
            
            // Check children
            const definitions = node.querySelectorAll('script.shiny-tooltip-definition');
            definitions.forEach(script => {
              try {
                const tooltipDef = JSON.parse(script.textContent);
                registerTooltip(tooltipDef);
              } catch (error) {
                console.error('shinyTooltips: Failed to parse tooltip definition', error);
              }
            });
          }
        });
      });
    });

    observer.observe(document.body, {
      childList: true,
      subtree: true
    });
  }

  /**
   * Register a tooltip and attach it to its target element
   */
  function registerTooltip(tooltipDef) {
    // Check if already registered
    if (tooltipRegistry.has(tooltipDef.id)) {
      return;
    }

    // Find target element
    const targetElement = document.querySelector(tooltipDef.target);
    
    if (!targetElement) {
      console.warn(`shinyTooltips: Target element not found: ${tooltipDef.target}`);
      return;
    }

    // Create tooltip element
    const tooltipElement = createTooltipElement(tooltipDef);
    
    // Store in registry
    const tooltipData = {
      def: tooltipDef,
      element: tooltipElement,
      target: targetElement,
      visible: false,
      showTimeout: null,
      hideTimeout: null
    };
    
    tooltipRegistry.set(tooltipDef.id, tooltipData);

    // Attach event listeners based on trigger type
    attachTriggerListeners(tooltipData);
  }

  /**
   * Create the tooltip DOM element
   */
  function createTooltipElement(tooltipDef) {
    const tooltip = document.createElement('div');
    tooltip.className = `shiny-tooltip shiny-tooltip-${tooltipDef.animation}`;
    tooltip.setAttribute('data-tooltip-id', tooltipDef.id);
    tooltip.setAttribute('data-placement', tooltipDef.placement);
    
    // Add size class if specified
    if (tooltipDef.size && tooltipDef.size !== 'auto') {
      tooltip.classList.add(`shiny-tooltip-${tooltipDef.size}`);
    }
    
    // Apply custom width if specified
    if (tooltipDef.width) {
      tooltip.style.width = tooltipDef.width;
    }
    
    // Apply custom max-width if specified
    if (tooltipDef.maxWidth) {
      tooltip.style.maxWidth = tooltipDef.maxWidth;
      // If only maxWidth is set (no width), allow content to expand naturally
      if (!tooltipDef.width) {
        tooltip.style.width = 'auto';
      }
    }
    
    // Mark as interactive if specified
    if (tooltipDef.interactive) {
      tooltip.classList.add('shiny-tooltip-interactive');
      tooltip.style.pointerEvents = 'auto';
    }
    
    // Apply custom styles if specified
    if (tooltipDef.customStyle) {
      // Parse and apply custom styles
      const styles = tooltipDef.customStyle.split(';').filter(s => s.trim());
      styles.forEach(style => {
        const [property, value] = style.split(':').map(s => s.trim());
        if (property && value) {
          // Convert CSS property to camelCase for JS style object
          const camelProperty = property.replace(/-([a-z])/g, (g) => g[1].toUpperCase());
          tooltip.style[camelProperty] = value;
        }
      });
    }
    
    // Create tooltip content
    const content = document.createElement('div');
    content.className = 'shiny-tooltip-content';
    content.innerHTML = tooltipDef.content;
    
    // Create arrow
    const arrow = document.createElement('div');
    arrow.className = 'shiny-tooltip-arrow';
    
    tooltip.appendChild(content);
    tooltip.appendChild(arrow);
    
    // Add to container (hidden initially)
    tooltipContainer.appendChild(tooltip);
    
    return tooltip;
  }

  /**
   * Attach event listeners based on trigger type
   */
  function attachTriggerListeners(tooltipData) {
    const { def, target, element } = tooltipData;

    switch (def.trigger) {
      case 'hover':
        target.addEventListener('mouseenter', () => showTooltip(tooltipData));
        target.addEventListener('mouseleave', () => {
          // For interactive tooltips, delay hide to allow mouse to move to tooltip
          if (def.interactive) {
            setTimeout(() => {
              // Only hide if mouse is not over tooltip
              if (!element.matches(':hover')) {
                hideTooltip(tooltipData);
              }
            }, 100);
          } else {
            hideTooltip(tooltipData);
          }
        });
        
        // For interactive tooltips, also hide when mouse leaves tooltip
        if (def.interactive) {
          element.addEventListener('mouseleave', () => hideTooltip(tooltipData));
        }
        break;

      case 'click':
        target.addEventListener('click', (e) => {
          e.preventDefault();
          toggleTooltip(tooltipData);
        });
        // Close on outside click (but not if clicking inside tooltip)
        document.addEventListener('click', (e) => {
          if (!target.contains(e.target) && !element.contains(e.target)) {
            hideTooltip(tooltipData);
          }
        });
        break;

      case 'focus':
        target.addEventListener('focus', () => showTooltip(tooltipData));
        target.addEventListener('blur', () => {
          // For interactive tooltips, don't hide immediately on blur
          if (!def.interactive) {
            hideTooltip(tooltipData);
          }
        });
        break;
    }
  }

  /**
   * Show tooltip with delay and positioning
   */
  function showTooltip(tooltipData) {
    const { def, element } = tooltipData;

    // Clear any pending hide timeout
    if (tooltipData.hideTimeout) {
      clearTimeout(tooltipData.hideTimeout);
      tooltipData.hideTimeout = null;
    }

    // Set show timeout
    tooltipData.showTimeout = setTimeout(() => {
      // Position tooltip
      positionTooltip(tooltipData);
      
      // Show tooltip
      element.classList.add('shiny-tooltip-visible');
      tooltipData.visible = true;
    }, def.delay);
  }

  /**
   * Hide tooltip with delay
   */
  function hideTooltip(tooltipData) {
    const { def, element } = tooltipData;

    // Clear any pending show timeout
    if (tooltipData.showTimeout) {
      clearTimeout(tooltipData.showTimeout);
      tooltipData.showTimeout = null;
    }

    // Set hide timeout
    tooltipData.hideTimeout = setTimeout(() => {
      element.classList.remove('shiny-tooltip-visible');
      tooltipData.visible = false;
    }, def.delay);
  }

  /**
   * Toggle tooltip visibility (for click trigger)
   */
  function toggleTooltip(tooltipData) {
    if (tooltipData.visible) {
      hideTooltip(tooltipData);
    } else {
      showTooltip(tooltipData);
    }
  }

  /**
   * Position tooltip relative to target element
   */
  function positionTooltip(tooltipData) {
    const { def, element, target } = tooltipData;
    const targetRect = target.getBoundingClientRect();
    const tooltipRect = element.getBoundingClientRect();
    const offset = def.offset || 10;

    let top, left;

    switch (def.placement) {
      case 'top':
        top = targetRect.top - tooltipRect.height - offset;
        left = targetRect.left + (targetRect.width / 2) - (tooltipRect.width / 2);
        break;

      case 'bottom':
        top = targetRect.bottom + offset;
        left = targetRect.left + (targetRect.width / 2) - (tooltipRect.width / 2);
        break;

      case 'left':
        top = targetRect.top + (targetRect.height / 2) - (tooltipRect.height / 2);
        left = targetRect.left - tooltipRect.width - offset;
        break;

      case 'right':
        top = targetRect.top + (targetRect.height / 2) - (tooltipRect.height / 2);
        left = targetRect.right + offset;
        break;
    }

    // Simple viewport boundary checking
    const viewportWidth = window.innerWidth;
    const viewportHeight = window.innerHeight;

    // Keep within horizontal bounds
    if (left < 0) {
      left = 10;
    } else if (left + tooltipRect.width > viewportWidth) {
      left = viewportWidth - tooltipRect.width - 10;
    }

    // Keep within vertical bounds
    if (top < 0) {
      top = 10;
    } else if (top + tooltipRect.height > viewportHeight) {
      top = viewportHeight - tooltipRect.height - 10;
    }

    // Add scroll offset
    top += window.scrollY;
    left += window.scrollX;

    // Apply position
    element.style.top = `${top}px`;
    element.style.left = `${left}px`;
  }

  /**
   * Clean up tooltip (for dynamic removal)
   */
  function removeTooltip(tooltipId) {
    const tooltipData = tooltipRegistry.get(tooltipId);
    
    if (tooltipData) {
      // Clear timeouts
      if (tooltipData.showTimeout) clearTimeout(tooltipData.showTimeout);
      if (tooltipData.hideTimeout) clearTimeout(tooltipData.hideTimeout);
      
      // Remove element
      if (tooltipData.element && tooltipData.element.parentNode) {
        tooltipData.element.parentNode.removeChild(tooltipData.element);
      }
      
      // Remove from registry
      tooltipRegistry.delete(tooltipId);
    }
  }

  // Initialize when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initTooltipSystem);
  } else {
    initTooltipSystem();
  }

  // Expose API for potential future use
  window.shinyTooltips = {
    version: '0.1.0',
    registry: tooltipRegistry,
    remove: removeTooltip
  };

})();
