# Load class settings & functions
source(here::here("R", "settings.R"))

schedule <- get_schedule()

# Starting content string
start <- 
'project:
  type: website
  output-dir: _site
  preview:
    port: 5896
    browser: true
  render:
    - "*.qmd"
    - "!fragments/"

website:
  image: images/logo.png
  site-url: https://eda.seas.gwu.edu/2022-Fall/
  favicon: images/favicon.ico
  repo-url: https://github.com/emse-eda-gwu/2022-Fall
  description: \'Course website for Fall 2022 semester of the EMSE course "Marketing Analytics for Design Decisions" at GWU\'
  search: true
  open-graph: true
  twitter-card:
    site: "@johnhelveston"
  navbar:
    background: primary
    left:
      - text: Home
        href: index.qmd
      - text: Syllabus
        href: syllabus.qmd
      - text: "Schedule"
        href: schedule.qmd
      - text: Class
        menu:'

# Class class string
class <- schedule %>% 
    mutate(
        text = paste0(
            '        - text: "', format(date, "%b %d"), ": ", name, '"' 
        ), 
        href = paste0(
            "          href: ", "class/", n, "-", stub, ".qmd\n"
        ),
        href = ifelse(is.na(stub), "", href), 
        class = paste(text, href, sep = "\n")
    )
class <- class$class
# Add final interviews
class <- c(
    class,
    '        - text: "Final Interviews"
          href: class/interviews.qmd
')
class <- paste0(class, collapse = "")

# Assignment string
assignment <- schedule %>%
    mutate(
        date = lag(date, 1), 
        due = format(date + 6, "%m/%d")
    ) %>% 
    filter(!is.na(date)) %>% 
    filter(!is.na(stub)) %>% 
    mutate(
        n = row_number(),
        text = paste0(
            '        - text: "', format(date, "%b %d"), ": ", name,
            " (Due ", due, ')"'
        ), 
        href = paste0(
            "          href: ", "hw/", n, "-", stub, ".qmd\n"
        ),
        href = ifelse(is.na(stub), "", href), 
        assignment = paste(text, href, sep = "\n")
    )
assignment <- assignment$assignment
# Remove last "\n"
assignment[length(assignment)] <- str_sub(assignment[length(assignment)], 1, -2)
# Insert primer assignment
assignment <- c(
'        - text: "Course Primer (optional)"
          href: hw/0-course-primer.qmd
',
    assignment
)
assignment <- paste0(assignment, collapse = "")

# Mini projects string
mini <- schedule %>%
    filter(!is.na(project_mini)) %>% 
    mutate(
        n = row_number(),
        due = format(as.Date(project_due), "%m/%d"),
        text = paste0(
            '        - text: "', project_mini, " (Due ", due, ')"'
        ), 
        href = paste0(
            "          href: ", "project-mini/", n, "-", project_stub, ".qmd\n"
        ),
        mini = paste(text, href, sep = "\n")
    )
mini <- mini$mini
# Remove last "\n"
mini[length(mini)] <- str_sub(mini[length(mini)], 1, -2)
mini <- paste0(mini, collapse = "")

# Final projects string
final <- schedule %>%
    filter(!is.na(project_final)) %>% 
    mutate(
        n = row_number(),
        due = format(as.Date(project_due), "%m/%d"),
        text = paste0(
            "        - text: ", project_final, " (Due ", due, ")"
        ), 
        href = paste0(
            "          href: ", "project-final/", n, "-", project_stub, ".qmd\n"
        ),
        final = paste(text, href, sep = "\n")
    )
final <- final$final
# Remove last "\n"
final[length(final)] <- str_sub(final[length(final)], 1, -2)
# Insert project overview
final <- c(
    '        - text: "Project Overview"
          href: project-final/0-overview.qmd
',
    final
)
final <- paste0(final, collapse = "")

# Help string 
help <- 
'      - text: Help
        menu:
        - text: Schedule a call w/Prof. Helveston
          href: help/https://jhelvy.appointlet.com/b/professor-helveston
        - text: Course Software
          href: help/course-software.qmd
        - text: Getting Help
          href: help/getting-help.qmd
        - text: Example Projects
          href: help/example-projects.qmd
        - text: Finding Data
          href: help/finding-data.qmd
        - text: Visualizing Data
          href: help/visualizing-data.qmd
        - text: Programming in R
          href: help/programming.qmd
        - text: R Markdown
          href: help/rmarkdown.qmd
        - text: Other
          href: help/other.qmd'

# End content string
end <- 
'      - icon: slack
        href: https://emse-eda-f22.slack.com
    right:
    - icon: fas fa-bars
      menu:
      - text: About
        href: about.qmd
      - text: License
        href: LICENSE.qmd
      - text: Contact
        href: mailto:jph@gwu.edu
      - icon: github
        href: https://github.com/emse-eda-gwu/2022-Fall/
  page-footer:
    center:
      - text: \'EMSE 4572: Exploratory Data Analysis (Fall 2022)<br><i class="far fa-calendar-alt"></i> Wednesdays | <i class="far fa-clock"></i> 12:45 - 3:15 PM EST | <a href="https://acadtech.gwu.edu/location?id=373&campus=FB&type=building&selection=36"><i class="fa fa-map-marker-alt"></i> 1776 G St C-119</a> | <a href="https://www.jhelvy.com"><i class="fas fa-user"></i> Dr. John Paul Helveston</a> | <a href="mailto:jph@gwu.edu"><i class="fas fa-envelope"></i> jph@gwu.edu</a>\'

format:
  html:
    theme: cosmo
    css: styles.css
    anchor-sections: true
    smooth-scroll: true
    link-external-newwindow: true
    include-in-header: "_includes/header.html"
'

# Combine
yml <- c(
    start, 
    class,
    '      - text: "Assignments"
        menu:',
    assignment, 
    '      - text: "Mini Projects"
        menu:',
    mini,
    '      - text: "Final Project"
        menu:',
    final,
    help,
    end,
    collapse = ""
)

# Write _quarto.yml file
fileConn <- file("_quarto.yml")
writeLines(yml, fileConn)
close(fileConn)

