family_function <- function(){
  mylist <- list()
  fonts <- extrafont::fonts()
  # loop
  for(i in 1:length(fonts)){
    d <- ggplot(head(mtcars), aes(mpg, hp))+
      geom_point()+
      theme_minimal()+
      theme(title = element_text(family = fonts[i], size = 10))+
      labs(title = paste0("This title has the font family:\n",fonts[i]),
           caption = c(i))    
    names <- paste0("item_", i)
    mylist[[names]] <- d
  }
  return(mylist)
}