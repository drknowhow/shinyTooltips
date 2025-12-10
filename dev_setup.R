# Development Helper Script
# Run this script to build, check, and install the package

# 1. Load development tools
library(devtools)
library(roxygen2)

# 2. Document the package (generate man files and update NAMESPACE)
cat("📝 Documenting package...\n")
document()

# 3. Check the package
cat("\n🔍 Checking package...\n")
check()

# 4. Build the package
cat("\n📦 Building package...\n")
build()

# 5. Install the package
cat("\n⚙️ Installing package...\n")
install()

cat("\n✅ Done! You can now load the package with: library(shinyTooltips)\n")
cat("🚀 Run demo with: shiny::runApp(system.file('examples/demo_app.R', package='shinyTooltips'))\n")
