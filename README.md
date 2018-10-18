
Topic Modeling using LDA

In analyzing text data, we attempt to derive meaning from a collection of documents. Primarily, this involves statistically separating these documents into groups based on their characteristics. One popular method of achieving this is through Topic Modeling. Topic modeling is an unsupervised classification method for extracting topics from collections of documents, where the topics or groups are unobserved. The statistical method driving the classification of documents to topics is a form of natural language processing known as Latent Dirichlet Allocation, or LDA.

The driving principles behind the LDA algorithm are as follows:

•	A document can be represented as a mixture of topics

•	Every topic can be represented by a mixture of words

There are two packages in R that support Topic Modeling latent Dirichlet allocation (LDA) : 

•	topicmodels

•	lda

In this I read text from csv file then I convert it to corpus. I also applied pre-processing on the text using R package "tm": Such as stop words, stemming, and removing numbers. 
I remove the low frequently words (Sparse Terms) after converting the corpus into Term Document Matrix.
