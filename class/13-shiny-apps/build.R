lesson <- "14-shiny-apps"

# Build the slides
xaringanBuilder::build_html("index.Rmd", "index.html")
xaringanBuilder::build_pdf("index.html", paste0(lesson, ".pdf"))

# Create zip files of class notes
zip::zip(
    zipfile = paste0(lesson, ".zip"),
    files = c(
        'data',
        paste0(lesson, ".Rproj")))

zip::zip_append(
    zipfile = paste0(lesson, ".zip"),
    files = file.path("apps", list.files("apps")),
    mode = "cherry-pick")
