snippet my_guide_legend

facet_grid(cols = vars(outcome), rows= vars(region))+
  md_theme_wsj(color = "blue")+
  theme(legend.background = element_rect(),
        legend.position = "bottom",
        axis.text.y.left= element_text(size=8),		
        axis.text.x= element_blank(),
        legend.direction = "horizontal", legend.box = "horizontal")+
  guides(fill = guide_legend(title="",
                             nrow = 1,                       
                             label.position= "top",
                             keywidth = unit(2, "cm"),
                             keyheight = unit(.25, "cm"))
         

snippet my_count_plot_categoricals
         var_freq_plot_fn <- function(df, selected_var){
           df %>% 
             count(.data[[selected_var]]) %>%
             ggplot(aes(x = n, y = .data[[selected_var]], fill = .data[[selected_var]])) +
             geom_col() +
             theme(legend.position = "none")
         }
         
snippet my_paste_from_excel
         dt <- read.delim('clipboard', sep ='\t')
         
snippet my_save.with.cairo
         #setwd("C:/rstats/soudapaz/eleitos")
         Cairo::CairoSVG("grid.pref.eleitos.svg", 
                         height = 20, width = 7)
         print(grid.eleitos)
         dev.off()
         
snippet my_source
         (files <- list.files("C:/r_files/source"))
         source(paste0("C:/r_files/source/", files[7]))
         
snippet my_get.color
         get.color <- colorRampPalette(c("#F5C710", "#9E9E9E", "black"))
         scales::show_col(get.color(10))
         get.color(10)

snippet my_write.csv.function
         write.csv2(d, "d.csv", 
                    fileEncoding = "ISO-8859-1")
         
snippet my_labs
         labs(title = "Title",
              subtitle = "sub",
              y = "",
              x = "")
         
snippet my_glimpse
         ${1:dados} %>% head() %>% glimpse()
         
snippet my_ggsave
         ggsave("my_plot.png",
                plot = my_plot,
                device = ragg::agg_png(width = 10, 
                                       height = 10, 
                                       units = "in", 
                                       res = 300))
         dev.off()
         
snippet my_ggplot
         ggplot(${1:dados}, aes(mpg, wt)) +	
           geom_point() +
           theme()+
           labs(title = "title",
                subtitle = "sub",	
                x = "",
                y = "")
         
         
snippet my_filter_group_summ
         ${1:dados} %>% filter(${2:var1} == 35) %>% 
           group_by(${2:var1}) %>% 
           summarise(cumsum(${3:var2}))
         
snippet my_first_snippet
         ${1:dados} %>% 
           unique()
         
         snippet lib
         library(${1:package})
         
         snippet req
         require(${1:package})
         
         snippet src
         source("${1:file.R}")
         
         snippet ret
         return(${1:code})
         
         snippet mat
         matrix(${1:data}, nrow = ${2:rows}, ncol = ${3:cols})
         
         snippet sg
         setGeneric("${1:generic}", function(${2:x, ...}) {
           standardGeneric("${1:generic}")
         })
         
         snippet sm
         setMethod("${1:generic}", ${2:class}, function(${2:x, ...}) {
           ${0}
         })
         
         snippet sc
         setClass("${1:Class}", slots = c(${2:name = "type"}))
         
         snippet if
         if (${1:condition}) {
           ${0}
         }
         
         snippet el
         else {
           ${0}
         }
         
         snippet ei
         else if (${1:condition}) {
           ${0}
         }
         
         snippet fun
         ${1:name} <- function(${2:variables}) {
           ${0}
         }
         
         snippet for
         for (${1:variable} in ${2:vector}) {
           ${0}
         }
         
         snippet while
         while (${1:condition}) {
           ${0}
         }
         
         snippet switch
         switch (${1:object},
                 ${2:case} = ${3:action}
         )
         
         snippet apply
         apply(${1:array}, ${2:margin}, ${3:...})
         
         snippet lapply
         lapply(${1:list}, ${2:function})
         
         snippet sapply
         sapply(${1:list}, ${2:function})
         
         snippet mapply
         mapply(${1:function}, ${2:...})
         
         snippet tapply
         tapply(${1:vector}, ${2:index}, ${3:function})
         
         snippet vapply
         vapply(${1:list}, ${2:function}, FUN.VALUE = ${3:type}, ${4:...})
         
         snippet rapply
         rapply(${1:list}, ${2:function})
         
         snippet ts
         `r paste("#", date(), "------------------------------\n")`
         
         snippet shinyapp
         library(shiny)
         
         ui <- fluidPage(
           ${0}
         )
         
         server <- function(input, output, session) {
           
         }
         
         shinyApp(ui, server)
         
         snippet shinymod
         ${1:name}_UI <- function(id) {
           ns <- NS(id)
           tagList(
             ${0}
           )
         }
         
         ${1:name} <- function(input, output, session) {
           
         }
         
         