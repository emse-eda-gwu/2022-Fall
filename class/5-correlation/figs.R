library(HistData)
library(GGally)
library(palmerpenguins)
library(lubridate)
library(countdown)
library(knitr)
library(cowplot)
library(tidyverse)
library(here)

# Set main theme settings
theme_set(theme_gray(base_size = 18))

# Read in data
wildlife_impacts <- read_csv(here::here('data', 'wildlife_impacts.csv'))
msleep           <- read_csv(here::here('data', 'msleep.csv'))

cor_w <- 5
cor_h <- 4

# Galton scatterplot ----------------------------------------------------------

# midparentHeight =  (father + 1.08*mother)/2
galtonCorr <- round(cor(
    GaltonFamilies$childHeight, GaltonFamilies$midparentHeight,
    method = 'pearson'), 2)

galtonScatterplot <- ggplot(GaltonFamilies) +
    geom_point(aes(x = midparentHeight, y = childHeight),
               size = 0.5, alpha = 0.7) +
    annotate(geom = 'text', x = 64, y = 79,
             label = paste('r = ', galtonCorr), hjust = 0,
             size = 5) +
    theme_classic(base_size = 18) +
    labs(x = 'Midparent height (inches)',
         y = 'Child height (inches)')

ggsave(here::here('figs', 'galtonScatterplot.png'),
       galtonScatterplot, width = 5, height = 4)

# Fitting a line
galtonScatterplotSmooth <- galtonScatterplot +
    geom_smooth(aes(x = midparentHeight, y = childHeight),
                method = 'lm', se = FALSE)

ggsave(here::here('figs', 'galtonScatterplotSmooth.png'),
       galtonScatterplotSmooth, width = 5, height = 4)

# penguins --------------------------------------------------------------

penguinScatterplotBase <- ggplot(penguins, 
                                 aes(x = flipper_length_mm, 
                                     y = body_mass_g)) +
    geom_point(size = 1, alpha = 0.7) +
    theme_classic(base_size = 20) +
    labs(x = "Flipper length (mm)",
         y = "Body mass (g)")

penguinCorr <- round(cor(
    penguins$body_mass_g, penguins$flipper_length_mm,
    method = 'pearson', use = "complete.obs"), 2)

penguinScatterplot <- penguinScatterplotBase +
    annotate(geom = 'text', x = 175, y = 6000,
             label = paste('r = ', penguinCorr), 
             hjust = 0, size = 5)

ggsave(here::here('figs', 'penguinScatterplotBase.png'),
       penguinScatterplotBase, width = 5, height = 4)

ggsave(here::here('figs', 'penguinScatterplot.png'),
       penguinScatterplot, width = 5, height = 4)

# Fitting a line

# Method 1
penguinScatterplotSmooth <- penguinScatterplot +
    geom_smooth(method = 'lm', se = FALSE)

# Add equation label, v1
penguinFit <- lm(body_mass_g ~ flipper_length_mm, data = penguins)
coefs <- round(coef(penguinFit), 2)
eqLabel <- paste('y = ', coefs[1], ' + ', coefs[2], 'x')
penguinScatterplotEq <- penguinScatterplotSmooth +
    annotate(geom = 'text', x = 175, y = 5700,
             label = eqLabel, color = "blue", 
             hjust = 0, size = 5)

# Method 2
penguinScatterplotAbline <- penguinScatterplot +
    geom_abline(intercept = penguinFit$coefficients[1],
                slope = penguinFit$coefficients[2],
                color = 'blue', size = 1)

ggsave(here::here('figs', 'penguinScatterplotSmooth.png'),
       penguinScatterplotSmooth, width = 5, height = 4)
ggsave(here::here('figs', 'penguinScatterplotAbline.png'),
       penguinScatterplotAbline, width = 5, height = 4)
ggsave(here::here('figs', 'penguinScatterplotEq.png'),
       penguinScatterplotEq, width = 5, height = 4)

# simpson paradox penguins -----------------------------------------------

simpsonCorr <- cor(
    penguins$body_mass_g, penguins$bill_depth_mm,
    method = 'pearson', use = "complete.obs")

simpsonLabel <- paste("r = ", round(simpsonCorr, 2))

