theme_new <- function(){
  theme(
    text = element_text(color = "blue"),
    plot.background = element_rect(
      linetype = "dashed",
      fill = "orange",
      color = "red",
      size = 20),
    panel.background = element_rect(color = "white", 
                                    fill = "purple"),
    axis.text.y = element_blank(),
    axis.title.y = element_blank(),
    plot.margin = unit(c(1, 1, 1, 1), "cm"),
    plot.title = element_text(
      hjust = 0,
      size = 45,
      color = "green")
  )
}