#' Use Shiny Tooltips
#'
#' Inject the shinyTooltips JavaScript and CSS dependencies into your Shiny UI.
#' This function must be called once in your UI to enable tooltip functionality.
#'
#' @param theme Optional list with theme configuration. Can include:
#'   \itemize{
#'     \item \code{background}: Background color (default: "#2c3e50")
#'     \item \code{color}: Text color (default: "#ffffff")
#'     \item \code{borderRadius}: Border radius (default: "6px")
#'     \item \code{shadow}: Box shadow (default: "0 4px 12px rgba(0,0,0,0.15)")
#'   }
#'
#' @return HTML dependencies and container div for tooltips
#' @export
#'
#' @examples
#' \dontrun{
#' ui <- fluidPage(
#'   use_shiny_tooltips(),
#'   # Your UI components here
#' )
#' }
use_shiny_tooltips <- function(theme = NULL) {
  
  # Default theme values
  default_theme <- list(
    background = "#2c3e50",
    color = "#ffffff",
    borderRadius = "6px",
    shadow = "0 4px 12px rgba(0,0,0,0.15)"
  )
  
  # Merge with user theme
  if (!is.null(theme)) {
    theme <- modifyList(default_theme, theme)
  } else {
    theme <- default_theme
  }
  
  # Create CSS variables for theming
  style_vars <- sprintf(
    "--tooltip-bg: %s; --tooltip-color: %s; --tooltip-radius: %s; --tooltip-shadow: %s;",
    theme$background,
    theme$color,
    theme$borderRadius,
    theme$shadow
  )
  
  # Create dependencies
  deps <- htmltools::htmlDependency(
    name = "shinyTooltips",
    version = "0.1.0",
    src = system.file("www", package = "shinyTooltips"),
    script = "shinyTooltips.js",
    stylesheet = "shinyTooltips.css"
  )
  
  # Return container with dependencies
  htmltools::tagList(
    deps,
    htmltools::tags$div(
      id = "shiny-tooltips-root",
      style = style_vars,
      class = "shiny-tooltips-container"
    )
  )
}


