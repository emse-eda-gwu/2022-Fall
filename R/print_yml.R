# Load the schedule googlesheet and prints formatted yml 
# code to copy-paste into the _quarto.yml file

# Load class settings & functions
source(here::here("R", "settings.R"))

df <- get_schedule()

# Class class string
class <- df %>% 
    mutate(
        text = paste0('        - text: "', date_md, ": ", class_name, '"'),
        href = paste0("          href: ", "class/", class_stub, ".qmd\n"),
        href = ifelse(is.na(class_n), "", href), 
        class = paste(text, href, sep = "\n")
    )
class <- class$class
# Add final interviews
class <- c(class,
'        - text: "Final Interviews"
          href: class/interviews.qmd
')
class <- paste0(class, collapse = "")
# Remove last "\n"
class <- str_sub(class[length(class)], 1, -2)

# Assignment string
assignment <- df %>%
    filter(!is.na(assign_due)) %>% 
    mutate(
        text = paste0(
            '        - text: "', date_md, ": ", assign_name,
            " (Due ", assign_due, ')"'
        ), 
        href = paste0(
            "          href: ", "hw/", assign_n, "-", assign_stub, 
            ".qmd\n"),
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
mini <- df %>%
    filter(!is.na(mini_name)) %>% 
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
final <- df %>%
    filter(!is.na(final_name)) %>% 
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

# Print results for copy-pasting to _quarto.yml

cat(class)
cat(assignment)
cat(mini)
cat(final)

