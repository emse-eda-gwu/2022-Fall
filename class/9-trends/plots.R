source(here::here('setup.R'))

# Milk production in california --------------------

milk_ca_dot <- ggplot(milk_ca,
       aes(x = year, y = milk_produced)) +
    geom_point(color = 'steelblue', size = 1.5) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

milk_ca_dot_line <- ggplot(milk_ca,
       aes(x = year, y = milk_produced)) +
    geom_point(color = 'steelblue', size = 1.5) +
    geom_line(color = 'steelblue', size = 0.5) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

milk_ca_line <- ggplot(milk_ca,
       aes(x = year, y = milk_produced)) +
    geom_line(color = 'steelblue', size = 1) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

milk_ca_line_area <- ggplot(milk_ca,
       aes(x = year, y = milk_produced)) +
    geom_line(color = 'steelblue', size = 1) +
    geom_area(fill = 'steelblue', alpha = 0.5) +
    scale_y_continuous(expand = expand_scale(mult = c(0, 0.05))) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

# Global temps over time -----------------------------------------

global_temps_dot <- ggplot(global_temps,
       aes(x = year, y = meanTemp)) +
    geom_point(color = 'steelblue', size = 1.5) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Temperature anomaly (C)')

global_temps_dot_line <- ggplot(global_temps,
       aes(x = year, y = meanTemp)) +
    geom_point(color = 'steelblue', size = 1.5) +
    geom_line(color = 'steelblue', size = 0.5) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Temperature anomaly (C)')

global_temps_line <- ggplot(global_temps,
       aes(x = year, y = meanTemp)) +
    geom_line(color = 'steelblue', size = 1) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Temperature anomaly (C)')

global_temps_line_smooth <- ggplot(global_temps,
       aes(x = year, y = meanTemp)) +
    geom_line(color = 'grey', size = 0.8) +
    geom_smooth(se = FALSE, color = 'steelblue') +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Temperature anomaly (C)')

global_temps_points_anim <- ggplot(global_temps, aes(x = year, y = meanTemp)) +
    geom_point(color = 'steelblue', size = 1.5) +
    # Add a reference line at 0
    geom_hline(yintercept = 0) +
    theme_half_open(font_size = 16) +
    labs(x = 'Year',
         y = 'Temperature anomaly (C)') +
    transition_reveal(year) + 
    # Leave a trail of the points 
    shadow_trail(0.01)

animate(global_temps_points_anim, end_pause = 10, duration = 8,
        width = 600, height = 500, res = 75)

# Save last the animation
anim_save(here::here('images', 'global_temps_points_anim.gif'))

# Milk production by region over time ---------------------------------------

milk_region_dot <- ggplot(milk_region,
       aes(x = year, y = milk_produced,
           color = region)) +
    geom_point() +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

milk_region_dot_line <- ggplot(milk_region,
    aes(x = year, y = milk_produced,
        color = region)) +
    geom_point() +
    geom_line() +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

milk_region_line <- ggplot(milk_region,
    aes(x = year, y = milk_produced,
        color = region)) +
    geom_line(size = 1) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

milk_region_smooth <- ggplot(milk_region,
    aes(x = year, y = milk_produced,
        color = region)) +
    geom_smooth(se = FALSE, size = 1) +
    theme_half_open() +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)')

# # Solution using 2nd axis:
# milk_region_end <- filter(milk_region, year == 2017)
# ggplot(milk_region,
#     aes(x = year, y = milk_produced,
#         color = region)) +
#     geom_smooth(se = FALSE, size = 1) +
#     scale_y_continuous(
#         limits = c(0, 55),
#         expand = c(0, 0),
#         sec.axis = dup_axis(
#             breaks = milk_region_end$milk_produced,
#             labels = c("Lake States", "Pacific", "Mountain", "Northeast"),
#             name = NULL)) +
#     scale_x_continuous(expand = expand_scale(mult = c(0.02, 0))) +
#     theme_half_open() +
#     theme(legend.position = 'none',
#           axis.line.y.right = element_blank(),
#           axis.ticks.y.right = element_blank()) +
#     labs(x = 'Year',
#          y = 'Milk produced (billion lbs)')

