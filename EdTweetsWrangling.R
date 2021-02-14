# ASSIGNMENT DESCRIPTION #####################################
# File:         Week4Wrangling.R
# Project:      Unit 1 - Independent Analysis 
# Author:       Jennifer Houchins
#
# Purpose:      Pull tweets from Twitter for independent analysis.
#

if (!require("pacman")) install.packages("pacman")
#load packages
pacman::p_load(twitteR, tidyverse, rtweet, tidytext)

datafilePath <- "data/education_tweets.csv"

# Keys removed for security/push to Github
consumer_key <- 'XXXXXXXXXXXXXXXXXXXXXXXXXX'
consumer_secret <- 'XXXXXXXXXXXXXXXXXXXXXXXXXX'
access_token <- 'XXXXXXXXXXXXXXXXXXXXXXXXXX'
access_secret <- 'XXXXXXXXXXXXXXXXXXXXXXXXXX'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# grab 5000 tweets for the hashtags (edchat, nced, onlinelearning), 
# put them in dataframes, and add a column for the tag
edchattweets <- searchTwitter('#edchat',
                              n = 5000, since = '2020-01-01',
                              retryOnRateLimit = 1e3)
edchattweets_df <- twListToDF(edchattweets) %>%
  mutate(tag = "edchat")

ncedtweets <- searchTwitter('#nced',
                            n = 5000, since = '2020-01-01',
                            retryOnRateLimit = 1e3)
ncedtweets_df <- twListToDF(ncedtweets) %>%
  mutate(tag = "nced")

onlinelearningtweets <- searchTwitter('#onlinelearning',
                                      n = 5000, since = '2020-01-01',
                                      retryOnRateLimit = 1e3)
onlinelearningtweets_df <- twListToDF(onlinelearningtweets)%>%
  mutate(tag = "onlinelearning")


# append all the dataframes into a single one that can be written to csv
education_tweets_df <- rbind(edchattweets_df, 
                             ncedtweets_df, 
                             onlinelearningtweets_df)

#write to csv to be used in an R markdown presentation
write_csv(education_tweets_df, datafilePath)

# the code below is testing for the functions used in the Week 4 Rmd file that
# presents my analysis of the Twitter data.

# datafilePath <- "data/education_tweets.csv"
# ed_tweets <- read_csv(datafilePath) %>% 
#   filter(tag != "onlinelearning") #%>%
#   #filter(isRetweet == "FALSE") %>%
#   #select(text, tag)
# 
# 
# tidy_tweets <- unnest_tokens(ed_tweets, word, text)
# ed_tweets_clean <- anti_join(tidy_tweets, stop_words)
# head(ed_tweets_clean)
# 
# tweet_counts <- count(ed_tweets_clean, word, sort = TRUE)
# 
# 
# most_Retweets <- ed_tweets %>%
#   arrange(-retweetCount) %>%
#   slice(1) %>%
#   select(created, screenName, text, retweetCount, id)
# # install.packages("devtools")
# devtools::install_github("gadenbuie/tweetrmd")
# devtools::install_github('rstudio/webshot2')
# 
# 
# tweet_screenshot(tweet_url(most_Retweets$screenName, most_Retweets$id))
