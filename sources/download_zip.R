#dowload zip
download.zip <- function(link){
  wd <- getwd()
  temp_dir <- tempdir()
  setwd(temp_dir)
  temp_file <- tempfile(tmpdir=temp_dir)
  download.file(url=link, destfile=temp_file)
  unzip(temp_file, exdir=temp_dir)
  files <- list.files(path=temp_dir)
  unlink(temp_file)
  
  return(files) 
  setwd(wd)
}