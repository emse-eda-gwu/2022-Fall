lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Build the slides
renderthis::to_html("index.Rmd", "index.html")
renderthis::to_pdf("index.html", paste0(lesson, ".pdf"))

# Create zip files of class notes
zip::zip(
    zipfile = paste0(lesson, ".zip"),
    files = c(
        'data',
        'caseConverter_solution.R',
        'caseConverter.R',
        'federalSpending.R',
        'federalSpendingCompare.R',
        'html.R',
        'internetUsers_solution.R',
        'internetUsers.R',
        'markdown.R',
        'mpg.R',
        'shinyWidgets.R',
        'widgets.R',
        paste0(lesson, ".Rproj"))
)
