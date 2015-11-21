library(reshape)
library(lubridate)

# tm: text mining library for R
library(tm)

# set working Directory
setwd('~/Dropbox/DS/Metis/challenge/') 

# Fork the mbostock/d3 repository into my github account 
# then  git clone https://github.com/martingascon/d3
# git log --pretty=format:"%h,%an,%ad,%s" > log.txt

############################################################################### Minimum Wage
# read log.txt
log = read.csv("./d3/log.txt", sep=",",head=F,)                          
colnames(log) <-c("commit","author","date","subject")

# remove those with empty spaces in subject
log <-log[-which(log$subject == ""),]

# Convert the date column into a date type
log$date <- as.Date(log$date , "%a %b %d %H:%M:%S %Y %z")

#1) ########################################### WEEK WITH MORE COMMITS 
# what week in the last year had the greatest number of commits?

# a) create a variable week_nb with week numbers 
# (there are three possible formats)

# %U - Week Nb, starting with the first Sunday as the first day 
# of the first week (00..53)
# %V - Week number of year according to ISO-8601 (01..53)
# %W - Week number of the year, starting with the first 
# Monday as the first day of the first week (00..53) 

Week_nb1 <- format(log$date, format="%y/%U")
sort(table(Week_nb1),decreasing=T)[1:3]
## Weeks 5 and 42 in 2015 are one with more commits (19)

Week_nb2 <- format(log$date, format="%y/%V")
sort(table(Week_nb2),decreasing=T)[1:3]
## Week 6 in 2015 is the one with more commits (25)

Week_nb3 <- format(log$date, format="%y/%W")
sort(table(Week_nb3),decreasing=T)[1:3]
## Week 5 in 2015 is the one with more commits (25)

#2) ########################################### DAY WITH MORE COMMITS
# Over the last year, what day of the week had the most commits?
sort(table(log$date),decreasing=T)[1:3]
## Feb 7th,2015 is the day with more commits (16)

#3) ################################### GRAPH COMMITS/DAY-OF-THE-WEEK
# Graph the number of commits per day of the week.
barplot(table(wday(log$date, label=TRUE)))


#4 ################################### EXTRA FROM D3
# Tell or show us something else interesting about the d3 repository
# paste every subject together
subject_vector <- paste(log$subject, collapse=" ")

# set up the source and create a corpus
subject_source <- VectorSource(subject_vector)
corpus <- Corpus(subject_source)

# Now, we transform to lower, remove punctuation, whitespace, stopwords
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# create the document-term matrix.
dtm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)

#most frequently used words

frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)
head(frequency)

barplot(frequency[1:5], label=TRUE)


### Another way to plot the top 15 words.
install.packages('wordcloud')
library(wordcloud)
words <- names(frequency)
wordcloud(words[1:15], frequency[1:15])