simpson_penguins <- ggplot(penguins,
                       aes(x = bill_depth_mm,
                           y = body_mass_g)) +
    geom_point(size = 1, alpha = 0.7) +
    geom_smooth(method = "lm", se = FALSE) +
    annotate(geom = 'text', x = 19, y = 6000,
             label = simpsonLabel, 
             hjust = 0, size = 5) +
    theme_classic(base_size = 18) +
    labs(x = "Bill depth (mm)",
         y = "Body mass (g)")

adelie <- filter(penguins, species == "Adelie")
chinstrap <- filter(penguins, species == "Chinstrap")
gentoo <- filter(penguins, species == "Gentoo")
corrAdelie <- cor(
    adelie$body_mass_g, adelie$bill_depth_mm,
    method = 'pearson', use = "complete.obs")
corrChinstrap <- cor(
    chinstrap$body_mass_g, chinstrap$bill_depth_mm,
    method = 'pearson', use = "complete.obs")
corrGentoo <- cor(
    gentoo$body_mass_g, gentoo$bill_depth_mm,
    method = 'pearson', use = "complete.obs")
labAdelie <- paste("r =", round(corrAdelie, 2))
labChinstrap <- paste("r =", round(corrChinstrap, 2))
labGentoo <- paste("r =", round(corrGentoo, 2))

simpson_penguins_good <- ggplot(penguins,
                       aes(x = bill_depth_mm,
                           y = body_mass_g, 
                           color = species)) +
    geom_point(size = 1, alpha = 0.7) +
    geom_smooth(method = "lm", se = FALSE) +
    scale_color_manual(values = c("darkorange","purple","cyan4")) +
    annotate(geom = 'text', x = 19, y = 5100,
             label = labAdelie, color = "darkorange", 
             hjust = 0, size = 5) +
    annotate(geom = 'text', x = 20, y = 3000,
             label = labChinstrap, color = "purple", 
             hjust = 0, size = 5) +
    annotate(geom = 'text', x = 13, y = 6100,
             label = labGentoo, color = "cyan4", 
             hjust = 0, size = 5) +
    theme_classic(base_size = 18) +
    labs(x = "Bill depth (mm)",
         y = "Body mass (g)", 
         color = "Species")

ggsave(here::here('figs', 'simpson_penguins.png'),
       simpson_penguins, width = 5, height = 4)

ggsave(here::here('figs', 'simpson_penguins_good.png'),
       simpson_penguins_good, width = 6, height = 4)

 # correlations -----------------------------------------------------------

cor_theme <- function() {
    return(
        theme_half_open(font_size = 20) +
        theme(plot.title = element_text(hjust = 0.5, size = 20)))
}

cor_df <- data.frame(x = runif(100, 0, 10)) %>%
    mutate(quad       = -(x-5)^2 + rnorm(100, 5, 2),
           vstrong_p  = 2*x + rnorm(100, 0, 2),
           strong_p   = 2*x + rnorm(100, 0, 5),
           moderate_p = 2*x + rnorm(100, 0, 15),
           weak_p     = 2*x + rnorm(100, 0, 35),
           vstrong_n  = -1*vstrong_p,
           strong_n   = -1*strong_p,
           moderate_n = -1*moderate_p,
           weak_n     = -1*weak_p,
           cor_vstrong_p  = round(cor(x, vstrong_p),  2),
           cor_strong_p   = round(cor(x, strong_p),   2),
           cor_moderate_p = round(cor(x, moderate_p), 2),
           cor_weak_p     = round(cor(x, weak_p),     2),
           cor_vstrong_n  = round(cor(x, vstrong_n),  2),
           cor_strong_n   = round(cor(x, strong_n),   2),
           cor_moderate_n = round(cor(x, moderate_n), 2),
           cor_weak_n     = round(cor(x, weak_n),     2))

cor_quad <- ggplot(cor_df) +
    geom_point(aes(x = x, y = quad), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y')

cor_vstrong_p <- ggplot(cor_df) +
    geom_point(aes(x = x, y = vstrong_p), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_vstrong_p[1]))

cor_strong_p <- ggplot(cor_df) +
    geom_point(aes(x = x, y = strong_p), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_strong_p[1]))

cor_moderate_p <- ggplot(cor_df) +
    geom_point(aes(x = x, y = moderate_p), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_moderate_p[1]))

cor_weak_p <- ggplot(cor_df) +
    geom_point(aes(x = x, y = weak_p), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_weak_p[1]))

