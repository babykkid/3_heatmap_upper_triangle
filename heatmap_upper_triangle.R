# heat map of genetic correlation between trait 1 and trait 2
# keep only upper triangle
# p1 is the trait 1, x-axis text
# p2 is the trait 2, y-axis text

# the plot data to only keep upper triangle
dft = df2 %>% arrange(p1) %>% group_by(p1) %>% filter(row_number() <= which(p1 == p2))

# heatmap
ggplot(dft, aes(x = p1, y = p2)) +
  geom_tile(fill = "white", color = "grey", size = rel(.3) ) +
  geom_point(aes(color = rg, size = p, ) ) +
  #scale_color_gradient2(low = "tomato", mid = "white", high = "cornflowerblue", name = "Genetic\ncorrelation", limits = c(-1,1) ) +
  scale_color_distiller(palette = "Spectral", name = "Genetic\ncorrelation", limits = c(-1,1) ) +
  scale_size(range = c(10, 1), breaks = c(0.1, 0.05, 0.0001), labels = c(0.1, 0.05, "<0.0001"), name = "P-value\nsignificance" ) +
  #scale_shape_manual(values = c(21, 24) )
  guides(color = guide_colorbar(order = 1, barheight = 16),
         size = guide_legend(order = 2, keyheight = 4, 
                             override.aes = list(color = "#9E0142" ) ) ) +
  geom_text(aes(label = sig), size = 8, vjust = 0.8 ) +
  scale_x_discrete(position = "top") +
  scale_y_discrete(limit = rev) +
  theme(axis.title = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 0, vjust = 1, size = 15, face = "bold"),
        axis.text.y = element_text(size = 15, face = "bold"),
        axis.ticks = element_blank(),
        #panel.background=element_rect(fill="white", colour="black"), 
        panel.background = element_blank(),
        legend.direction = "vertical", legend.box = "horizontal", 
  )