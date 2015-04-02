library(ggplot2)

data <- read.csv("data.csv", stringsAsFactors = FALSE)

data$region <- reorder(data$region, data$n_cats, max, order = TRUE)
data$region <- factor(data$region, levels = rev(levels(data$region)))

ann_text <- data.frame(site = "Duncan Cairnsmore", n_cats = 55.5,
                       region = factor("Georgia Strait",
                                        levels = levels(data$region)))

summary_plot <- ggplot(data,
                       aes(x = n_cats,
                           y = reorder(site, n_cats, sum))) +
  facet_grid(region~., scales = "free_y", space = "free_y", drop=TRUE,
             labeller = label_wrap_gen(15)) +
  geom_point(size = 2, colour = "#377eb8") +
  geom_vline(aes(xintercept = 55), linetype = 2, colour = "#e41a1c") +
  geom_text(data = ann_text, label = "Maximum regulated\nnumber of cats (55)", size = 3,
            hjust = 0, colour = "#e41a1c") +
  labs(title="Number of cats at different cat monitoring sites in B.C.",
       x = "Number of cats", y = "Cat Monitoring Station") +
  theme_bw() +
  theme(axis.title = element_text(size=rel(1)),
        axis.text.y = element_text(size = rel(0.8)),
        axis.line.x = element_blank(),
        strip.text = element_text(size = rel(0.75)))

plot(summary_plot)