cor_vstrong_n <- ggplot(cor_df) +
    geom_point(aes(x = x, y = vstrong_n), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_vstrong_n[1]))

cor_strong_n <- ggplot(cor_df) +
    geom_point(aes(x = x, y = strong_n), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_strong_n[1]))

cor_moderate_n <- ggplot(cor_df) +
    geom_point(aes(x = x, y = moderate_n), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_moderate_n[1]))

cor_weak_n <- ggplot(cor_df) +
    geom_point(aes(x = x, y = weak_n), size = 1.5, alpha = 0.7) +
    cor_theme() +
    labs(x = 'x', y = 'y',
         title = paste0('r = ', cor_df$cor_weak_n[1]))

# Combined plots
cor_p <- plot_grid(cor_weak_p, cor_moderate_p,
                   cor_strong_p, cor_vstrong_p, ncol = 2)
cor_n <- plot_grid(cor_weak_n, cor_moderate_n,
                   cor_strong_n, cor_vstrong_n, ncol = 2)

ggsave(here::here('figs', 'cor_quad.png'),
       cor_quad, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_vstrong_p.png'),
       cor_vstrong_p, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_strong_p.png'),
       cor_strong_p, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_moderate_p.png'),
       cor_moderate_p, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_weak_p.png'),
       cor_weak_p, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_vstrong_n.png'),
       cor_vstrong_n, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_strong_n.png'),
       cor_strong_n, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_moderate_n.png'),
       cor_moderate_n, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_weak_n.png'),
       cor_weak_n, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'cor_n.png'),
       cor_n, width = cor_w*2, height = cor_h*2)
ggsave(here::here('figs', 'cor_p.png'),
       cor_p, width = cor_w*2, height = cor_h*2)

# outliers ----------------------------------------------------------------

# Make the plot data frames
outliers <- data.frame(x = rnorm(20, 0, 0.5)) %>%
    mutate(y1 = x - rnorm(20, 0, 0.5),
           y2 = y1, y3 = y1, y4 = y1, y5 = y1,
           y6 = y1, y7 = y1, y8 = y1, y9 = y1,
           point = 'base')
points <- expand.grid(data.frame(
    x = c(-5, 0, 5),
    y = c(-5, 0, 5)))
points_df <- as.data.frame(diag(points$y))
names(points_df) <- c('y7', 'y8', 'y9', 'y4', 'y5', 'y6', 'y1', 'y2', 'y3')
for (i in 1:nrow(points_df)) {
    cols <- seq(ncol(points_df))
    cols <- cols[-which(cols == i)]
    points_df[i,cols] <- NA
}
points_df <- bind_cols(data.frame(x = points$x), points_df)
points_df$point <- 'outlier'
outliers <- bind_rows(outliers, points_df) %>%
    gather(key = 'case', value = 'y', y1:y9) %>%
    filter(!is.na(y)) %>%
    group_by(case) %>%
    mutate(pearson  = round(cor(x, y, method = 'pearson'), 2),
           spearman = round(cor(x, y, method = 'spearman'), 2),
           case_p   = paste0('r = ', pearson),
           case_s   = paste0('r = ', spearman))

# Create facet labels
case_p <- outliers %>% distinct(case, case_p)
case_p_labels <- case_p$case_p
names(case_p_labels) <- case_p$case
case_s <- outliers %>% distinct(case, case_s)
case_s_labels <- case_s$case_s
names(case_s_labels) <- case_s$case

# Make the plots
outlier_plot <- function(df, labels) {
    plot <- ggplot(df) +
        geom_point(aes(x = x, y = y, color = point),
                   size = 3, alpha = 0.7) +
        facet_wrap(~case, ncol = 3,
                   labeller = labeller(case = labels)) +
        scale_color_manual(values = c('black', 'red')) +
        scale_x_continuous(limits = c(-6, 6)) +
        scale_y_continuous(limits = c(-6, 6)) +
        theme_bw(base_family = 'Roboto Condensed', base_size = 20) +
        panel_border() +
        theme(plot.title = element_text(hjust = 0.5),
              legend.position = 'none',
              strip.text.x = element_text(size = 20, face = 'bold'),
              panel.grid.minor = element_blank()) +
        labs(x = 'x', y = 'y')
    return(plot)
}