#' Create a Tooltip
#'
#' Create a tooltip that attaches to a Shiny UI element. The tooltip will
#' be displayed based on the specified trigger (hover, click, or focus).
#'
#' @param target Character string specifying the target element's ID or CSS selector.
#'   If it starts with "#" or ".", it's treated as a CSS selector; otherwise,
#'   "#" is prepended to treat it as an ID.
#' @param content Character string, HTML content, or tagList for the tooltip. 
#'   Can include HTML tags for formatting. Supports htmltools::tagList() for 
#'   complex content structures.
#' @param placement Character string specifying tooltip placement: "top", "bottom",
#'   "left", or "right". Default is "top".
#' @param trigger Character string specifying the trigger behavior: "hover",
#'   "click", or "focus". Default is "hover".
#' @param animation Character string specifying animation style: "fade" or "scale".
#'   Default is "fade".
#' @param delay Numeric value for show/hide delay in milliseconds. Default is 0.
#' @param offset Numeric value for distance offset from target element in pixels.
#'   Default is 10.
#' @param size Character string specifying tooltip size: "small", "medium", "large",
#'   or "auto". Default is "auto". Use "auto" for content-based sizing.
#' @param width Character string specifying fixed width (e.g., "200px", "15rem").
#'   Overrides size parameter. Default is NULL (uses size-based width).
#' @param maxWidth Character string specifying maximum width (e.g., "400px", "90vw").
#'   Default is NULL (uses theme default).
#' @param style Character string with custom CSS styles to apply to the tooltip.
#'   Example: "font-size: 16px; font-weight: bold;". Default is NULL.
#' @param interactive Logical value. If TRUE, the tooltip will remain visible when
#'   hovering over it, allowing interaction with inputs or links inside. Useful for
#'   tooltips containing interactive elements. Default is FALSE.
#'
#' @return An HTML tag with tooltip data attributes
#' @export
#'
#' @examples
#' \dontrun{
#' # Basic tooltip
#' ui <- fluidPage(
#'   use_shiny_tooltips(),
#'   tooltip(
#'     target = "myButton",
#'     content = "Click me to submit!",
#'     placement = "top",
#'     trigger = "hover"
#'   ),
#'   actionButton("myButton", "Submit")
#' )
#' 
#' # Tooltip with custom size and style
#' tooltip(
#'   target = "btn",
#'   content = "Large tooltip with custom styling",
#'   size = "large",
#'   style = "background-color: #e74c3c; font-size: 18px;"
#' )
#' 
#' # Tooltip with tagList content
#' tooltip(
#'   target = "info",
#'   content = tagList(
#'     tags$h4("Important Information"),
#'     tags$p("This is a complex tooltip with multiple elements"),
#'     tags$ul(
#'       tags$li("Point 1"),
#'       tags$li("Point 2")
#'     )
#'   ),
#'   width = "300px"
#' )
#' }
tooltip <- function(target,
                   content,
                   placement = "top",
                   trigger = "hover",
                   animation = "fade",
                   delay = 0,
                   offset = 10,
                   size = "auto",
                   width = NULL,
                   maxWidth = NULL,
                   style = NULL,
                   interactive = FALSE) {
  
  # Validate inputs
  placement <- match.arg(placement, c("top", "bottom", "left", "right"))
  trigger <- match.arg(trigger, c("hover", "click", "focus"))
  animation <- match.arg(animation, c("fade", "scale"))
  size <- match.arg(size, c("auto", "small", "medium", "large"))
  
  # Normalize target selector
  target <- normalize_selector(target)
  
  # Generate unique tooltip ID
  tooltip_id <- generate_tooltip_id()
  
  # Process content - handle tagList and other htmltools objects
  content_html <- if (inherits(content, "shiny.tag") || 
                      inherits(content, "shiny.tag.list") ||
                      inherits(content, "html")) {
    as.character(htmltools::doRenderTags(content))
  } else {
    as.character(content)
  }
  
  # Create tooltip definition
  tooltip_def <- list(
    id = tooltip_id,
    target = target,
    content = content_html,
    placement = placement,
    trigger = trigger,
    animation = animation,
    delay = as.numeric(delay),
    offset = as.numeric(offset),
    size = size,
    interactive = as.logical(interactive)
  )
  
  # Add optional style parameters
  if (!is.null(width)) {
    tooltip_def$width <- as.character(width)
  }
  
  if (!is.null(maxWidth)) {
    tooltip_def$maxWidth <- as.character(maxWidth)
  }
  
  if (!is.null(style)) {
    tooltip_def$customStyle <- as.character(style)
  }
  
  # Convert to JSON for data attribute
  tooltip_json <- jsonlite::toJSON(tooltip_def, auto_unbox = TRUE)
  
  # Return a script tag that registers the tooltip
  htmltools::tags$script(
    type = "application/json",
    class = "shiny-tooltip-definition",
    `data-tooltip-id` = tooltip_id,
    htmltools::HTML(tooltip_json)
  )
}


#' Normalize CSS Selector
#'
#' Internal function to normalize target selectors for tooltips.
#'
#' @param selector Character string with element ID or CSS selector
#' @return Normalized CSS selector string
#' @keywords internal
normalize_selector <- function(selector) {
  if (is.null(selector) || nchar(selector) == 0) {
    stop("Selector cannot be empty")
  }
  
  # If it starts with # or ., treat as CSS selector
  if (grepl("^[#.]", selector)) {
    return(selector)
  }
  
  # Otherwise, prepend # to treat as ID
  return(paste0("#", selector))
}


#' Generate Unique Tooltip ID
#'
#' Internal function to generate unique tooltip identifiers.
#'
#' @return Character string with unique tooltip ID
#' @keywords internal
generate_tooltip_id <- function() {
  paste0("tooltip-", format(Sys.time(), "%Y%m%d%H%M%S"), "-", 
         sample(1000:9999, 1))
}


#' Validate Tooltip Definition
#'
#' Internal function to validate tooltip configuration.
#'
#' @param tooltip_def List containing tooltip definition
#' @return TRUE if valid, otherwise throws error
#' @keywords internal
validate_tooltip <- function(tooltip_def) {
  required_fields <- c("id", "target", "content", "placement", "trigger")
  
  missing <- setdiff(required_fields, names(tooltip_def))
  if (length(missing) > 0) {
    stop("Missing required tooltip fields: ", paste(missing, collapse = ", "))
  }
  
  if (!tooltip_def$placement %in% c("top", "bottom", "left", "right")) {
    stop("Invalid placement: must be top, bottom, left, or right")
  }
  
  if (!tooltip_def$trigger %in% c("hover", "click", "focus")) {
    stop("Invalid trigger: must be hover, click, or focus")
  }
  
  TRUE
}
