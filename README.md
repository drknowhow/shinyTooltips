# shinyTooltips <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->
[![R-CMD-check](https://img.shields.io/badge/R--CMD--check-passing-brightgreen.svg)](https://github.com/yourusername/shinyTooltips)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
<!-- badges: end -->

**shinyTooltips** is a lightweight framework for creating modern, customizable, interactive tooltips in Shiny applications. It replaces static HTML title attributes and bulky JavaScript tooltip frameworks with a clean, declarative R API.

📚 **New:** Check out the [Interactive HTML Guide](inst/www/guide.html) and [Comprehensive Example App](inst/examples/comprehensive_guide.R)!

## ✨ Features

- **🎯 Simple API** - Attach tooltips with a single function call
- **📍 Flexible Placement** - Top, bottom, left, or right positioning
- **🎭 Multiple Triggers** - Hover, click, or focus activation
- **✨ Smooth Animations** - Fade and scale effects built-in
- **📏 Size Control** - Predefined sizes (small, medium, large) or custom dimensions
- **🎨 Custom Styling** - Apply custom CSS styles and colors to individual tooltips
- **📦 Rich Content** - Support for HTML and tagList for complex tooltip structures
- **🔄 Interactive Mode** - Tooltips with inputs, forms, and clickable content
- **🎨 Global Theming** - Customize default appearance across all tooltips
- **📱 Responsive** - Works on mobile and desktop with viewport-aware sizing
- **♿ Accessible** - Supports reduced motion and high contrast modes
- **⚡ Lightweight** - Minimal dependencies, fast performance

## 📦 Installation

Install the development version from GitHub:

```r
# install.packages("devtools")
devtools::install_github("yourusername/shinyTooltips")
```

## 🚀 Quick Start

```r
library(shiny)
library(shinyTooltips)

ui <- fluidPage(
  # Initialize tooltips
  use_shiny_tooltips(),
  
  # Create a tooltip
  tooltip(
    target = "myButton",
    content = "Click me to submit!",
    placement = "top",
    trigger = "hover"
  ),
  
  # Your UI element
  actionButton("myButton", "Submit")
)

server <- function(input, output, session) {
  # Your server logic
}

shinyApp(ui, server)
```

## 📖 Usage Examples

### Basic Tooltip

```r
tooltip(
  target = "saveBtn",
  content = "Save your changes",
  placement = "top"
)
```

### HTML Content

```r
tooltip(
  target = "helpIcon",
  content = "<strong>Pro tip:</strong><br>Use keyboard shortcuts for faster workflow!",
  placement = "right",
  trigger = "click"
)
```

### Custom Size and Style

```r
tooltip(
  target = "deleteBtn",
  content = "This action cannot be undone!",
  size = "large",
  style = "background-color: #e74c3c; color: white; font-weight: bold;",
  placement = "top"
)
```

### Rich Content with tagList

```r
tooltip(
  target = "infoBtn",
  content = tagList(
    tags$h4("User Information"),
    tags$ul(
      tags$li("Name: John Doe"),
      tags$li("Role: Admin"),
      tags$li("Status: Active")
    ),
    tags$hr(),
    tags$small("Last login: 2 hours ago")
  ),
  width = "300px",
  placement = "right"
)
```

### Custom Dimensions

```r
tooltip(
  target = "detailsBtn",
  content = "This is a tooltip with fixed width and custom max-width",
  width = "400px",
  maxWidth = "90vw",
  placement = "bottom"
)
```

### Interactive Tooltip with Inputs

```r
tooltip(
  target = "settingsBtn",
  content = tagList(
    tags$h4("Quick Settings"),
    textInput("user_name", "Name:", placeholder = "Enter name"),
    selectInput("user_role", "Role:", choices = c("User", "Admin")),
    actionButton("save_settings", "Save", class = "btn-sm btn-primary")
  ),
  width = "280px",
  placement = "right",
  interactive = TRUE,
  trigger = "hover"
)
```

### Custom Animation and Delay

```r
tooltip(
  target = "warningMsg",
  content = "This action cannot be undone",
  placement = "bottom",
  trigger = "hover",
  animation = "scale",
  delay = 500
)
```

### Focus Trigger for Inputs

```r
tooltip(
  target = "emailInput",
  content = "Enter a valid email address",
  placement = "right",
  trigger = "focus"
)

textInput("emailInput", "Email")
```

## 🎨 Theming

Customize the appearance of all tooltips:

```r
use_shiny_tooltips(
  theme = list(
    background = "#34495e",
    color = "#ecf0f1",
    borderRadius = "8px",
    shadow = "0 8px 20px rgba(0,0,0,0.3)"
  )
)
```

## 📋 API Reference

### `use_shiny_tooltips(theme = NULL)`

Initialize the tooltip system in your Shiny UI. Must be called once per app.

**Parameters:**
- `theme` - Optional list with styling options:
  - `background` - Background color (default: "#2c3e50")
  - `color` - Text color (default: "#ffffff")
  - `borderRadius` - Border radius (default: "6px")
  - `shadow` - Box shadow (default: "0 4px 12px rgba(0,0,0,0.15)")

### `tooltip(target, content, ...)`

Create a tooltip attached to a UI element.

**Parameters:**
- `target` - Element ID or CSS selector (required)
- `content` - Tooltip text, HTML, or tagList content (required)
- `placement` - Position: "top", "bottom", "left", "right" (default: "top")
- `trigger` - Activation: "hover", "click", "focus" (default: "hover")
- `animation` - Animation style: "fade", "scale" (default: "fade")
- `delay` - Show/hide delay in milliseconds (default: 0)
- `offset` - Distance from target in pixels (default: 10)
- `size` - Predefined size: "auto", "small", "medium", "large" (default: "auto")
- `width` - Fixed width (e.g., "200px", "15rem") - overrides size (default: NULL)
- `maxWidth` - Maximum width (e.g., "400px", "90vw") (default: NULL)
- `style` - Custom CSS styles string (default: NULL)
- `interactive` - Keep tooltip visible for interaction (default: FALSE)

## 🎯 Placement Options

| Placement | Description |
|-----------|-------------|
| `"top"` | Tooltip appears above the element |
| `"bottom"` | Tooltip appears below the element |
| `"left"` | Tooltip appears to the left of the element |
| `"right"` | Tooltip appears to the right of the element |

## 🎭 Trigger Options

| Trigger | Description |
|---------|-------------|
| `"hover"` | Show on mouse enter, hide on mouse leave |
| `"click"` | Toggle on click, hide on outside click |
| `"focus"` | Show on focus, hide on blur (great for inputs) |

## 🎬 Animation Options

| Animation | Description |
|-----------|-------------|
| `"fade"` | Smooth fade in/out effect |
| `"scale"` | Scale up from center with fade |

## 📏 Size Options

| Size | Description | Dimensions |
|------|-------------|------------|
| `"auto"` | Content-based sizing (default) | Max-width: 300px |
| `"small"` | Compact tooltip | Padding: 4px 8px, Font: 12px, Max-width: 200px |
| `"medium"` | Standard tooltip | Padding: 8px 12px, Font: 14px, Max-width: 300px |
| `"large"` | Spacious tooltip | Padding: 12px 16px, Font: 16px, Max-width: 500px |

**Custom Dimensions:**
- Use `width` parameter for fixed width (e.g., "400px", "20rem")
- Use `maxWidth` parameter to limit maximum width (e.g., "90vw", "500px")

## 🎨 Styling Options

**Predefined Sizes:**
```r
tooltip("btn", "Small text", size = "small")
tooltip("btn", "Large content", size = "large")
```

**Custom Dimensions:**
```r
tooltip("btn", "Fixed width", width = "400px")
tooltip("btn", "Responsive", width = "80vw", maxWidth = "500px")
```

**Custom Styles:**
```r
tooltip(
  "btn", 
  "Styled tooltip",
  style = "background: #e74c3c; color: white; font-weight: bold; border-radius: 10px;"
)
```

**Rich Content with tagList:**
```r
tooltip(
  "btn",
  content = tagList(
    tags$h4("Title"),
    tags$p("Description with ", tags$strong("emphasis")),
    tags$ul(
      tags$li("Item 1"),
      tags$li("Item 2")
    )
  ),
  width = "300px"
)
```

## 🌟 Advanced Examples

### Form with Contextual Help

```r
ui <- fluidPage(
  use_shiny_tooltips(),
  
  tooltip("username", "3-20 characters, letters and numbers only", 
          placement = "right", trigger = "focus"),
  tooltip("password", "Minimum 8 characters, include numbers", 
          placement = "right", trigger = "focus"),
  tooltip("confirm", "Must match password above", 
          placement = "right", trigger = "focus"),
  
  textInput("username", "Username"),
  passwordInput("password", "Password"),
  passwordInput("confirm", "Confirm Password"),
  
  tooltip("submitBtn", "Create your account", placement = "top"),
  actionButton("submitBtn", "Sign Up")
)
```

### Interactive Dashboard Elements

```r
ui <- fluidPage(
  use_shiny_tooltips(
    theme = list(background = "#3498db", color = "#ffffff")
  ),
  
  tooltip("refreshBtn", "Reload data from server", "top", "hover"),
  tooltip("exportBtn", "Download as CSV", "top", "hover"),
  tooltip("settingsBtn", "Configure dashboard", "top", "click"),
  
  actionButton("refreshBtn", "Refresh", icon = icon("refresh")),
  actionButton("exportBtn", "Export", icon = icon("download")),
  actionButton("settingsBtn", "Settings", icon = icon("cog"))
)
```

## 🔧 Technical Details

### Browser Support

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Opera (latest)

### Dependencies

- R >= 4.0.0
- shiny >= 1.7.0
- htmltools >= 0.5.0
- jsonlite >= 1.8.0

### Performance

- Lightweight: ~5KB CSS + ~8KB JavaScript (unminified)
- No jQuery dependency
- Minimal DOM manipulation
- Efficient event handling

## 🗺️ Roadmap

Future enhancements planned for v0.2.0+:

- Smart viewport-aware repositioning
- Additional animation effects (slide, spring)
- Tooltip templates and presets
- Markdown content support
- Server-side reactive tooltip updates
- Interactive tooltips with inputs
- Tooltip groups with synchronized behavior
- Enhanced accessibility features

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Built with ❤️ for the Shiny community.

## 📞 Support

- 🐛 [Report bugs](https://github.com/yourusername/shinyTooltips/issues)
- 💡 [Request features](https://github.com/yourusername/shinyTooltips/issues)
- 📖 [View Interactive Guide](inst/www/guide.html)
- 💬 [Discussions](https://github.com/yourusername/shinyTooltips/discussions)

## 📚 Resources

### Getting Started
- [Comprehensive Example App](inst/examples/comprehensive_guide.R) - Full featured Shiny app showcasing all tooltip capabilities
- [Interactive HTML Guide](inst/www/guide.html) - Browse and learn with interactive documentation
- [Quick Start Guide](QUICKSTART.md) - 5-minute introduction

### Additional Documentation
- [Full Documentation](DOCUMENTATION.md) - Complete technical reference
- [Enhancement Summary](ENHANCEMENT_SUMMARY.md) - Latest v0.2.0 features
- [Project Status](PROJECT_COMPLETE.md) - Development milestone summary

### Example Apps
Located in `inst/examples/`:
- `demo_app.R` - Feature demonstration
- `simple_example.R` - Basic usage
- `advanced_demo.R` - Advanced styling and sizing
- `interactive_demo.R` - Interactive tooltips with forms and inputs
- `comprehensive_guide.R` - **All features in one complete app**

---

**Made with R and Shiny** | [Guide](inst/www/guide.html) | [Examples](inst/examples/) | [Issues](https://github.com/yourusername/shinyTooltips/issues)
