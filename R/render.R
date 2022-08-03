library(quarto)
library(renderthis)

# Render readme
rmarkdown::render(input = 'README.Rmd', output_format = 'github_document')

# Render slides 
# parts <- c(
#     'storytelling',
#     'visualizing-information'
# )
# for (part in parts) {
#     to_html(
#         from = file.path('parts', part, 'index.Rmd'),
#         to = file.path('parts', part, 'index.html')
#     )
#     to_pdf(
#         from = file.path('parts', part, 'index.html'),
#         to = file.path('parts', part, paste0(part, '.pdf')),
#         partial_slides = TRUE
#     )
# }

# Render site
quarto_render()