# Direct label
milk_region_line_label <- ggplot(milk_region,
    aes(x = year, y = milk_produced,
        color = region)) +
    geom_line(size = 1) +
    geom_text_repel(
      data = milk_region %>%
        filter(year == max(year)),
      aes(label = region),
         hjust = 0, nudge_x = 1, direction = "y",
         size = 6, segment.color = NA) +
    scale_x_continuous(
      breaks = seq(1970, 2010, 10),
      expand = expansion(add = c(1, 13))) +
    scale_color_manual(values = c(
        'sienna', 'forestgreen', 'dodgerblue', 'orange')) +
    theme_half_open(font_size = 18) +
    theme(legend.position = 'none') +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)',
         title = 'Milk production in four US regions')

# Animation
milk_region_anim_plot <- ggplot(milk_region,
    aes(x = year, y = milk_produced,
        color = region)) +
    geom_line(size = 1) +
    geom_point(size = 2) +
    geom_text_repel(
      aes(label = region),
         hjust = 0, nudge_x = 1, direction = "y",
         size = 6, segment.color = NA) +
    scale_x_continuous(
      breaks = seq(1970, 2010, 10),
      expand = expansion(add = c(1, 13))) +
    scale_color_manual(values = c(
        'sienna', 'forestgreen', 'dodgerblue', 'orange')) +
    theme_half_open(font_size = 18) +
    theme(legend.position = 'none') +
    labs(x = 'Year',
         y = 'Milk produced (billion lbs)',
         title = 'Milk production in four US regions')

milk_region_anim <- milk_region_anim_plot +
    transition_reveal(year)

# Render the animation
animate(milk_region_anim, end_pause = 15, duration = 10,
        width = 1100, height = 650, res = 150)

# Save last animation
anim_save(here::here('images', 'milk_region_animation.gif'))

# Render the animation
animate(milk_region_anim, end_pause = 0, duration = 10,
        width = 1000, height = 650, res = 150)

# Save last animation
anim_save(here::here('images', 'milk_region_animation_no_pause.gif'))

# Milk heat map -----------------------------------------------

milk_heat_map <- ggplot(milk_production) +
    geom_tile(aes(x = year, y = state, fill = milk_produced),
              color = 'grey80') +
    scale_x_continuous(expand = c(0, 0)) +
    scale_fill_viridis(option = 'inferno', direction = -1,
                       trans = 'sqrt') +
    guides(fill = guide_colorbar(title.position = 'top',
                                 reverse = TRUE)) +
    coord_cartesian(clip = 'off') +
    theme_minimal() +
    theme(panel.grid = element_blank(),
          legend.position = 'bottom',
          text = element_text(size = 8)) +
    labs(x = '', y = '',
         fill = 'Billions of lbs produced',
         title = 'U.S. Milk Production by State')

# Internet users - country -----------------------------------------------

internet_country_line <- ggplot(internet_country_summary,
       aes(x = year, y = percent,
           color = country)) +
    geom_line(size = 1) +
    geom_text(aes(label = label),
              hjust = 0, nudge_x = 0.5) +
    scale_color_manual(values = c(
        'sienna', 'forestgreen', 'orange', 'dodgerblue')) +
    coord_cartesian(clip = 'off') +
    theme_minimal() +
    theme(legend.position = 'none',
          plot.margin = margin(0.1, 2, 0.1, 0.1, "cm")) +
    labs(x = 'Year',
         y = 'Percent of population')

# Animation
internet_country_anim_plot <- internet_country_summary %>%
    mutate(year = as.integer(year)) %>%
    ggplot(aes(x = year, y = percent, color = country)) +
    geom_line(size = 1) +
    geom_point() +
    geom_text(aes(label = country),
              hjust = 0,
              nudge_x = 1,
              nudge_y = -2) +
    scale_color_manual(values = c(
        'sienna', 'forestgreen', 'orange', 'dodgerblue')) +
    coord_cartesian(clip = 'off') +
    theme_minimal() +
    theme(legend.position = 'none',
          plot.margin = margin(0.1, 2, 0.1, 0.1, "cm")) +
    labs(x = 'Year',
         y = 'Percent of population')

internet_country_anim <- internet_country_anim_plot +
    transition_reveal(year)

# Render the animation
animate(internet_country_anim, end_pause = 10,
        width = 800, height = 500, res = 150)

# Save last animation
anim_save(here::here('images', 'internet_country_animation.gif'))

# Internet users - region -------------------------------------------------

