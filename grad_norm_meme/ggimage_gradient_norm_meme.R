library("ggplot2")
library("ggimage")

# create a dataframe, and add image filenames as a column:
training_step <- 1:10
grad_norm <- c(1.5, 1.2, 1.3, 1.7, 8, 1.8, 1.8, 1.9, 2.3, 2)
d <- data.frame(training_step, grad_norm,
                image = c("doomer.png",
                                 "doomer.png",
                                 "doomer.png",
                                 "doomer.png",
                                 "Surprised_Pikachu.png",
                                 "doomer.png",
                                 "doomer.png",
                                 "doomer.png",
                                 "doomer.png",
                                 "doomer.png"))

# Plot:
ggplot(d, aes(training_step, grad_norm)) + geom_image(aes(image=image), size=.13)+ ylim(1,10)+xlim(0,11)+
  theme(
    axis.text.x = element_blank(), #remove the rowname as default label
    axis.text.y = element_blank(), #remove the rowname as default label
    axis.ticks = element_blank(), # remove ticks
    axis.title=element_text(size=24,face="bold"), #Change defaults values for axis title fonts
    plot.title = element_text(size=28,face="bold",color = "red", hjust=0.45, vjust=-10)
    )+ 
    xlab("Training Steps") + ylab("Grad Norm")+
    ggtitle("The Exploding Gradient Problem")+
    annotate("text", color = "dark grey", x=10, y=1, label="@ever_ambiguous") #add annotations to the plot

# More options:
# Add texts
# + geom_text()
# Change the size of the texts
# + geom_text(size=6)
# Change vertical and horizontal adjustement
# +  geom_text(hjust=0, vjust=0)
# Change fontface. Allowed values : 1(normal),
# 2(bold), 3(italic), 4(bold.italic)
# + geom_text(aes(fontface=2))
