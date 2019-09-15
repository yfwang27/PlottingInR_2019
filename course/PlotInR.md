Plotting in R
========================================================
author: MRC London Institute of Medical Sciences (LMS)
date: https://lmsbioinformatics.github.io/LMS_PlottingInR/
width: 1440
height: 1100
autosize: true
font-import: <link href='http://fonts.googleapis.com/css?family=Slabo+27px' rel='stylesheet' type='text/css'>
font-family: 'Slabo 27px', serif;
css:style.css

Materials.
========================================================
id: materials

All prerequisites, links to material and slides for this course can be found on github.
* [PlottingInR](https://lmsbioinformatics.github.io/LMS_PlottingInR/)

Or can be downloaded as a zip archive from here. 
* [Download zip](https://github.com/LMSBioinformatics/LMS_PlottingInR/archive/master.zip)


Set the Working directory
========================================================

Before running any of the code in the practicals or slides we need to set the working directory to the folder we unarchived. 

You may navigate to the unarchived LMS_PlottingInR/course folder in the Rstudio menu

**Session -> Set Working Directory -> Choose Directory**

<div align="center">
<img src="figures/R_set_path.png" alt="path" height="700" width="1200">
</div>


Set working directory - in the console
========================================================

Use getwd() to see where your current directory is


```r
getwd()
```

Use setwd() to see where your current directory is


```r
setwd("/PathToMyDownload/LMS_PlottingInR/course")
# e.g. setwd("~/Downloads/LMS_PlottingInR/course")
```

Plotting in R
========================================================
type:section
id:plotting

Introduction
========================================================

R has excellent graphics and plotting capabilities. They are mostly found in following three sources.
 + base graphics
 
    easy to use, conceptually motivated by drawing on a canvas
    
    would become difficult or impossible to draw complicated plots
    
 + the lattice package
 + the ggplot2 package
 
    high-level approach: grammar of graphics

 + saving your plots

 
Lattice and ggplot2 packages are built on grid graphics package while the base graphics routines adopt a pen and paper model for plotting.

We will start from the base graphics then focus on ggplot2



R Base Graphics
========================================================
type:section
id: baseGraph

Base Graphics
========================================================
+ Line Charts

First we'll produce a very simple graph using the values in the data.frame that we created:


```r
base_graph_df<- data.frame(sample_num=c(1:6),
                           treatment=c(0.02,1.8, 17.5, 55,75.7, 80),
                           control= c(0, 20, 40, 60, 80,100))

base_graph_df
```

```
  sample_num treatment control
1          1      0.02       0
2          2      1.80      20
3          3     17.50      40
4          4     55.00      60
5          5     75.70      80
6          6     80.00     100
```

Base Graphics
========================================================
+ Line Charts

Plot the treatment with default parameters


```r
?plot
```

    * Usage

    plot(x, y, ...)



```r
plot(base_graph_df$sample_num, base_graph_df$treatment)
```

Line Plot
========================================================


<img src="PlotInR-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" width="1920px" />

=======================================================
Now, let's add a **title**, a **line to connect the points**, and some **colour**:

Plot treatment using blue points overlayed by a line

hint: look into the "type" argument


```r
?plot
```

## Arguments

  * type: what type of plot should be drawn. Possible types are

        "p" for points,
        "l" for lines,
        "b" for both,
        "c" for the lines part alone of "b",
        "o" for both ‘overplotted’,
        "h" for ‘histogram’ like (or ‘high-density’) vertical lines,
        "s" for stair steps,
        "S" for other steps, see ‘Details’ below,
        "n" for no plotting.

=======================================================


```r
plot(base_graph_df$sample_num,base_graph_df$treatment, type="o", col="blue")
```

Create a title with a red, bold/italic font

hint: 1=plain, 2=bold, 3=italic, 4=bold italic, 5=symbol

```r
title(main="Treatment", col.main="red", font.main=4)
```

Line Plot
========================================================
<img src="PlotInR-figure/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" width="1920px" />

========================================================
Now let's add a **red line for control column** from the data.frame **base_graph_df** and **specify the y-axis range** directly so it will be large enough to fit the data:

* show the control information

```r
base_graph_df$control
```

```
[1]   0  20  40  60  80 100
```

* Plot **treatment** using a y axis that ranges from 0 to 100

```r
plot(base_graph_df$sample_num,base_graph_df$treatment, type="o", col="blue", ylim=c(0,100))
```
* Plot **control** with **red dashed line** and **square points** [hint: pch=0]

```r
lines(base_graph_df$control, type="o", pch=0, lty="dashed", col="red")
```

* Create a title with a red, bold/italic font

```r
title(main="Expression Data", col.main="red", font.main=4)
```

==========================================================

<img src="PlotInR-figure/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" width="1920px" />

Plotting ‘character’ (pch) - symbol to use
==========================================================

![plot of chunk unnamed-chunk-16](PlotInR-figure/unnamed-chunk-16-1.png)

The line type - lty
==========================================================

lty can be c("blank",solid", "dashed", "dotted", "dotdash", "longdash", "twodash") or number c(0, 1, 2, 3, 4, 5, 6)

![plot of chunk unnamed-chunk-17](PlotInR-figure/unnamed-chunk-17-1.png)

change axes labels, colour and add legend
==========================================================

Next let's change the axes labels to match our data and add a legend. 

We'll also compute the y-axis values using the max function so any changes to our data will be automatically reflected in our graph. 

* Calculate range from 0 to max value of data

```r
g_range <- range(0, base_graph_df$treatment, base_graph_df$control)
g_range
```

```
[1]   0 100
```

range returns a vector containing the minimum and maximum of all the given arguments.

* Plot treatment using y axis that ranges from 0 to max value in treatment or control vector.  Turn off axes and annotations (axis labels) so we can specify them ourselves.


```r
plot(base_graph_df$sample_num ,base_graph_df$treatment, 
     type="o", col="blue", 
     ylim=g_range,axes=FALSE, ann=FALSE)
```

========================================================

Make x axis using labels

```r
axis(1, at=1:6, lab=base_graph_df$sample_num)
```

Make y axis with horizontal labels that display ticks at every 20 marks. 


```r
axis(2, las=1, at=20*0:g_range[2])
```

Create box around plot

```r
box()
```

========================================================

Plot control vector with red dashed line and square points


```r
lines(base_graph_df$control, type="o", pch=22, lty=2, col="red")
```

Create a title with a red, bold/italic font

```r
title(main="Data", col.main="red", font.main=4)
```

Label the x and y axes with dark green text

```r
title(xlab="Samples", col.lab="purple")
title(ylab="Values", col.lab="purple")
```

========================================================

Create a legend at (1, g_range[2]) that is slightly smaller (cex) and uses the same line colors and points used by the actual plots 


```r
legend(1, g_range[2], c("treatment","control"), cex=0.8, col=c("blue","red"), pch=21:22, lty=1:2);  
```

<img src="PlotInR-figure/unnamed-chunk-27-1.png" title="plot of chunk unnamed-chunk-27" alt="plot of chunk unnamed-chunk-27" width="1920px" />
 	


ggplot2 R package
========================================================
type:section
id:ggplot2

ggplot2 is a powerful R package based on the grammar of graphics (Wilkinson, 2005). 

"In brief, the grammar tells us that a statistical graphic is a mapping from data to aesthetic attributes (colour, shape, size) of geometric objects (points, lines, bars)." - Wickham, 2016


ggplot2
========================================================

 + scatter plot
 
 + box plot
 
 + bar chart
 
 + histogram
 
 + density plot
 
 + faceting
 
 + aestheics

 + saving plots



ggplot2 R package
========================================================

We'll use the **GoT_dataset** that kindly provided by Dr. Reidar P. Lystad. Inj Epidemiol. 2018. 5(1):44. doi: 10.1186/s40621-018-0174-7. (https://figshare.com/articles/Game_of_Thrones_mortality_and_survival_dataset/8259680)

We can use the head function to look at the first few rows of file "episode_data.csv"

```r
library(ggplot2)
episode_data<-read.csv("GoT_dataset/episode_data.csv")

head(episode_data)
```

```
  season episode_number                            episode_name
1      1              1                      "Winter Is Coming"
2      1              2                         "The Kingsroad"
3      1              3                             "Lord Snow"
4      1              4 "Cripples, Bastards, and Broken Things"
5      1              5                 "The Wolf and the Lion"
6      1              6                        "A Golden Crown"
  gross_running_time opening_credits_time closing_credits_time
1               3546                  110                   33
2               3182                  111                   34
3               3294                   96                   27
4               3201                   96                   26
5               3123                  101                   24
6               3027                  103                   26
  net_running_time cumulative_net_running_time
1             3403                        3403
2             3037                        6440
3             3171                        9611
4             3079                       12690
5             2998                       15688
6             2898                       18586
```


========================================================

## Every ggplot2 plot has three key components:

    1. data,
    
    2. aesthetic mappings between variables in the data and visual
    properties, and
    
    3. layer: usually created with a geom function.


========================================================

use ggplot2's ggplot() function to setup **data** and **aesthetic mappings**


```r
g<-ggplot(data=episode_data, aes(x=gross_running_time,y=net_running_time))

print(g)
```

![plot of chunk unnamed-chunk-29](PlotInR-figure/unnamed-chunk-29-1.png)


add geom_point layer - Scatter plot
========================================================


```r
g<-ggplot(data=episode_data, aes(x=gross_running_time,y=net_running_time))
g + geom_point()
```

![plot of chunk unnamed-chunk-30](PlotInR-figure/unnamed-chunk-30-1.png)


add geom_histogram layer - Histogram plot (1/2)
========================================================



```r
ghis<-ggplot(data=episode_data, aes(x=net_running_time))
ghis + geom_histogram()
```

![plot of chunk unnamed-chunk-31](PlotInR-figure/unnamed-chunk-31-1.png)

add geom_histogram layer - Histogram plot (2/2)
========================================================
change binwidth


```r
#ghis<-ggplot(data=episode_data, aes(x=net_running_time))
ghis + geom_histogram(binwidth=200)
```

![plot of chunk unnamed-chunk-32](PlotInR-figure/unnamed-chunk-32-1.png)


add geom_density layer - Density plot (1/3)
========================================================
add geom_density layer


```r
ghis<-ggplot(data=episode_data, aes(x=net_running_time))
ghis + geom_density()
```

![plot of chunk unnamed-chunk-33](PlotInR-figure/unnamed-chunk-33-1.png)


add geom_density layer - Density plot (2/3)
========================================================


```r
ghis<- ggplot(data=episode_data, aes(x=net_running_time,fill=as.factor(season)))
ghis + geom_density() 
```

![plot of chunk unnamed-chunk-34](PlotInR-figure/unnamed-chunk-34-1.png)

add geom_density layer - Density plot (3/3)
========================================================


```r
ghis<- ggplot(data=episode_data, aes(x=net_running_time,fill=as.factor(season)))
ghis + geom_density(alpha=0.25) 
```

![plot of chunk unnamed-chunk-35](PlotInR-figure/unnamed-chunk-35-1.png)

Bar plot (1/2) - geom_bar()
========================================================
add geom_bar layer


```r
episode_data$season<-as.factor(episode_data$season)
gbar<- ggplot(data=episode_data, aes(x=season))
gbar + geom_bar() 
```

![plot of chunk unnamed-chunk-36](PlotInR-figure/unnamed-chunk-36-1.png)

Bar plot (2/2) - coord_flip ()
========================================================

use different colours for different seasons and also change the labels


```r
gbar + geom_bar() + coord_flip()
```

![plot of chunk unnamed-chunk-37](PlotInR-figure/unnamed-chunk-37-1.png)


Exercise 
========================================================
Time for exercise - 5 mins to review what we have gotten so far....



Box plot (1/7) - use geom_boxplot()
========================================================
use "Got_dataset/short_data.csv" dataset


```r
subset_GoT<-read.csv(file="Got_dataset/subset_GoT.csv")

head(subset_GoT)
```

```
   id         name sex        religion            occupation social_status
1 100 Waymar Royce   M Unknown/Unclear Boiled leather collar       Lowborn
2 101 Gared Tuttle   M Unknown/Unclear Boiled leather collar       Lowborn
3 102         Will   M Unknown/Unclear Boiled leather collar       Lowborn
4 103         Irri   F  Great Stallion Boiled leather collar       Lowborn
5 104     Jon Snow   M        Old Gods Boiled leather collar      Highborn
6 105   Bran Stark   M        Old Gods           Silk collar      Highborn
  allegiance_last allegiance_switched dth_flag exp_time_sec exp_time_hrs
1   Night's Watch                   N        1          342         0.10
2   Night's Watch                   N        1          405         0.11
3   Night's Watch                   N        1          692         0.19
4       Targaryen                   Y        1        48489        13.47
5   Night's Watch                   Y        0       230347        63.99
6           Stark                   N        0       230347        63.99
```


Box plot (2/7) - use geom_boxplot()
========================================================
add geom_boxplot layer


```r
ggplot(data=subset_GoT,aes(x=social_status,y=exp_time_hrs))+
  geom_boxplot()
```

![plot of chunk unnamed-chunk-40](PlotInR-figure/unnamed-chunk-40-1.png)

Box plot (3/7) - geom_point()
========================================================

add another layer


```r
ggplot(data=subset_GoT,aes(x=social_status,y=exp_time_hrs))+
  geom_boxplot() + geom_point()
```

![plot of chunk unnamed-chunk-41](PlotInR-figure/unnamed-chunk-41-1.png)

Box plot (4/7) - position_jitter()
========================================================


```r
ggplot(data=subset_GoT,aes(x=social_status,y=exp_time_hrs))+
  geom_boxplot() + geom_point(position = position_jitter())
```

![plot of chunk unnamed-chunk-42](PlotInR-figure/unnamed-chunk-42-1.png)


Box plot (5/7) - add colour
========================================================
add geom_bar layer


```r
ggplot(data=subset_GoT,aes(x=social_status,y=exp_time_hrs,fill=occupation))+
  geom_boxplot()
```

![plot of chunk unnamed-chunk-43](PlotInR-figure/unnamed-chunk-43-1.png)

Box plot (6/7) - facet_wrap()
========================================================
add facet_wrap() layer

facet_wrap(~variable)


```r
ggplot(data=subset_GoT,aes(x=social_status,y=exp_time_hrs,fill=occupation))+
  geom_boxplot()+facet_wrap(~sex)
```

![plot of chunk unnamed-chunk-44](PlotInR-figure/unnamed-chunk-44-1.png)

Box plot (7/7) - facet_grid()
========================================================
add facet_grid() layer

facet_grid(Rows.for.var1~Columns.for.var2)


```r
ggplot(data=subset_GoT,aes(x=social_status,y=exp_time_hrs,fill=occupation))+
  geom_boxplot()+facet_grid(dth_flag~sex)
```

![plot of chunk unnamed-chunk-45](PlotInR-figure/unnamed-chunk-45-1.png)



Saving your plots - ggsave
========================================================

* It defaults to saving the last plot that you displayed, using the size of the current graphics device

* It also guesses the type of graphics device from the extension

* device: "eps", "ps", "tex" (pictex), "pdf", "jpeg", "tiff", "png", "bmp", "svg" or "wmf" (windows only)


Saving your plots - ggsave (1/2)
========================================================



```r
ggplot(mtcars, aes(mpg, wt)) + geom_point()
ggsave("mtcars_default.pdf")
ggsave("mtcars.pdf", width = 4, height = 4)
```

Saving your plots - ggsave (2/2)
========================================================
Plot to save, defaults to last plot displayed.

ggsave(filename, plot = last_plot(), device = NULL, path = NULL,
  scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
  dpi = 300, limitsize = TRUE, ...)


```r
plot1<-ggplot(mtcars, aes(mpg, wt)) + geom_point()
plot2<-ggplot(mtcars, aes(mpg, wt,col=as.factor(vs))) + geom_point()

ggsave("mtcars_default.png",plot1)
ggsave("mtcars_col.png",plot2)
```


Summary
========================================================
- Visualization of data through charts and graphs is an essential 
part of data analysis process, so R has excellent tools for creating 
graphics.
- There are many different ways of making plots in R
including base graphics and R packages such as lattics and ggplot2.
- Use vast arrays of R packages available to create 
publication quality graphs.


Base Graphics VS ggplot2 (1/5)
========================================================

Base Graphic 1


```r
base_graph_df
```

```
  sample_num treatment control
1          1      0.02       0
2          2      1.80      20
3          3     17.50      40
4          4     55.00      60
5          5     75.70      80
6          6     80.00     100
```

![plot of chunk unnamed-chunk-49](PlotInR-figure/unnamed-chunk-49-1.png)

Base Graphics VS ggplot2 (2/5)
========================================================

Base Graphic 2


```r
plot(base_graph_df$sample_num ,base_graph_df$treatment, type="o", col="blue", ylim=g_range,axes=FALSE, ann=FALSE)
axis(1, at=1:6, lab=base_graph_df$days)
axis(2, las=1, at=20*0:g_range[2])
box()

lines(base_graph_df$control, type="o", pch=22, lty=2, col="red")
title(main="Expression Data", col.main="red", font.main=4)
title(xlab="Samples", col.lab="purple")
title(ylab="Values", col.lab="purple")
legend(1, g_range[2], c("treatment","control"), cex=0.8, col=c("blue","red"), pch=21:22, lty=1:2);  
```

Base Graphics VS ggplot2 (3/5)
========================================================

ggplot2 - prepare the data.frame


```r
# covert data.frame into the format that ggplot likes
# install.packages("reshape2")
library("reshape2")

base_graph_4gg<-melt(base_graph_df, id.vars="sample_num")
base_graph_4gg$variable<-relevel(base_graph_4gg$variable,ref="control")
head(base_graph_4gg,n=10)
```

```
   sample_num  variable value
1           1 treatment  0.02
2           2 treatment  1.80
3           3 treatment 17.50
4           4 treatment 55.00
5           5 treatment 75.70
6           6 treatment 80.00
7           1   control  0.00
8           2   control 20.00
9           3   control 40.00
10          4   control 60.00
```


Base Graphics VS ggplot2 (4/5)
========================================================

ggplot2 - plot the figure with default settings


```r
library("ggplot2")

ggplot(base_graph_4gg,aes(x=sample_num,y=value,col=variable,group=variable)) +
  geom_point(aes(shape=variable))+
  geom_line(aes(linetype=variable))+
  labs(title="Expression Data",x ="Sample", y = "Values")
```

![plot of chunk unnamed-chunk-52](PlotInR-figure/unnamed-chunk-52-1.png)

Base Graphics VS ggplot2 (5/5)
========================================================
ggplot2 - plot the figure that matches base grahpics



```r
ggplot(base_graph_4gg,aes(x=sample_num,y=value,col=variable,group=variable)) +
  geom_point(aes(shape=variable))+
  geom_line(aes(linetype=variable))+
  scale_color_manual(values=c("red", "blue"))+
  scale_shape_manual(values=c(0,1))+
  scale_linetype_manual(values=c("dashed","solid"))+
  labs(title="Expression Data",x ="Sample", y = "Values")+
  theme_classic()+
  theme(plot.title = element_text(colour = "red",face="bold.italic",hjust = 0.5),
        axis.title = element_text(colour = "purple"))
```

![plot of chunk unnamed-chunk-53](PlotInR-figure/unnamed-chunk-53-1.png)


========================================================
Time for an exercise!
========================================================
Exercise on Plotting can be found [here](http://mrccsc.github.io/Reproducible-R/r_course/exercises/Plotting_exercise.html)
Answers to exercise.
========================================================
Answers can be found here [here](answers/Plotting_answers.html)



Combining Plots
======================================================== 


R makes it easy to combine multiple plots into one overall graph, using either the par( ) or layout( ) function. 
With the par( ) function, you can include the option mfrow=c(nrows, ncols) to create a matrix of nrows x ncols plots that are filled in by row.
mfcol=c(nrows, ncols) fills in the matrix by columns.

Define a layout with 2 rows and 2 columns


```r
par(mfrow=c(2,2))
```


========================================================

Here, we will use different dataset with two columns each for treated and untreated samples.


```r
data1 <- read.table("data/gene_data.txt", header=T, sep="\t")
head(data1)
```

```
     ensembl_gene_id Untreated1 Untreated2  Treated1   Treated2
1 ENSDARG00000093639  0.8616832  1.9311442 0.1041508 0.14055604
2 ENSDARG00000094508  0.9857575  2.0256352 0.1549917 0.20301609
3 ENSDARG00000095893  0.8498889  1.9875580 0.2317969 0.20925123
4 ENSDARG00000095252  0.9242996  2.0857620 0.2562264 0.24669079
5 ENSDARG00000078878  0.3571734  0.4653908 0.1167221 0.09710237
6 ENSDARG00000079403  1.0604071  1.2581398 0.3884836 0.31567299
```

========================================================

Plot histograms for different columns in the data frame separately. This is not very efficient. 
You could also do it more efficiently using for loop.


```r
hist(data1$Untreated1)
hist(data1$Treated2)
hist(data1$Untreated2)
boxplot(data1$Treated1)
```

========================================================

 
![plot of chunk unnamed-chunk-57](PlotInR-figure/unnamed-chunk-57-1.png)

========================================================

Recover the original settings


```r
par(mfrow=c(1,1))
```

