library(tidyverse)
library(here)
library(cowplot)
library(waffle)

avengers         <- read_csv(here('data', 'avengers.csv'))
bears            <- read_csv(here('data', 'north_america_bear_killings.csv'))
federal_spending <- read_csv(here('data', 'federal_spending_long.csv'))
gapminder        <- read_csv(here('data', 'gapminder.csv'))
lotr_words       <- read_csv(here('data', 'lotr_words.csv'))
milk_production  <- read_csv(here('data', 'milk_production.csv'))
wildlife_impacts <- read_csv(here('data', 'wildlife_impacts.csv'))

# Federal spending ------------------------------------------------------

federal_spending_summary <- federal_spending %>%
    group_by(department) %>%
    summarise(rd_budget_bil = sum(rd_budget_mil) / 10^3) %>%
    mutate(department = fct_reorder(department, rd_budget_bil))

federal_spending_summary_highlight <- federal_spending_summary %>% 
    mutate(
        department = fct_reorder(department, rd_budget_bil),
        is_dod = if_else(department == 'DOD', TRUE, FALSE))

federal_spending_bars_unsorted <- federal_spending %>%
    group_by(department) %>%
    summarise(rd_budget_bil = sum(rd_budget_mil) / 10^3) %>%
    ggplot() +
    geom_col(aes(x = rd_budget_bil, y = department),
             width = 0.7, alpha = 0.8, fill = 'steelblue') +
    scale_x_continuous(expand = expansion(mult = c(0, 0.05))) +
    theme_minimal_vgrid()

federal_spending_bars <- federal_spending_summary %>%
    ggplot() +
    geom_col(aes(x = rd_budget_bil, y = department),
             width = 0.7, alpha = 0.8, fill = 'steelblue') +
    scale_x_continuous(expand = expansion(mult = c(0, 0.05))) +
    theme_minimal_vgrid()

federal_spending_bars_top5 <- federal_spending %>%
  mutate( 
    department = fct_other(department, 
      keep = c('DOD', 'HHS', 'NIH', 'NASA', 'DOE'))) %>% 
  group_by(department) %>%
  summarise(rd_budget_bil = sum(rd_budget_mil) / 10^3) %>%
  mutate(department = fct_reorder(department, rd_budget_bil)) %>% 
  ggplot() +
  geom_col(aes(x = rd_budget_bil,
               y = department), 
           width = 0.7, alpha = 0.8,
           fill = "steelblue") +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid()

federal_spending_dots <- federal_spending_summary %>%
    ggplot() +
    geom_point(aes(x = rd_budget_bil, y = department),
               size = 2.5, color = 'steelblue') +
    theme_minimal_vgrid()

federal_spending_lollipop <- federal_spending_summary %>%
    ggplot() +
    geom_segment(aes(x = 0, xend = rd_budget_bil,
                     y = department, yend = department),
                 color = 'grey') +
    geom_point(aes(x = rd_budget_bil, y = department),
               size = 2.5, color = 'steelblue') +
    scale_x_continuous(expand = expansion(mult = c(0, 0.05))) +
    theme_minimal_vgrid()

federal_spending_bars_highlight_badcolor <- federal_spending_summary_highlight %>% 
    ggplot() +
    geom_col(aes(x = rd_budget_bil, department,
                 fill = is_dod), 
             width = 0.7, alpha = 0.8) +
    scale_x_continuous(expand = expansion(mult = c(0, 0.05))) +
    theme_minimal_vgrid() +
    theme(legend.position = 'none')

federal_spending_bars_highlight <- federal_spending_summary_highlight %>% 
    ggplot() +
    geom_col(aes(x = rd_budget_bil, department,
                 fill = is_dod), 
             width = 0.7, alpha = 0.8) +
    scale_fill_manual(values = c('grey', 'steelblue')) +
    scale_x_continuous(expand = expansion(mult = c(0, 0.05))) +
    theme_minimal_vgrid() +
    theme(legend.position = 'none')

federal_spending_bars_highlight_title <- federal_spending_summary_highlight %>% 
    ggplot() +
    geom_col(aes(x = rd_budget_bil, department,
                 fill = is_dod), 
             width = 0.7, alpha = 0.8) +
    scale_fill_manual(values = c('grey', 'steelblue')) +
    scale_x_continuous(expand = expansion(mult = c(0, 0.05))) +
    theme_minimal_vgrid() +
    theme(legend.position = 'none') + 
    labs(x = "Total R&D spending from 1976 to 2017 ($Billions)", 
         y = NULL, 
         title = "The DOD's R&D budget is nearly the\nsame as all other departments combined")