pearson_grid  <- outlier_plot(outliers, case_p_labels)
spearman_grid <- outlier_plot(outliers, case_s_labels)
pearson_base  <- outlier_plot(outliers %>% filter(case == 'y5'), case_p_labels)
pearson_1     <- outlier_plot(outliers %>% filter(case == 'y2'), case_p_labels)
pearson_2     <- outlier_plot(outliers %>% filter(case == 'y1'), case_p_labels)

ggsave(here::here('figs', 'pearson_grid.png'),
       pearson_grid, width = 8, height = 7)
ggsave(here::here('figs', 'spearman_grid.png'),
       spearman_grid, width = 8, height = 7)
ggsave(here::here('figs', 'pearson_base.png'),
       pearson_base, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'pearson1.png'),
       pearson_1, width = cor_w, height = cor_h)
ggsave(here::here('figs', 'pearson2.png'),
       pearson_2, width = cor_w, height = cor_h)

# Plot summary of comparison
outlier_compare <- outliers %>%
    distinct(case, pearson, spearman) %>%
    gather(key = 'type', value = 'r', pearson:spearman) %>%
    mutate(type = str_to_title(type)) %>%
    ggplot(aes(x = '', y = r)) +
    facet_wrap(~type) +
    geom_boxplot(width = 0.2, color = 'grey42', outlier.shape = NA) +
    geom_jitter(size = 1.7, alpha = 0.7, width = 0.1) +
    geom_hline(yintercept = 0, color = 'grey42') +
    scale_y_continuous(limits = c(-1, 1),
                       breaks = c(-1, -0.5, 0, 0.5, 1)) +
    theme_bw(base_size = 12) +
    labs(x = NULL)

ggsave(here::here('figs', 'outlier_compare.png'),
       outlier_compare, width = 4, height = 4)

# mtcars corr ------------------------------------------------------------

mtcarsScatterplotBase <- ggplot(mtcars) +
    geom_point(aes(x = mpg, y = hp),
               size = 2, alpha = 0.7) +
    theme_classic(base_size = 20) +
    labs(x = 'Fuel economy (mpg)',
         y = 'Engine power (hp)')

mtcarsCorr <- round(cor(mtcars$mpg,
                        mtcars$hp, method = 'pearson'), 2)
mtcarsScatterplot <- mtcarsScatterplotBase +
    annotate(geom = 'text', x = 25, y = 310,
             label = paste('r = ', mtcarsCorr), hjust = 0,
             size = 7)

ggsave(here::here('figs', 'mtcarsScatterplotBase.png'),
       mtcarsScatterplotBase, width = 5, height = 4)

ggsave(here::here('figs', 'mtcarsScatterplot.png'),
       mtcarsScatterplot, width = 5, height = 4)

# wildlife_impacts ------------------------------------------------------------

wildlife_impacts %>%
    ggcorr(label = TRUE)

corLab <- round(cor(
    wildlife_impacts$height, wildlife_impacts$speed,
    use = "complete.obs"), 2)

wildlife_cor <- wildlife_impacts %>%
    filter(!is.na(speed), !is.na(height)) %>%
    summarise(pearson = cor(speed, height, method = 'pearson'),
              spearman = cor(speed, height, method = 'spearman'))

ggplot(wildlife_impacts) +
    geom_point(aes(x = speed, y = height), alpha = 0.7) +
    annotate(geom = 'text', x = 50, y = 22000,
             label = paste('r = ', corLab),
             hjust = 0, size = 5) +
    theme_minimal_grid() +
    labs(x = 'Speed (mph)',
         y = 'Height (ft)')

# msleep ------------------------------------------------------------

# Linear
corLabLinear <- round(cor(
    msleep$bodywt, msleep$brainwt,
    use = "complete.obs"), 2)

modelLinear <- lm(brainwt ~ bodywt, data = msleep)
coefs <- round(coef(modelLinear), 3)
eqLabel <- paste('y = ', coefs[1], ' + ', coefs[2], 'x')

ggplot(msleep, aes(x = bodywt, y = brainwt)) +
    geom_point() +
    annotate(geom = 'text', x = 100, y = 6,
             label = paste('r = ', corLabLinear),
             hjust = 0, size = 5) +
    annotate(geom = 'text', x = 100, y = 5.5,
             label = eqLabel, hjust = 0,
             size = 5) +
    geom_smooth(method = 'lm', se = FALSE) +
    theme_minimal_grid()

# Log
corLabLog <- round(cor(
    log(msleep$bodywt), log(msleep$brainwt),
    use = "complete.obs"), 2)

