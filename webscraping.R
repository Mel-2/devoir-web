library(rvest)
library(dplyr)
library(ggplot2)

#scrap coupe du monde
url_coupedumonde="https://www.skysports.com/world-cup-table"
dataread=rvest::read_html(url_coupedumonde)
dataread

tableaux=rvest::html_table(dataread)
length(tableaux)
tableaux

#####################################

##Creation d'une fonction
coupe_du_monde= function(){
  url_coupedumonde="https://www.skysports.com/world-cup-table"
  dataread=rvest::read_html(url_coupedumonde)
  tableaux=rvest::html_table(dataread)
  tfootball=do.call(rbind,list(tableaux[[1]],tableaux[[2]],tableaux[[3]],tableaux[[4]],tableaux[[5]],tableaux[[6]],tableaux[[7]],tableaux[[8]]))
  tfootball=tfootball[,-2]       
  tfootball=tfootball[,-9]
  return(tfootball)
}
dffootball=coupe_du_monde()
str(dffootball)

########################
#realisation d'un graphique en batons
dffootball%>%group_by(`Les 10 equipes`)%>%count()%>%arrange(desc(n))%>%
  head(10)%>%
  ggplot(aes(y=`Les 10 equipes`,x=n))+
  geom_bar(stat=`identity`)
