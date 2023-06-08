setwd("C:/Users/User/OneDrive - University of Cape Town/RO1_Escape_kinetics_project/Alignments_Nono_article")
 input_data <- read.table("Identities_combined.txt", header = TRUE)
#basic dot plot
# Basic dot plot
library(ggplo2)
# Basic dot plot
ggplot(input_data, aes(x=Group, y=Identity_)) + 
  +     geom_boxplot()+
  +     geom_dotplot(binaxis='y', stackdir='center')+
  +     labs(title="Dotplot Identity to a consensus",x="Group", y ="Identity")+
  +     theme_classic()

 # Change color by groups
 dp <-ggplot(input_data, aes(x=Group, y=Identity_, fill=Group)) + 
    +     geom_dotplot(binaxis='y', stackdir='center')+
    +     labs(title="Dotplot Identity to a consensus",x="Group", y ="Identity",dotsize=0.3)
   dp + theme_classic()
  
# Add box plots
     ggplot(input_data, aes(x=Group, y=Identity_, fill=Group)) +
    +     geom_boxplot(fill="white")+
    +     geom_dotplot(binaxis='y', stackdir='center')