internet_region_line_label <- ggplot(internet_region_summary,
    aes(x = year, y = numUsers,
        color = region)) +
    geom_line(size = 1) +
    geom_text(aes(label = label),
                    hjust = 0, nudge_x = 0.5) +
    coord_cartesian(clip = 'off') +
    theme_half_open() +
    theme(legend.position = 'none',
          plot.margin = margin(0.1, 4.5, 0.1, 0.1, "cm")) +
    labs(x = 'Year',
         y = 'Number of internet users (billions)')

internet_region_area <- ggplot(internet_region_summary,
    aes(x = year, y = numUsers,
        fill = region)) +
    geom_area() +
    coord_cartesian(clip = 'off') +
    scale_fill_viridis(discrete = TRUE) +
    theme_minimal() +
    theme(legend.position = 'bottom') +
    labs(x = 'Year',
         fill = 'Region',
         y = 'Number of internet users (billions)')

# Hot dog bars -------------------------------------------------------

hotdog_bar_record <- ggplot(hotdogs_mens) +
    geom_col(aes(x = Year, y = dogs, fill = record),
             width = 0.8, alpha = 0.9) +
    scale_fill_manual(values = c("grey", "sienna")) +
    scale_y_continuous(expand = expand_scale(mult = c(0, 0.05))) +
    theme_minimal_hgrid() +
    theme(legend.position = c(0.1, 0.65)) +
    labs(x = 'Year',
         y = 'Number of hot dogs & buns\nin 10 minutes',
         fill = 'Record\nbroken?')

hotdog_bar_winner <- ggplot(hotdogs_mens) +
    geom_col(aes(x = Year, y = dogs, fill = Winner),
             width = 0.8, alpha = 0.9) +
    scale_y_continuous(expand = expand_scale(mult = c(0, 0.05))) +
    theme_minimal_hgrid() +
    theme(legend.position = c(0.1, 0.65)) +
    labs(x = 'Year',
         y = 'Number of hot dogs & buns\nin 10 minutes',
         fill = 'Winner',
         title = "Winner of Nathan's hot dog eating competition,\nmen's division")

# US contagious diseases------------------------------------------------------

measles_line_ca <- ggplot(measles_ca) +
    geom_line(aes(x = year, y = rate)) +
    geom_vline(xintercept = 1963, col = 'blue',
               linetype = 'dashed') +
    annotate('text', x = 1964, y = 70, hjust = 0,
             label = 'Vaccine introduced in 1964',
             color = 'blue') +
    labs(y = 'Cases per 10,000 people') +
    theme_bw()

measles_line_us <- ggplot(measles) +
    geom_line(aes(x = year, y = rate, group = state),
              color = 'grey', alpha = 0.3) +
    geom_line(data = measles_us,
              aes(x = year, y = rate),
              size = 0.8) +
    geom_vline(xintercept = 1963, col = 'blue',
               linetype = 'dashed') +
    annotate('text', x = 1945, y = 55, hjust = 0,
             label = 'US Average') +
    annotate('text', x = 1964, y = 70, hjust = 0,
             label = 'Vaccine introduced in 1964',
             color = 'blue') +
    labs(y = 'Cases per 10,000 people') +
    theme_bw()

measles_heat_map <- ggplot(measles) +
    geom_tile(aes(x = year, y = state, fill = rate),
              color = 'grey80') +
    # Add reference line:
    geom_vline(xintercept = 1963, col = 'blue') +
    annotate('text', x = 1964, y = 51, hjust = 0,
             label = 'Vaccine introduced in 1964',
             color = 'blue') +
    # Adjust scales
    scale_x_continuous(expand = c(0, 0)) +
    scale_fill_viridis(option = 'inferno', direction = -1,
                       trans = 'sqrt') +
    guides(fill = guide_colorbar(
        title.position = 'top', reverse = TRUE)) +
    coord_cartesian(clip = 'off') +
    # Adjust theme
    theme_minimal() +
    theme(panel.grid = element_blank(),
          legend.position = 'bottom',
          text = element_text(size = 8)) +
    labs(x = '', y = '',
         fill = 'Cases per 10,000 people',
         title = 'Measles')

# Gapminder animation ------------------------------------------------

gapminder_anim_plot <- ggplot(gapminder,
    aes(x = gdpPercap, y = lifeExp,
        size = pop, color = continent)) +
    geom_point(alpha = 0.7) +
    scale_color_brewer(palette = 'Set2') +
    scale_size_area(guide = FALSE, max_size = 15) +
    scale_x_log10() +
    theme_bw(base_size = 16) +
    theme(legend.position = c(0.85, 0.3)) +
    labs(x = 'GDP per capita',
         y = 'Life expectancy',
         color = 'Continent')

