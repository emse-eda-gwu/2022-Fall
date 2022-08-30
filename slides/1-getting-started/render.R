lesson <- '1-getting-started'

# Build the slides
renderthis::to_html("index.Rmd", "index.html")
renderthis::to_pdf("index.html", paste0(lesson, ".pdf"))

# Create zip files of class notes
zip::zip(
    zipfile = paste0(lesson, ".zip"),
    files = c(
        'data',
        'practice.Rmd',
        'practice-solutions.Rmd',
        paste0(lesson, ".Rproj")))
