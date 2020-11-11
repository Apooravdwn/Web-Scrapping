link<-"https://www.imdb.com/chart/top"
library(robotstxt)
path<-paths_allowed(link)
library(rvest)
web<-read_html(link)
library(dplyr)
name<-web%>%html_nodes(".titleColumn a")%>%html_text()
year<-web%>%html_nodes(".secondaryInfo")%>%html_text()
rating<-web%>%html_nodes("strong")%>%html_text()
imdb.ratings<-data.frame(name,year,rating)
imdb.ratings$year<-gsub("\\(|\\)","",imdb.ratings$year)
imdb.ratings$year<-as.numeric(imdb.ratings$year)
imdb.ratings$rating<-as.numeric(as.character(imdb.ratings$rating))
imdb.ratings$rank<-c(1:250)
imdb.ratings<-imdb.ratings[c("rank","name","year","rating")]
set.seed(136)
imdb.ratings$boxoffice<-runif(50,min =500000,max = 1000000)
imdb.ratings$watch_list<-imdb.ratings$rating>8.5
imdb.ratings$watch_list<-as.factor(imdb.ratings$watch_list)
imdb.ratings[20,6]<-NA
View(imdb.ratings)