gapminder_anim <- gapminder_anim_plot +
    transition_time(year) +
    labs(title = "Year: {frame_time}")

# Render the animation
animate(gapminder_anim, end_pause = 10,
        width = 800, height = 700, res = 150)

# Save last the animation
anim_save(here::here('images', 'gapminder_animation.gif'))

# Milk production bar chart race --------------------------------------------

milk_race_anim_plot <- ggplot(milk_race,
    aes(x = rank, group = state,
    fill = region, color = region)) +
    geom_tile(aes(y = milk_produced / 2,
                  height = milk_produced,
                  width = 0.9), alpha = 0.8, color = NA) +
    geom_text(aes(y = 0, label = paste(state, " ")),
              vjust = 0.2, hjust = 1) +
    geom_text(aes(y = milk_produced,
                  label = Value_lbl, hjust = 0)) +
    coord_flip(clip = 'off', expand = FALSE) +
    scale_y_continuous(labels = scales::comma) +
    scale_fill_viridis(discrete = TRUE) +
    scale_color_viridis(discrete = TRUE) +
    scale_x_reverse() +
    guides(color = FALSE) +
    theme_minimal_vgrid() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.title = element_blank(),
          legend.position = c(0.7, 0.3),
          legend.background = element_rect(fill = 'white'),
          plot.title = element_text(
              size = 22, hjust = 0.5, face = 'bold',
              colour = 'grey', vjust = -1),
          plot.subtitle = element_text(
              size = 18, hjust = 0.5,
              face = 'italic', color = 'grey'),
          plot.caption = element_text(
              size = 8, hjust = 0.5,
              face = 'italic', color = 'grey'),
          plot.margin = margin(0.5, 2, 0.5, 3, 'cm'))

milk_race_anim = milk_race_anim_plot +
    transition_time(year) +
    view_follow(fixed_x = TRUE)  +
    labs(title    = 'Year : {frame_time}',
         subtitle = 'Top 10 states by milk produced',
         fill     = 'Region',
         caption  = 'Milk produced (billions lbs)')

# Render the animation
animate(milk_race_anim, duration = 17, end_pause = 15,
        width = 800, height = 700, res = 150)

# Save last the animation
anim_save(here::here('images', 'milk_race_anim.gif'))


















milk_race_anim <- milk_production %>%
    group_by(year) %>%
    mutate(
        rank = rank(-milk_produced),
        Value_rel = milk_produced / milk_produced[rank==1],
        Value_lbl = paste0(' ', round(milk_produced))) %>%
    group_by(state) %>%
    filter(rank <= 10) %>%
    ungroup() %>%
    mutate(year = as.integer(year)) %>%
    ggplot(
        aes(x = rank, group = state,
        fill = region, color = region)) +
    geom_tile(
        aes(y = milk_produced / 2,
            height = milk_produced), 
         width = 0.9, alpha = 0.8, color = NA) +
    geom_text(aes(y = 0, label = paste(state, " ")),
              vjust = 0.2, hjust = 1) +
    geom_text(
        aes(y = milk_produced, label = Value_lbl), 
        hjust = 0) +
    coord_flip(clip = 'off', expand = FALSE) +
    scale_y_continuous(labels = scales::comma) +
    scale_fill_viridis(discrete = TRUE) +
    scale_color_viridis(discrete = TRUE) +
    scale_x_reverse() +
    guides(color = FALSE) +
    theme_minimal_vgrid() +
    theme(
        axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        legend.position = c(0.7, 0.3),
        legend.background = element_rect(fill = 'white'),
        plot.title = element_text(
          size = 22, hjust = 0.5, face = 'bold',
          colour = 'grey', vjust = -1),
        plot.subtitle = element_text(
          size = 18, hjust = 0.5,
          face = 'italic', color = 'grey'),
        plot.caption = element_text(
          size = 8, hjust = 0.5,
          face = 'italic', color = 'grey'),
          plot.margin = margin(0.5, 2, 0.5, 3, 'cm')) +
    transition_time(year) +
    view_follow(fixed_x = TRUE)  +
    labs(title    = 'Year : {frame_time}',
         subtitle = 'Top 10 states by milk produced',
         fill     = 'Region',
         caption  = 'Milk produced (billions lbs)')

animate(milk_race_anim, duration = 17, end_pause = 15,
        width = 800, height = 700, res = 150)