ggsave(here('figs', 'federal_spending_bars_unsorted.png'),
       federal_spending_bars_unsorted, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_bars.png'),
       federal_spending_bars, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_bars_top5.png'),
       federal_spending_bars_top5, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_dots.png'),
       federal_spending_dots, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_lollipop.png'),
       federal_spending_lollipop, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_bars_highlight.png'),
       federal_spending_bars_highlight, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_bars_highlight_title.png'),
       federal_spending_bars_highlight_title, width = 6, height = 4)
ggsave(here('figs', 'federal_spending_bars_highlight_badcolor.png'),
       federal_spending_bars_highlight_badcolor, width = 6, height = 4)

# gapminder --------------------------------------------------------

gapminder_americas <- gapminder %>%
    filter(year == 2007, continent == "Americas") %>%
    mutate(country = fct_reorder(country, lifeExp))

life_expectancy_bars <- gapminder_americas %>% 
    ggplot() +
    geom_col(aes(x = lifeExp, y = country),
             fill = 'steelblue', alpha = 0.9) +
    scale_x_continuous(
        expand = expansion(mult = c(0, 0.05)),
        limits = c(0, 85)) +
    theme_minimal_vgrid() +
    labs(
        x = 'Country',
        y = 'Life expectancy (years)')

life_expectancy_lollipop <- gapminder_americas %>% 
    ggplot() +
    geom_segment(aes(x = 0, xend = lifeExp,
                     y = country, yend = country), 
                 color = 'grey') +
    geom_point(aes(x = lifeExp, y = country),
               color = 'steelblue', alpha = 0.9, size = 2.5) +
    scale_x_continuous(
        expand = expansion(mult = c(0, 0.05)),
        limits = c(0, 85)) +
    theme_minimal_vgrid() +
    labs(
        x = 'Country',
        y = 'Life expectancy (years)')

life_expectancy_dots <- gapminder_americas %>% 
    ggplot() +
    geom_point(aes(x = lifeExp, y = country),
               color = 'steelblue', size = 2.5) +
    theme_minimal_vgrid() +
    labs(x = 'Country',
         y = 'Life expectancy (years)')

ggsave(here('figs', 'life_expectancy_bars.png'),
       life_expectancy_bars, width = 6, height = 6)
ggsave(here('figs', 'life_expectancy_lollipop.png'),
       life_expectancy_lollipop, width = 6, height = 6)
ggsave(here('figs', 'life_expectancy_dots.png'),
       life_expectancy_dots, width = 6, height = 6)

# milk production --------------------------------------------------------

milk_summary <- milk_production %>%
  filter(year == 2017) %>%
  mutate(
    milk_produced = milk_produced / 10^9,
    state = fct_reorder(state, milk_produced))

milk_bars <- ggplot(milk_summary) +
  geom_col(aes(x = milk_produced, y = state),
           width = 0.7, alpha = 0.8, fill = 'steelblue') +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid() +
  labs(x = 'Milk produced (billions lbs)',
       y = 'State')

milk_dots <- ggplot(milk_summary) +
  geom_point(aes(x = milk_produced, y = state),
             size = 2.5, color = 'steelblue') +
  theme_minimal_vgrid() +
  labs(x = 'Milk produced (billions lbs)',
       y = 'State')

milk_lollipop <- ggplot(milk_summary) +
  geom_segment(aes(x = 0, xend = milk_produced, 
                   y = state, yend = state),
               color = 'grey') +
  geom_point(aes(x = milk_produced, y = state),
             size = 2.5, color = 'steelblue') +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid() +
  labs(x = 'Milk produced (billions lbs)',
       y = 'State')

milk_2017_bars_stacked <- milk_production %>%
  filter(year == 2017) %>% 
  mutate(state = fct_other(state,
    keep = c('California', 'Wisconsin'))) %>%
  group_by(state) %>% #<<
  summarise(milk_produced = sum(milk_produced)) %>% 
  ggplot() +
  geom_col(aes(x = "", y = milk_produced, fill = state), #<<
           width = 0.7, alpha = 0.8) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_hgrid() +
  labs(x = NULL,
       y = 'Milk produced (lbs)',
       fill = 'State',
       title = '2017 Milk Production\nby State')

