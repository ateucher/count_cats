data <- read.csv("data.csv", stringsAsFactors = FALSE)

ggplot(data, aes(x = n_cats, y = site)) + geom_point()

## Order by n_cats:
ggplot(data,
       aes(x = n_cats,
           y = reorder(site, n_cats, sum))) +
  geom_point()

## Facet by region:
ggplot(data,
       aes(x = n_cats,
           y = reorder(site, n_cats, sum))) +
  geom_point() +
  facet_grid(region~., scales = "free_y", space = "free_y", drop=TRUE,
             labeller = label_wrap_gen(15))

## Make region an ordered factor so can order facets:
data$region <- reorder(data$region, data$n_cats, max, order = TRUE)
data$region <- factor(data$region, levels = rev(levels(data$region)))

## And plot it:
ggplot(data,
       aes(x = n_cats,
           y = reorder(site, n_cats, sum))) +
  geom_point() +
  facet_grid(region~., scales = "free_y", space = "free_y", drop=TRUE,
             labeller = label_wrap_gen(15))

## There is a regulation on the maximum number of cats you can have:
ggplot(data,
       aes(x = n_cats,
           y = reorder(site, n_cats, sum))) +
  geom_point() +
  facet_grid(region~., scales = "free_y", space = "free_y", drop=TRUE,
             labeller = label_wrap_gen(15)) +
  geom_vline(aes(xintercept = 55), linetype = 2, colour = "#e41a1c") +
  geom_text(data = ann_text, label = "Maximum regulated\nnumber of cats (55)", size = 3,
            hjust = 0, colour = "#e41a1c")

## Add labels and tweak the theme:
ggplot(data,
       aes(x = n_cats,
           y = reorder(site, n_cats, sum))) +
  geom_point() +
  facet_grid(region~., scales = "free_y", space = "free_y", drop=TRUE,
             labeller = label_wrap_gen(15)) +
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
