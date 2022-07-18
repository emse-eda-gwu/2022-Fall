library(quarto)
library(renderthis)

# Render the yml 
source(here::here('R', 'make_yml.R'))

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
