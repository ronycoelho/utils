view_browser <- function(x, file = paste(tempfile(), "xlsx", sep = ".")){
  write.csv(x, file); browseURL(file)
  
}

# d <- mtcars
  
# view_browser(d)
