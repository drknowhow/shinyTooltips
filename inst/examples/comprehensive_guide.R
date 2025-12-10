# Comprehensive shinyTooltips Example Application
# This is a complete, production-ready example showcasing all features of the library

library(shiny)
library(shinyTooltips)

# Define UI
ui <- fluidPage(
  # Initialize tooltips
  use_shiny_tooltips(
    theme = list(
      background = "#2c3e50",
      color = "#ffffff",
      borderRadius = "8px",
      shadow = "0 4px 16px rgba(0,0,0,0.15)"
    )
  ),
  
  # Custom styling
  tags$head(
    tags$meta(charset = "utf-8"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
    tags$style(HTML("
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 0;
        margin: 0;
      }
      
      .navbar {
        background: rgba(0, 0, 0, 0.8);
        padding: 20px;
        color: white;
        margin-bottom: 30px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      }
      
      .navbar h1 {
        margin: 0;
        font-size: 32px;
        display: flex;
        align-items: center;
        gap: 15px;
      }
      
      .navbar-subtitle {
        margin: 10px 0 0 0;
        color: #bdc3c7;
        font-size: 14px;
      }
      
      .container-fluid {
        max-width: 1200px;
        margin: 0 auto;
        padding: 30px;
      }
      
      .section {
        background: white;
        border-radius: 12px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.15);
      }
      
      .section-title {
        font-size: 24px;
        color: #2c3e50;
        margin: 0 0 20px 0;
        padding-bottom: 15px;
        border-bottom: 3px solid #667eea;
        display: flex;
        align-items: center;
        gap: 10px;
      }
      
      .section-description {
        color: #7f8c8d;
        margin-bottom: 20px;
        line-height: 1.6;
      }
      
      .demo-group {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin: 20px 0;
      }
      
      .demo-item {
        padding: 15px;
        background: #f8f9fa;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        text-align: center;
        transition: all 0.3s ease;
      }
      
      .demo-item:hover {
        border-color: #667eea;
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
      }
      
      .demo-label {
        font-size: 12px;
        color: #7f8c8d;
        margin-bottom: 8px;
        font-weight: bold;
        text-transform: uppercase;
      }
      
      .demo-button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.2s ease;
      }
      
      .btn-primary-demo {
        background: #3498db;
        color: white;
      }
      
      .btn-primary-demo:hover {
        background: #2980b9;
      }
      
      .btn-success-demo {
        background: #27ae60;
        color: white;
      }
      
      .btn-success-demo:hover {
        background: #229954;
      }
      
      .btn-danger-demo {
        background: #e74c3c;
        color: white;
      }
      
      .btn-danger-demo:hover {
        background: #c0392b;
      }
      
      .btn-warning-demo {
        background: #f39c12;
        color: white;
      }
      
      .btn-warning-demo:hover {
        background: #d68910;
      }
      
      .btn-info-demo {
        background: #9b59b6;
        color: white;
      }
      
      .btn-info-demo:hover {
        background: #8e44ad;
      }
      
      .code-block {
        background: #2c3e50;
        color: #ecf0f1;
        padding: 15px;
        border-radius: 6px;
        overflow-x: auto;
        font-family: 'Courier New', monospace;
        font-size: 12px;
        margin: 15px 0;
        border-left: 4px solid #667eea;
      }
      
      .result-box {
        background: #ecf0f1;
        padding: 15px;
        border-radius: 6px;
        margin: 15px 0;
        border-left: 4px solid #27ae60;
        min-height: 50px;
      }
      
      .row-demo {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        margin: 15px 0;
      }
      
      .col-demo {
        flex: 1;
        min-width: 200px;
      }
      
      .feature-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin: 20px 0;
      }
      
      .feature-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        border-radius: 8px;
        text-align: center;
      }
      
      .feature-icon {
        font-size: 32px;
        margin-bottom: 10px;
      }
      
      .feature-title {
        font-weight: bold;
        margin: 10px 0;
      }
      
      .feature-desc {
        font-size: 12px;
        opacity: 0.9;
      }
      
      .footer {
        background: rgba(0, 0, 0, 0.8);
        color: white;
        padding: 20px;
        text-align: center;
        margin-top: 50px;
        border-radius: 8px;
      }
      
      .tab-content {
        margin-top: 20px;
      }
    "))
  ),
  
  # Navigation bar
  div(
    class = "navbar",
    h1("📚 shinyTooltips", tags$span(style = "font-size: 18px;", "Comprehensive Guide")),
    p(class = "navbar-subtitle", "Modern, Interactive Tooltips for Shiny Applications")
  ),
  
  div(
    class = "container-fluid",
    
    # Introduction Section
    div(
      class = "section",
      h2(class = "section-title", "Welcome to shinyTooltips"),
      p(class = "section-description",
        "This comprehensive guide demonstrates all features of the shinyTooltips library. ",
        "Hover over buttons and elements throughout this app to see tooltips in action. ",
        "shinyTooltips provides a lightweight, modern way to add interactive tooltips to your Shiny applications."),
      
      div(
        class = "feature-grid",
        div(
          class = "feature-card",
          div(class = "feature-icon", "🎯"),
          div(class = "feature-title", "Simple API"),
          div(class = "feature-desc", "Easy to use, declarative tooltips")
        ),
        div(
          class = "feature-card",
          div(class = "feature-icon", "📍"),
          div(class = "feature-title", "Flexible Placement"),
          div(class = "feature-desc", "Top, bottom, left, right positioning")
        ),
        div(
          class = "feature-card",
          div(class = "feature-icon", "⚡"),
          div(class = "feature-title", "Lightweight"),
          div(class = "feature-desc", "Only 13KB unminified JS+CSS")
        ),
        div(
          class = "feature-card",
          div(class = "feature-icon", "🎨"),
          div(class = "feature-title", "Customizable"),
          div(class = "feature-desc", "Themes, sizes, styles, and more")
        )
      )
    ),
    
    # Basic Usage Section
    div(
      class = "section",
      h2(class = "section-title", "1️⃣ Basic Usage"),
      p(class = "section-description",
        "The simplest way to create a tooltip. Just specify a target element and content."),
      
      div(class = "code-block",
        "tooltip(target = 'myBtn', content = 'Click me!')"
      ),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "Default"),
          tooltip("basic_default", "This is a default tooltip"),
          actionButton("basic_default", "Hover Me", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "With Delay"),
          tooltip("basic_delay", "This tooltip has a 300ms delay", delay = 300),
          actionButton("basic_delay", "Delayed", class = "demo-button btn-info-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Longer Content"),
          tooltip("basic_long", "This is a longer tooltip with more descriptive content"),
          actionButton("basic_long", "Long Text", class = "demo-button btn-success-demo")
        )
      )
    ),
    
    # Placement Section
    div(
      class = "section",
      h2(class = "section-title", "2️⃣ Placement Options"),
      p(class = "section-description",
        "Tooltips can be positioned in four directions around the target element."),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "Top"),
          tooltip("place_top", "Top placement", placement = "top"),
          actionButton("place_top", "Top", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Bottom"),
          tooltip("place_bottom", "Bottom placement", placement = "bottom"),
          actionButton("place_bottom", "Bottom", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Left"),
          tooltip("place_left", "Left placement", placement = "left"),
          actionButton("place_left", "Left", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Right"),
          tooltip("place_right", "Right placement", placement = "right"),
          actionButton("place_right", "Right", class = "demo-button btn-primary-demo")
        )
      )
    ),
    
    # Trigger Section
    div(
      class = "section",
      h2(class = "section-title", "3️⃣ Trigger Types"),
      p(class = "section-description",
        "Control how tooltips appear: hover, click, or focus on input elements."),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "Hover"),
          tooltip("trig_hover", "I appear on hover!", trigger = "hover"),
          actionButton("trig_hover", "Hover Trigger", class = "demo-button btn-success-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Click"),
          tooltip("trig_click", "I appear on click! Click again to hide.", trigger = "click"),
          actionButton("trig_click", "Click Trigger", class = "demo-button btn-warning-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Focus"),
          tooltip("trig_focus", "I appear when focused!", trigger = "focus"),
          textInput("trig_focus", NULL, placeholder = "Click or Tab here")
        )
      )
    ),
    
    # Animations Section
    div(
      class = "section",
      h2(class = "section-title", "4️⃣ Animations"),
      p(class = "section-description",
        "Two smooth animation styles for tooltip appearance."),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "Fade"),
          tooltip("anim_fade", "Smooth fade in/out", animation = "fade"),
          actionButton("anim_fade", "Fade", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Scale"),
          tooltip("anim_scale", "Scale up from center", animation = "scale"),
          actionButton("anim_scale", "Scale", class = "demo-button btn-primary-demo")
        )
      )
    ),
    
    # Sizing Section
    div(
      class = "section",
      h2(class = "section-title", "5️⃣ Sizing"),
      p(class = "section-description",
        "Use predefined sizes or specify custom dimensions."),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "Small"),
          tooltip("size_small", "Compact tooltip", size = "small"),
          actionButton("size_small", "Small", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Medium"),
          tooltip("size_medium", "Standard size tooltip", size = "medium"),
          actionButton("size_medium", "Medium", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Large"),
          tooltip("size_large", "Large tooltip with more space for content", size = "large"),
          actionButton("size_large", "Large", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Custom Width"),
          tooltip("size_custom", "This has a fixed width of 350px", width = "350px"),
          actionButton("size_custom", "Custom", class = "demo-button btn-primary-demo")
        )
      )
    ),
    
    # Styling Section
    div(
      class = "section",
      h2(class = "section-title", "6️⃣ Custom Styling"),
      p(class = "section-description",
        "Apply custom CSS styles to individual tooltips."),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "Success"),
          tooltip("style_success", "Success!", style = "background: #27ae60; color: white; font-weight: bold;"),
          actionButton("style_success", "Success", class = "demo-button btn-success-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Warning"),
          tooltip("style_warning", "Warning!", style = "background: #f39c12; color: white; font-weight: bold;"),
          actionButton("style_warning", "Warning", class = "demo-button btn-warning-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Danger"),
          tooltip("style_danger", "Danger!", style = "background: #e74c3c; color: white; font-weight: bold;"),
          actionButton("style_danger", "Danger", class = "demo-button btn-danger-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Gradient"),
          tooltip(
            "style_gradient",
            "Gradient style",
            style = "background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-weight: bold;"
          ),
          actionButton("style_gradient", "Gradient", class = "demo-button btn-info-demo")
        )
      )
    ),
    
    # Rich Content Section
    div(
      class = "section",
      h2(class = "section-title", "7️⃣ Rich Content with tagList"),
      p(class = "section-description",
        "Create complex, structured tooltip content with HTML elements."),
      
      div(class = "demo-group",
        div(class = "demo-item",
          div(class = "demo-label", "List"),
          tooltip(
            "rich_list",
            tagList(
              tags$strong("Features:"),
              tags$ul(
                tags$li("Feature 1"),
                tags$li("Feature 2"),
                tags$li("Feature 3")
              )
            ),
            width = "200px"
          ),
          actionButton("rich_list", "List", class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Info Card"),
          tooltip(
            "rich_card",
            tagList(
              tags$h4(style = "margin: 0; color: #3498db;", "Information"),
              tags$p(style = "margin: 5px 0;", "This is a tooltip with formatted content"),
              tags$hr(style = "margin: 10px 0;"),
              tags$small("Learn more at shinytooltips.io")
            ),
            width = "250px"
          ),
          actionButton("rich_card", "Card", class = "demo-button btn-success-demo")
        ),
        div(class = "demo-item",
          div(class = "demo-label", "Code"),
          tooltip(
            "rich_code",
            tagList(
              tags$pre(
                style = "background: #2c3e50; color: #ecf0f1; padding: 10px; border-radius: 4px; margin: 0;",
                tags$code("tooltip(\n  'btn',\n  'Hello!'\n)")
              )
            ),
            width = "250px"
          ),
          actionButton("rich_code", "Code", class = "demo-button btn-danger-demo")
        )
      )
    ),
    
    # Interactive Section
    div(
      class = "section",
      h2(class = "section-title", "8️⃣ Interactive Tooltips"),
      p(class = "section-description",
        "Create tooltips with inputs, forms, and interactive controls. Set interactive = TRUE."),
      
      div(class = "row-demo",
        div(class = "col-demo",
          h4("Settings Form"),
          tooltip(
            "inter_form",
            tagList(
              tags$h4(style = "margin-top: 0;", "Quick Settings"),
              tags$div(style = "margin: 10px 0;",
                tags$label("Name:", style = "display: block; font-weight: bold; margin-bottom: 5px;"),
                textInput("inter_name", NULL, placeholder = "Enter name", width = "100%")
              ),
              tags$div(style = "margin: 10px 0;",
                tags$label("Theme:", style = "display: block; font-weight: bold; margin-bottom: 5px;"),
                selectInput("inter_theme", NULL, choices = c("Light", "Dark"), width = "100%")
              ),
              tags$div(style = "margin-top: 15px;",
                actionButton("inter_submit", "Save", class = "btn btn-primary btn-sm", style = "width: 100%;")
              )
            ),
            width = "280px",
            placement = "right",
            interactive = TRUE,
            trigger = "click",
            style = "background: #fff; color: #2c3e50; border: 2px solid #667eea;"
          ),
          actionButton("inter_form", "Open Settings", class = "demo-button btn-info-demo")
        ),
        div(class = "col-demo",
          h4("Data Filter"),
          tooltip(
            "inter_filter",
            tagList(
              tags$h4(style = "margin-top: 0;", "Filter Data"),
              tags$div(style = "margin: 10px 0;",
                tags$label("Status:", style = "display: block; font-weight: bold;"),
                checkboxGroupInput("inter_status", NULL,
                  choices = c("Active", "Pending", "Done"),
                  selected = "Active", inline = FALSE)
              ),
              tags$div(style = "margin-top: 15px;",
                actionButton("inter_apply", "Apply", class = "btn btn-success btn-sm", style = "width: 100%;")
              )
            ),
            width = "250px",
            placement = "bottom",
            interactive = TRUE,
            trigger = "click"
          ),
          actionButton("inter_filter", "Open Filters", class = "demo-button btn-warning-demo")
        )
      ),
      
      div(class = "result-box",
        h4("Results:"),
        textOutput("interactive_result")
      )
    ),
    
    # Real-World Examples Section
    div(
      class = "section",
      h2(class = "section-title", "9️⃣ Real-World Examples"),
      p(class = "section-description",
        "Practical examples you can use in your own applications."),
      
      h4("Form with Contextual Help"),
      div(class = "row-demo",
        div(class = "col-demo",
          tooltip("example_email", "Enter a valid email address", placement = "right", trigger = "focus"),
          textInput("example_email", "Email:", width = "100%")
        ),
        div(class = "col-demo",
          tooltip("example_pass", "Minimum 8 characters", placement = "right", trigger = "focus"),
          passwordInput("example_pass", "Password:", width = "100%")
        )
      ),
      
      h4(style = "margin-top: 30px;", "Dashboard Controls"),
      div(class = "demo-group",
        div(class = "demo-item",
          tooltip("dash_refresh", "Reload data from server", placement = "top", trigger = "hover"),
          actionButton("dash_refresh", icon("refresh"), class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          tooltip("dash_export", "Download as CSV", placement = "top", trigger = "hover"),
          actionButton("dash_export", icon("download"), class = "demo-button btn-primary-demo")
        ),
        div(class = "demo-item",
          tooltip("dash_settings", "Open settings", placement = "top", trigger = "hover"),
          actionButton("dash_settings", icon("cog"), class = "demo-button btn-primary-demo")
        )
      )
    ),
    
    # Best Practices Section
    div(
      class = "section",
      h2(class = "section-title", "💡 Best Practices"),
      
      tags$ul(
        tags$li("Keep tooltip content concise (1-2 lines when possible)"),
        tags$li("Use appropriate placements to avoid overlapping content"),
        tags$li("Choose triggers based on element type (hover for buttons, focus for inputs)"),
        tags$li("Don't hide critical information in tooltips alone"),
        tags$li("Test on mobile devices for touch compatibility"),
        tags$li("Use interactive = TRUE for tooltips with inputs or controls"),
        tags$li("Apply consistent styling across related tooltips"),
        tags$li("Consider accessibility when using custom colors and styles")
      )
    ),
    
    # Footer
    div(
      class = "footer",
      p(tags$strong("shinyTooltips v0.2.0"), " - Modern Interactive Tooltips for Shiny"),
      p("Lightweight • Customizable • Interactive • Accessible"),
      p(
        "GitHub: ",
        tags$a(href = "https://github.com/yourusername/shinyTooltips", "shinyTooltips", target = "_blank"),
        " | Documentation: ",
        tags$a(href = "#", "Guide", target = "_blank")
      )
    )
  )
)

# Server function
server <- function(input, output, session) {
  output$interactive_result <- renderText({
    parts <- c()
    if (!is.null(input$inter_submit) && input$inter_submit > 0) {
      if (nchar(input$inter_name) > 0) {
        parts <- c(parts, paste("Name:", input$inter_name))
      }
      parts <- c(parts, paste("Theme:", input$inter_theme))
    }
    if (!is.null(input$inter_apply) && input$inter_apply > 0) {
      parts <- c(parts, paste("Status:", paste(input$inter_status, collapse = ", ")))
    }
    if (length(parts) == 0) {
      return("No data submitted yet - try opening the tooltips above!")
    }
    paste(parts, collapse = " | ")
  })
}

# Run the app
shinyApp(ui, server)
