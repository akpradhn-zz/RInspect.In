library(stringr)
library(plyr)
library(tidyr)

y<-read.csv("purchase_items.csv",header = TRUE)

#Make a subset for purchaseid_counts listed with single item.
# nchar to find string length . lenght of single item list is 8  
single_item<-subset(y[,2],nchar(as.character(y[,2]))==8)
single_item_df<-data.frame(single_item)
names(single_item_df)<-"item_frequency"

#Make a subset for purchaseid_counts listed with multiple items.
multiple_items<-subset(y[,2],nchar(as.character(y[,2]))>8)
item_frequency<-unlist(strsplit(as.character(multiple_items),"\\|"))
multiple_items_df<-data.frame(item_frequency)

#To bind to data frame column names must be same. Hence keeping it "item_frequency"

full_item_list<-rbind(single_item_df,multiple_items_df)

#Split the column into items and frequencies 

items_purchased<-separate(full_item_list,item_frequency,into = c("Items","Frequencies"),sep="_")
items_purchased$Items<-as.factor(items_purchased$Items)
items_purchased$Frequencies<-as.integer(items_purchased$Frequencies)
unique_item_purchased<-aggregate(Frequencies~Items,items_purchased,sum)


