character_data<-read.csv("GoT_dataset/character_data_S01-S08.csv")

head(character_data)

#character_data$sex<-as.factor(character_data$sex)
#character_data$religion<-as.factor(character_data$religion)
#character_data$occupation<-as.factor(character_data$occupation)
#character_data$social_status<-as.factor(character_data$social_status)

short_data<-character_data[,c(1:35)]
short_data$sex<-ifelse(short_data$sex==1,"M","F")
short_data[short_data$religion==1,]$religion<-"Great Stallion"
short_data[short_data$religion==2,]$religion<-"Lord of Light"
short_data[short_data$religion==3,]$religion<-"Faith of the Seven"
short_data[short_data$religion==4,]$religion<-"Old Gods"
short_data[short_data$religion==5,]$religion<-"Drowned God"
short_data[short_data$religion==6,]$religion<-"Many Faced God"
short_data[short_data$religion==7,]$religion<-"Other"
short_data[short_data$religion==9,]$religion<-"Unknown/Unclear"

unique(short_data$occupation)
short_data[short_data$occupation==1,]$occupation<-"Silk collar"
short_data[short_data$occupation==2,]$occupation<-"Boiled leather collar"
short_data[short_data$occupation==9,]$occupation<-"Unknown/Unclear"

unique(short_data$social_status)
short_data[short_data$social_status==1,]$social_status<-"Highborn"
short_data[short_data$social_status==2,]$social_status<-"Lowborn"

unique(short_data$allegiance_last)
short_data[short_data$allegiance_last==1,]$allegiance_last<-"Stark"
short_data[short_data$allegiance_last==2,]$allegiance_last<-"Targaryen"
short_data[short_data$allegiance_last==3,]$allegiance_last<-"Night's Watch"
short_data[short_data$allegiance_last==4,]$allegiance_last<-"Lannister"
short_data[short_data$allegiance_last==5,]$allegiance_last<-"Greyjoy"
short_data[short_data$allegiance_last==6,]$allegiance_last<-"Bolton"
short_data[short_data$allegiance_last==7,]$allegiance_last<-"Frey"
short_data[short_data$allegiance_last==8,]$allegiance_last<-"Other"
short_data[short_data$allegiance_last==9,]$allegiance_last<-"Unknown/Unclear"

unique(short_data$allegiance_switched)
short_data$allegiance_switched<-ifelse(short_data$allegiance_switched==1,"N","Y")

write.csv(short_data,file="Got_dataset/short_data.csv",row.names = F)

#exp_time_sec#
#exp_time_hrs#

short_data<-read.csv(file="Got_dataset/short_data.csv")
subset_GoT<-short_data[,c(1:8,13,22,23)]
write.csv(subset_GoT,file="Got_dataset/subset_GoT.csv",row.names = F)
max(short_data$exp_time_sec)
short_data$dth_flag<-as.factor(short_data$dth_flag)
library(ggplot2)

ggplot(data=short_data,aes(x=social_status,y=exp_time_hrs))+
  geom_bar(stat="identity")

ggplot(data=short_data,aes(x=social_status,y=exp_time_hrs,fill=occupation))+
  geom_bar(stat="identity")

ggplot(data=short_data,aes(x=occupation))+
  geom_bar()

ggplot(data=short_data,aes(x=occupation,fill=social_status))+
  geom_bar()

ggplot(data=short_data,aes(x=occupation,fill=social_status))+
  geom_bar(position=position_dodge())

ggplot(data=short_data,aes(x=occupation,fill=social_status))+
  geom_bar(position=position_dodge()) + coord_flip()


ggplot(data=short_data,aes(x=occupation,fill=social_status))+
  geom_bar(position="dodge") + 
  facet_grid(sex~dth_flag)+ coord_flip()

ghis<-ggplot(data=short_data, aes(x=exp_time_hrs))
ghis + geom_histogram()

ghis<-ggplot(data=short_data, aes(x=exp_time_hrs,fill=social_status))
ghis + geom_histogram(alpha=0.5,binwidth =20)

ghis + geom_density(alpha=0.5)




episode_data$season<-as.factor(episode_data$season)
gbox<- ggplot(data=episode_data, aes(x=season,y=net_running_time,fill=season))
gbox + geom_boxplot() + labs(x="Season",y="Net Running Time")


ggplot(data=episode_data, aes(x=season,y=net_running_time,fill=season))+
  geom_bar(stat="identity")
gbox

Histograms
========================================================	
  
  Let's start with a simple histogram plotting the distribution of the treatment vector: 

Create a histogram for treatment
```{r,eval=FALSE}
hist(base_graph_df$treatment)	
```

```{r,echo=FALSE,fig.width=8,fig.height=3,dpi=300,out.width="1920px",height="1080px"}
hist(base_graph_df$treatment)  
```

========================================================

Concatenate the three vectors

```{r}
all <- c(base_graph_df$control, base_graph_df$treatment)
```

Create a histogram for data in light blue with the y axis ranging from 0-10
```{r,eval=FALSE}
hist(all, col="lightblue", ylim=c(0,10))
```

```{r,echo=FALSE,fig.width=10,fig.height=10}
hist(all, col="lightblue", ylim=c(0,10))
```

======================================================== 	

Now change the breaks so none of the values are grouped together and flip the y-axis labels horizontally. 

Compute the largest value used in the data

```{r}
max_num <- max(all)
```

Create a histogram for data with fire colors, set breaks so each number   is in its own group, make x axis range from 0-max_num, disable right-closing  of cell intervals, set heading, and make  y-axis labels horizontal.

========================================================

```{r,eval=FALSE}
hist(all, col=heat.colors(max_num), breaks=max_num, xlim=c(0,max_num), right=F, 
main="Histogram", las=1)	
```

breaks: a single number giving the number of cells for the histogram,
An open interval does not include its endpoints, and is indicated with parentheses.

For example (0,1) means greater than 0 and less than 1. 

A closed interval includes its endpoints, and is denoted with square brackets. 
For example [0,1] means greater than or equal to 0 and less than or equal to 1.



========================================================

```{r,echo=FALSE,fig.width=8,fig.height=4.5,dpi=300,out.width="1920px",height="1080px"}
hist(all, col=heat.colors(max_num), breaks=max_num, xlim=c(0,max_num), right=F, 
main="Histogram", las=1)  
```

========================================================

Now let's create uneven breaks and graph the probability density. 

Create uneven breaks
```{r}
brk <- c(0,30,40,50,60,80,100)
```

Create a histogram for all data with fire colours, set uneven breaks, make x axis range from 0-max_num, disable right-closing of cell intervals, set heading, make y-axis labels horizontal, make axis labels smaller, make areas of each column proportional to the count

========================================================
  
  ```{r,eval=FALSE}

hist(all, col=heat.colors(length(brk)), breaks=brk,xlim=c(0,max_num), right=F, main="Probability Density",las=1, cex.axis=0.8, freq=F)
```


freq	logical; 
if TRUE, the histogram graphic is a representation of frequencies

if FALSE, probability densities, component density, are plotted

```{r,echo=FALSE,fig.width=12,fig.height=10}
#r,echo=FALSE,fig.width=4,fig.height=3,dpi=300,out.width="1920px",height="1080px"
hist(all, col=heat.colors(length(brk)), breaks=brk,xlim=c(0,max_num), right=F, main="Probability Density",las=1, cex.axis=0.8, freq=F)
```
