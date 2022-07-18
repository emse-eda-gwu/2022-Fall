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

# Load class settings
settings <- list(
    semester = 'Fall 2022',
    repo     = "https://github.com/emse-eda-gwu/2022-Fall",
    site_url = "https://eda.seas.gwu.edu/2022-Fall/",
    title    = "EMSE 4572: Exploratory Data Analysis (Fall 2022)",
    weekday  = "Wednesdays",
    time     = "12:45PM - 3:15PM EST",
    room     = '1776 G St C-119',
    room_url = "https://acadtech.gwu.edu/location?id=373&campus=FB&type=building&selection=36",
    schedule_url = 'https://docs.google.com/spreadsheets/d/1heQ9ylgQ8Ok2MjIAGPRy8kdMnnyojuQFGxek9oFXF9Y/edit?usp=sharing',
    dates = "Aug. 29 - Dec. 12, 2022",
    slack = "https://emse-eda-f22.slack.com"
)

# Load custom functions
get_schedule <- function() {
    
    # Get raw schedule
    schedule <- gsheet::gsheet2tbl(settings$schedule_url)
    
    # Make assignment vars
    assignments <- schedule %>% 
        filter(assignment == 1) %>% 
        mutate(
            assign_n = row_number(),
            assign_due = format(lead(date, 1) - 1, format = "%b %d"),
            assign_name = lead(name, 1),
            assign_name = ifelse(is.na(assign_name), "", assign_name),
            assign_stub = paste0(assign_n, "-", lead(stub, 1)), 
        ) %>% 
        filter(!is.na(assign_due)) %>% 
        select(week, starts_with("assign_"))
    
    # Make project vars
    mini <- schedule %>%
        filter(!is.na(project_mini)) %>% 
        mutate(
            mini_n = row_number(),
            mini_name = project_mini,
            mini_due = format(as.Date(project_due_mini), format = "%b %d"),
            mini_stub = paste0(mini_n, "-", project_stub_mini)
        ) %>% 
        select(week, starts_with("mini_"))
    
    final <- schedule %>%
        filter(!is.na(project_final)) %>% 
        mutate(
            final_n = row_number(),
            final_name = project_final,
            final_due = format(as.Date(project_due_final), format = "%b %d"),
            final_stub = paste0(final_n, "-", project_stub_final)
        ) %>% 
        select(week, starts_with("final_"))

    # Class vars
    class <- schedule %>%
        mutate(
            date_raw = date,
            date = format(date, format = "%b %d"),
            # Replace NA values with ""
            class_description = ifelse(is.na(description), "", description),
            class_stub = ifelse(is.na(stub), "", paste0(n, "-", stub))
        ) %>% 
        select(week, starts_with("class_"))
    
    schedule <- schedule %>% 
        left_join(class, by = "week") %>% 
        left_join(assignments, by = "week") %>% 
        left_join(mini, by = "week") %>% 
        left_join(final, by = "week")
    
    return(schedule)
    
}