modelLog <- lm(log(brainwt) ~ log(bodywt), data = msleep)
coefs <- round(coef(modelLog), 3)
eqLabel <- paste('log(y) = ', coefs[1], ' + ', coefs[2], ' log(x)')

ggplot(msleep, aes(x = bodywt, y = brainwt)) +
    geom_point() +
    annotate(geom = 'text', x = 0.01, y = 6,
             label = paste('r = ', corLabLog),
             hjust = 0, size = 5) +
    annotate(geom = 'text', x = 0.01, y = 3,
             label = eqLabel, hjust = 0,
             size = 5) +
    geom_smooth(method = 'lm', se = FALSE) +
    scale_x_log10() +
    scale_y_log10() +
    theme_minimal_grid()

# corr ------------------------------------------------------------

wildlife_impacts %>%
    ggcorr(label = TRUE)

corLab <- round(cor(
    wildlife_impacts$height, wildlife_impacts$speed,
    use = "complete.obs"), 2)

wildlife_cor <- wildlife_impacts %>%
    filter(!is.na(speed), !is.na(height)) %>%
    summarise(pearson = cor(speed, height, method = 'pearson'),
              spearman = cor(speed, height, method = 'spearman'))

ggplot(wildlife_impacts) +
    geom_point(aes(x = speed, y = height), alpha = 0.7) +
    annotate(geom = 'text', x = 50, y = 22000,
             label = paste('r = ', corLab),
             hjust = 0, size = 5) +
    theme_minimal_grid() +
    labs(x = 'Speed (mph)',
         y = 'Height (ft)')

# ggcorr ------------------------------------------------------------------

ggcor_mtcars <- mtcars %>%
    ggcorr()

ggcor_mtcars_labels <- mtcars %>%
    ggcorr(label = TRUE,
           label_size = 3,
           label_round = 2)

ggcor_mtcars_pearson <- mtcars %>%
    ggcorr(label = TRUE,
           label_size = 3,
           label_round = 2,
           method = c("pairwise", "pearson"))

ggcor_mtcars_spearman <- mtcars %>%
    ggcorr(label = TRUE,
           label_size = 3,
           label_round = 2,
           method = c("pairwise", "spearman"))

ggcor_mtcars_final <- mtcars %>%
    ggcorr(label = TRUE,
           label_size = 3,
           label_round = 2,
           label_color = 'white',
           method = c("pairwise", "spearman"),
           nbreaks = 5,
           palette = "RdBu")

ggcor_mtcars_colors <- mtcars %>%
    ggcorr(geom = "blank", label = TRUE) +
    geom_point(size = 10, aes(color = coefficient > 0,
                              alpha = abs(coefficient) > 0.7)) +
    scale_alpha_manual(values = c("TRUE" = 0.50, "FALSE" = 0)) +
    guides(color = FALSE, alpha = FALSE)

ggsave(here::here('figs', 'ggcor_mtcars.png'),
       ggcor_mtcars, width = 6, height = 5)

ggsave(here::here('figs', 'ggcor_mtcars_labels.png'),
       ggcor_mtcars_labels, width = 6, height = 5)

ggsave(here::here('figs', 'ggcor_mtcars_pearson.png'),
       ggcor_mtcars_pearson, width = 6, height = 5)

ggsave(here::here('figs', 'ggcor_mtcars_spearman.png'),
       ggcor_mtcars_spearman, width = 6, height = 5)

ggsave(here::here('figs', 'ggcor_mtcars_final.png'),
       ggcor_mtcars_final, width = 6, height = 5)

ggsave(here::here('figs', 'ggcor_mtcars_colors.png'),
       ggcor_mtcars_colors, width = 6, height = 5)

# ggpairs ------------------------------------------------------------------

# Correlogram

ggpairs_mtcars <- mtcars %>%
    select(mpg, cyl, disp, hp, wt) %>%
    ggpairs()

ggpairs_mtcars_classic <- mtcars %>%
    select(mpg, cyl, disp, hp, wt) %>%
    ggpairs() +
    theme_classic(base_size = 18)

ggsave(here::here('figs', 'ggpairs_mtcars.png'),
       ggpairs_mtcars, width = 7, height = 6)

ggsave(here::here('figs', 'ggpairs_mtcars_classic.png'),
       ggpairs_mtcars_classic, width = 7, height = 6)