milk_2017_bars_stacked_rotated <- milk_2017_bars_stacked + 
  coord_flip() + 
  labs(title = '2017 Milk Production by State')

milk_2017_bars_stacked_toomany <- milk_production %>%
  filter(year == 2017) %>%
  mutate(state = fct_other(state, #<<
    keep = c('California', 'Wisconsin', #<<
             'New York', 'Idaho'))) %>% #<<
  group_by(state) %>%
  summarise(milk_produced = sum(milk_produced)) %>% 
  ggplot() +
  geom_col(aes(x = "", y = milk_produced, fill = state),
           width = 0.7, alpha = 0.8) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid() +
  labs(x = NULL,
       y = 'Milk produced (lbs)',
       fill = 'State',
       title = '2017 Milk Production\nby State')

milk_2017_bars_dodged <- milk_production %>%
  filter(year == 2017) %>%
  mutate(state = fct_other(state,
    keep = c('California', 'Wisconsin'))) %>%
  group_by(state) %>%
  summarise(milk_produced = sum(milk_produced)) %>%
  mutate(state = fct_reorder(state, milk_produced)) %>% 
  ggplot() +
  geom_col(aes(x = milk_produced, state), #<<
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid() +
  labs(x = 'Milk produced (lbs)',
       y = 'State',
       title = '2017 Milk Production by State')
  
milk_compare_bars_stacked <- milk_production %>%
  filter(year %in% c(1970, 2017)) %>% #<<
  mutate(state = fct_other(state,
    keep = c('California', 'Wisconsin'))) %>%
  group_by(year, state) %>% #<<
  summarise(milk_produced = sum(milk_produced)) %>% 
  ggplot() +
  geom_col(aes(x = milk_produced, 
               y = as.factor(year), #<<
               fill = state),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid() +
  labs(x = 'Milk produced (lbs)',
       y = 'Year',
       fill = 'State',
       title = '1970 & 2017 Milk Production by State')

milk_compare_bars_dodged <- milk_production %>%
  filter(year %in% c(1970, 2017)) %>% #<<
  mutate(state = fct_other(state,
    keep = c('California', 'Wisconsin'))) %>%
  group_by(year, state) %>% #<<
  summarise(milk_produced = sum(milk_produced)) %>% 
  ggplot() +
  geom_col(aes(x = milk_produced,
               y = as.factor(year),
               fill = state),
           position = 'dodge', #<<
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid() +
  labs(x = 'Milk produced (lbs)',
       y = 'Year',
       fill = 'State',
       title = '1970 & 2017 Milk Production by State')

# Format the data
milk_waffle_2017 <- milk_production %>%
  filter(year == 2017) %>%
  mutate(state = fct_other(state,
    keep = c('California', 'Wisconsin'))) %>%
  group_by(state) %>%
  summarise(milk_produced = sum(milk_produced)) %>%
  mutate(milk_produced = milk_produced / 10^9) %>%
  ggplot() +
  geom_waffle( #<<
    aes(fill = state, values = milk_produced), #<<
    color = "white", size = 1, n_rows = 15) + #<<
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  theme_minimal() +
  labs(fill = 'State',
       x = NULL, y = NULL,
       title = '2017 Milk Production by State',
       subtitle = '(1 square = 1 billion lbs)')

ggsave(here('figs', 'milk_bars.png'),
       milk_bars, width = 6, height = 5)
ggsave(here('figs', 'milk_dots.png'),
       milk_dots, width = 6, height = 5)
ggsave(here('figs', 'milk_lollipop.png'),
       milk_lollipop, width = 6, height = 5)
ggsave(here('figs', 'milk_2017_bars_stacked.png'),
       milk_2017_bars_stacked, width = 4, height = 6)
ggsave(here('figs', 'milk_2017_bars_stacked_rotated.png'),
       milk_2017_bars_stacked_rotated, width = 7, height = 3.5)
ggsave(here('figs', 'milk_2017_bars_stacked_toomany.png'),
       milk_2017_bars_stacked_toomany, width = 4, height = 6)
ggsave(here('figs', 'milk_2017_bars_dodged.png'),
       milk_2017_bars_dodged, width = 7, height = 3.5)
ggsave(here('figs', 'milk_compare_bars_stacked.png'),
       milk_compare_bars_stacked, width = 7, height = 3.5)
ggsave(here('figs', 'milk_compare_bars_dodged.png'),
       milk_compare_bars_dodged, width = 7, height = 4)
ggsave(here('figs', 'milk_waffle_2017.png'),
       milk_waffle_2017, width = 5, height = 4)

# lotr_words -----------------------------------------------------------

lotr_bars <- lotr_words %>%
  gather(key = 'gender', value = 'wordCount',
         Female:Male) %>% 
  ggplot() +
  geom_col(aes(x = wordCount, y = Film),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid(font_size = 18)

lotr_bars_relevel <- lotr_words %>%
  gather(key = 'gender', value = 'wordCount',
         Female:Male) %>% 
  mutate( 
    Film = fct_relevel(Film, levels = c( 
      'The Fellowship Of The Ring', 
      'The Two Towers', 
      'The Return Of The King'))) %>% 
  ggplot() +
  geom_col(aes(x = wordCount, y = Film),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid(font_size = 18)

lotr_bars_recode <- lotr_words %>%
  gather(key = 'gender', value = 'wordCount',
         Female:Male) %>% 
  mutate( #<<
    Film = fct_recode(Film, #<<
      'The Fellowship\nof the Ring' = 'The Fellowship Of The Ring', #<<
      'The Return\nof the King' = 'The Return Of The King')) %>% #<< 
  ggplot() +
  geom_col(aes(x = wordCount, y = Film),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid(font_size = 18)

lotr_bars_relevel_recode <- lotr_words %>%
  gather(key = 'gender', value = 'wordCount',
         Female:Male) %>% 
  mutate(
    Film = fct_relevel(Film, levels = c( 
      'The Fellowship Of The Ring', 
      'The Two Towers', 
      'The Return Of The King')),
    Film = fct_recode(Film, 
      'The Fellowship\nof the Ring' = 'The Fellowship Of The Ring', 
      'The Return\nof the King' = 'The Return Of The King')) %>% 
  ggplot() +
  geom_col(aes(x = wordCount, y = Film),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid(font_size = 18)

ggsave(here('figs', 'lotr_bars.png'),
       lotr_bars, width = 7, height = 4)
ggsave(here('figs', 'lotr_bars_relevel.png'),
       lotr_bars_relevel, width = 7, height = 4)
ggsave(here('figs', 'lotr_bars_recode.png'),
       lotr_bars_recode, width = 7, height = 4)
ggsave(here('figs', 'lotr_bars_relevel_recode.png'),
       lotr_bars_relevel_recode, width = 7, height = 4)

# avengers --------------------------------------------------------------

avengers_bars <- avengers %>%
  mutate(name_alias =
         fct_reorder(name_alias, appearances)) %>%
  ggplot() +
  geom_col(aes(x = appearances, y = name_alias),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid()

avengers_bars_top10 <- avengers %>%
  mutate(name_alias =
         fct_reorder(name_alias, appearances)) %>%
  arrange(desc(appearances)) %>% #<<
  slice(1:10) %>% #<<
  ggplot() +
  geom_col(aes(x = appearances, y = name_alias),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid(font_size = 18)

avengers_bars_top10_gender <- avengers %>%
  mutate(name_alias =
         fct_reorder(name_alias, appearances)) %>%
  arrange(desc(appearances)) %>% #<<
  group_by(gender) %>% #<<
  slice(1:10) %>% #<<
  ggplot() +
  geom_col(aes(x = appearances, 
               y = name_alias,
               fill = gender),
           width = 0.7, alpha = 0.8) +
  scale_x_continuous(
    expand = expansion(mult = c(0, 0.05))) +
  theme_minimal_vgrid(font_size = 18)

ggsave(here('figs', 'avengers_bars.png'),
       avengers_bars, width = 8, height = 8)
ggsave(here('figs', 'avengers_bars_top10.png'),
       avengers_bars_top10, width = 8, height = 8)
ggsave(here('figs', 'avengers_bars_top10_gender.png'),
       avengers_bars_top10_gender, width = 8, height = 8)
