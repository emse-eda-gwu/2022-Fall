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

clean_schedule_name <- function(x) {
    x <- x %>%
        str_to_lower() %>%
        str_replace_all(" & ", "-") %>%
        str_replace_all(" ", "-")
    return(x)
}

# Load custom functions

get_schedule <- function() {
    
    # Get raw schedule
    schedule_url <- 'https://docs.google.com/spreadsheets/d/1heQ9ylgQ8Ok2MjIAGPRy8kdMnnyojuQFGxek9oFXF9Y/edit?usp=sharing'
    df <- gsheet::gsheet2tbl(schedule_url) %>% 
        mutate(
            class_stub  = clean_schedule_name(class_name),
            assign_stub = clean_schedule_name(assign_name),
            mini_stub   = clean_schedule_name(mini_name),
            final_stub  = clean_schedule_name(final_name)
        )
    
    # Weekly assignment vars
    assignments <- df %>% 
        filter(!is.na(assign_name)) %>% 
        mutate(
            assign_due_md = format(assign_due, format = "%b %d"),
            assign_stub = paste0(assign_n, "-", assign_stub)
        ) %>% 
        select(week, starts_with("assign_"))
    
    # Mini project vars
    mini <- df %>%
        filter(!is.na(mini_name)) %>% 
        mutate(
            mini_n = row_number(),
            mini_due_md = format(as.Date(mini_due), format = "%b %d"),
            mini_stub = paste0(mini_n, "-", mini_stub)
        ) %>% 
        select(week, starts_with("mini_"))
    
    # Final project vars
    final <- df %>%
        filter(!is.na(final_name)) %>% 
        mutate(
            final_n = row_number(),
            final_due_md = format(as.Date(final_due), format = "%b %d"),
            final_stub = paste0(final_n, "-", final_stub)
        ) %>% 
        select(week, starts_with("final_"))

    # Class vars
    class <- df %>%
        mutate(
            # Replace NA values with ""
            class_description = ifelse(
                is.na(class_description), "", class_description),
            class_stub = ifelse(
                is.na(class_n), class_stub, 
                paste0(class_n, "-", class_stub))
        ) %>% 
        select(week, starts_with("class_"))
    
    # Final schedule data frame
    schedule <- df %>% 
        select(week, date, theme, quiz) %>% 
        mutate(date_md = format(date, format = "%b %d")) %>% 
        left_join(class, by = "week") %>% 
        left_join(assignments, by = "week") %>% 
        left_join(mini, by = "week") %>% 
        left_join(final, by = "week")
    
    return(schedule)
    
}

get_due_dates <- function() {
    schedule <- get_schedule()
    assign <- schedule %>%
        select(starts_with("assign")) %>%
        filter(!is.na(assign_n)) %>% 
        mutate(type = 'hw') %>% 
        select(type, assign_n, assign_name, assign_stub, assign_due)
    mini <- schedule %>%
        select(starts_with("mini")) %>%
        filter(!is.na(mini_n)) %>% 
        mutate(type = 'project-mini') %>% 
        select(type, mini_n, mini_name, mini_stub, mini_due)
    final <- schedule %>%
        select(starts_with("final")) %>%
        filter(!is.na(final_n)) %>% 
        mutate(type = 'project-final') %>% 
        select(type, final_n, final_name, final_stub, final_due)
    names(assign) <- c('type', 'n', 'name', 'stub', 'due')
    names(mini) <- c('type', 'n', 'name', 'stub', 'due')
    names(final) <- c('type', 'n', 'name', 'stub', 'due')
    due <- rbind(assign, mini, final)
    return(due)
}
