# Load libraries and options
library(knitr)
library(here)
library(tidyverse)
library(fontawesome)
library(cowplot)
library(kableExtra)

options(dplyr.width = Inf)
options(knitr.kable.NA = '')
knitr::opts_chunk$set(
    warning    = FALSE,
    message    = FALSE,
    comment    = "#>",
    fig.width  = 6,
    fig.height = 4,
    fig.align  = "center",
    fig.path   = "figs/",
    fig.retina = 3
)

# Load custom functions
get_schedule <- function() {
    
    # Get raw schedule
    schedule_url <- 'https://docs.google.com/spreadsheets/d/1heQ9ylgQ8Ok2MjIAGPRy8kdMnnyojuQFGxek9oFXF9Y/edit?usp=sharing'
    df <- gsheet::gsheet2tbl(schedule_url) %>% 
        mutate(
            class_stub = str_to_lower(class_name), 
            class_stub = str_replace_all(class_stub, " & ", "-"),
            class_stub = str_replace_all(class_stub, " ", "-"),
            assign_stub = str_to_lower(assign_name), 
            assign_stub = str_replace_all(assign_stub, " & ", "-"),
            assign_stub = str_replace_all(assign_stub, " ", "-"),
            mini_stub = str_to_lower(mini_name), 
            mini_stub = str_replace_all(mini_stub, " & ", "-"),
            mini_stub = str_replace_all(mini_stub, " ", "-"),
            final_stub = str_to_lower(final_name), 
            final_stub = str_replace_all(final_stub, " & ", "-"),
            final_stub = str_replace_all(final_stub, " ", "-"),
        )
    
    # Weekly assignment vars
    assignments <- df %>% 
        filter(!is.na(assign_name)) %>% 
        mutate(assign_due = format(assign_due, format = "%b %d")) %>% 
        select(week, starts_with("assign_"))
    
    # Mini project vars
    mini <- df %>%
        filter(!is.na(mini_name)) %>% 
        mutate(
            mini_n = row_number(),
            mini_due = format(as.Date(mini_due), format = "%b %d"),
            mini_stub = paste0(mini_n, "-", mini_stub)
        ) %>% 
        select(week, starts_with("mini_"))
    
    # Final project vars
    final <- df %>%
        filter(!is.na(final_name)) %>% 
        mutate(
            final_n = row_number(),
            final_due = format(as.Date(final_due), format = "%b %d"),
            final_stub = paste0(final_n, "-", final_stub)
        ) %>% 
        select(week, starts_with("final_"))

    # Class vars
    class <- df %>%
        mutate(
            date_raw = date,
            date = format(date, format = "%b %d"),
            # Replace NA values with ""
            class_description = ifelse(
                is.na(class_description), "", class_description),
            class_stub = paste0(class_n, "-", class_stub)
        ) %>% 
        select(week, starts_with("class_"))
    
    # Final schedule data frame
    schedule <- df %>% 
        left_join(class, by = "week") %>% 
        left_join(assignments, by = "week") %>% 
        left_join(mini, by = "week") %>% 
        left_join(final, by = "week")
    
    return(schedule)
    
}
