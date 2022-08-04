# Load class settings & functions
source(here::here("R", "settings.R"))

df <- get_schedule()

# Class class string
class <- df %>% 
    mutate(
        text = paste0(
            '        - text: "', format(date, "%b %d"), ": ", name, '"' 
        ), 
        href = paste0(
            "          href: ", "class/", class_stub, ".qmd\n"
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
# Remove last "\n"
class <- str_sub(class[length(class)], 1, -2)

# Assignment string
assignment <- schedule %>%
    filter(!is.na(assign_due)) %>% 
    mutate(
        text = paste0(
            '        - text: "', format(date, "%b %d"), ": ", assign_name,
            " (Due ", assign_due, ')"'
        ), 
        href = paste0(
            "          href: ", "hw/", assign_stub, ".qmd\n"
        ),
        href = ifelse(is.na(assign_stub), "", href), 
        assignment = paste(text, href, sep = "\n")
    )
assignment <- assignment$assignment
# Insert primer assignment
assignment <- c(
'        - text: "Course Primer (optional)"
          href: hw/0-course-primer.qmd
',
    assignment
)
assignment <- paste0(assignment, collapse = "")
# Remove last "\n"
assignment <- str_sub(assignment[length(assignment)], 1, -2)

# Mini projects string
mini <- schedule %>%
    filter(!is.na(project_mini)) %>% 
    mutate(
        text = paste0(
            '        - text: "', mini_name, " (Due ", mini_due, ')"'
        ), 
        href = paste0(
            "          href: ", "project-mini/", mini_stub, ".qmd\n"
        ),
        mini = paste(text, href, sep = "\n")
    )
mini <- mini$mini
mini <- paste0(mini, collapse = "")
# Remove last "\n"
mini <- str_sub(mini[length(mini)], 1, -2)
    
# Final projects string
final <- schedule %>%
    filter(!is.na(project_final)) %>% 
    mutate(
        text = paste0(
            "        - text: ", final_name, " (Due ", final_due, ")"
        ), 
        href = paste0(
            "          href: ", "project-final/", final_stub, ".qmd\n"
        ),
        final = paste(text, href, sep = "\n")
    )
final <- final$final
# Insert project overview
final <- c(
    '        - text: "Project Overview"
          href: project-final/0-overview.qmd
',
    final
)
final <- paste0(final, collapse = "")
# Remove last "\n"
final <- str_sub(final[length(final)], 1, -2)

# Help string 
help <- 
'      - text: Help
        menu:
        - text: Schedule a call w/Prof. Helveston
          href: https://jhelvy.appointlet.com/b/professor-helveston
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
        href: "{{< var slack >}}"
    right:
    - icon: list
      menu:
      - text: About
        href: about.qmd
      - text: License
        href: LICENSE.qmd
      - text: Contact
        href: mailto:jph@gwu.edu
      - icon: github
        href: "{{< var repo >}}"
  page-footer:
    center:
      - text: \'{{< var title >}} <br><i class="far fa-calendar-alt"></i> {{< var weekday >}} | <i class="far fa-clock"></i> {{< var time >}} | <a href="{{< var room_url >}}"><i class="fa fa-map-marker-alt"></i> {{< var room >}}</a> | <a href="https://www.jhelvy.com"><i class="fas fa-user"></i> Dr. John Paul Helveston</a> | <a href="mailto:jph@gwu.edu"><i class="fas fa-envelope"></i> jph@gwu.edu</a> | <a href="{{< var repo >}}"><i class="fab fa-github"></i></a>\'

format:
  html:
    theme: cosmo
    css: styles.css
    anchor-sections: true
    smooth-scroll: true
    link-external-newwindow: true
    include-in-header: "_includes/header.html"'

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
