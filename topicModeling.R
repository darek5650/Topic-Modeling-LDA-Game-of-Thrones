

#required libraries
library(tidytext) #tidy text analysis
library(tidyverse)
library(tm)
library(SnowballC)
library(topicmodels)

#set working directory (modify path as needed)
#setwd("users/topicmodels")
#load files into corpus

#get listing of .txt files in directory
#data <- list.files(getwd(),pattern="*.txt")

data<-read.csv("Game_of_thrones.csv",header=TRUE,stringsAsFactors=FALSE)
data <- data$Text

#read files into a character vector
#files <- lapply(data,readLines)

#create corpus from vector
corpus <- Corpus(VectorSource(data))

# make each letter lowercase
corpus <- tm_map(corpus, tolower)
# remove punctuation
corpus <- tm_map(corpus, removePunctuation)
#remove numbers
corpus <- tm_map(corpus, removeNumbers);
# remove generic and custom stopwords
stopword <- c(stopwords('english'), "best");
corpus <- tm_map(corpus, removeWords, stopword)
#corpus <- tm_map(corpus, stemDocument);

dtm<- DocumentTermMatrix(corpus, control = list(minWordLength = 3));
#dtm <- removeSparseTerms(dtm, sparse=0.98)

# k = 5;
# SEED = 1234;
# article.lda <- LDA(articleDtm2, k, method="Gibbs", control=list(seed = SEED))
# lda.topics <- as.matrix(topics(article.lda))
# lda.topics
# lda.terms <- terms(article.lda)
# lda.terms

lda <- LDA(dtm, k = 5, control = list(seed = 1234))

chapter_topics <- tidy(lda, matrix = "beta")

top_n(chapter_topics, 10)

Topic <- topics(lda, 1)
Terms <- terms(lda, 30)

top_terms <- chapter_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()
