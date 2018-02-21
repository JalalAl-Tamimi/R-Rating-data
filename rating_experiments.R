### This script provides the analyses of the two rating experiments on nasalisation and voice quality.
### The data were analysed used Cumulative Link Mixed Models (CLMM) using the "ordinal" package
### with three crossed random factors (for the producing subject, the rater and the word) and by-rater slopes. 
### This is the optimal model as it allows raters to vary with respect to their answers with respect to the context.
### For the levels of "context" in both dataframes, "7" = "ħ" and "3" = "ʕ"
### Other models did not yield an improvment to the fit.
### For more details, see "Khattab, G., Al-Tamimi, J., and Al-Siraih, W., (accepted). Nasalisation in the production of Iraqi Arabic pharyngeals. Phonetica." 

### Each model was run using parallel computing (4 cores and a fast machine) under Microsoft R Open version 3.4.2, 
### and took around 2.30 hours to finish. Using the "normal" R distribution, each model may require 8 hours to run.

### start by loading packges and install those that are not installed
requiredPackages = c('ordinal')
for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}
fullCLMMVQSlope <- clmm(Response ~ Context + (1|Subject)+(1|Item)+(Context|Rater), data=percVQDF) 
summary(fullCLMMVQSlope)

fullCLMMNasSlope <- clmm(Response ~ Context + (1|Subject)+(1|Item)+(Context|Rater), data=percNasDF) 
summary(fullCLMMNasSlope)


### Below is the code to generate graphs for the ratings of voice quality and nasalisation
### based on the results of the CLMM using the base graphics engine. 
### The "beta" is the coefficient for each level of the fixed effect "context"
### and "Theta" is the coefficient for each threshold of the ratings, 1|2, 2|3, etc...

## VQ

## A high quality tiff image of the result can be generated using the two lines below. Remember to remove 
## the "#" before the line below and before "dev.off()"

#tiff(filename = "Rating.tiff", width = 15, height = 10, units = "cm", res = 300,compression = "lzw+p")

## below changes the margins
par(oma=c(1, 0, 0, 3),mgp=c(2, 1, 0))
xlimVQ = c(min(fullCLMMVQSlope$beta), max(fullCLMMVQSlope$beta))
ylimVQ = c(0,1)
plot(0,0,xlim=xlimVQ, ylim=ylimVQ, type="n", ylab=expression(Probability), xlab="", xaxt = "n",main="Predicted curves - Voice Quality",cex=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
axis(side = 1, at = c(0,fullCLMMVQSlope$beta),labels = levels(percVQDF$ContextIPA), las=2,cex=2,cex.lab=1.5,cex.axis=1.5)
xsVQ = seq(xlimVQ[1], xlimVQ[2], length.out=100)
lines(xsVQ, plogis(fullCLMMVQSlope$Theta[1] - xsVQ), col='black')
lines(xsVQ, plogis(fullCLMMVQSlope$Theta[2] - xsVQ)-plogis(fullCLMMVQSlope$Theta[1] - xsVQ), col='red')
lines(xsVQ, 1- (plogis(fullCLMMVQSlope$Theta[2] - xsVQ)), col='blue')
abline(v=c(0,fullCLMMVQSlope$beta),lty=3)
abline(h=0, lty="dashed")
abline(h=1, lty="dashed")
legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,lty=1, col=c("black", "red", "blue"), 
       legend=c("Breathy", "Modal", "Tense"),cex=0.75)
#dev.off()


## Nasalisation

## A high quality tiff image of the result can be generated using the two lines below. Remember to remove 
## the "#" before the line below and before "dev.off()"
#tiff(filename = "NasRating.tiff", width = 15, height = 10, units = "cm", res = 300,compression = "lzw+p")

## below changes the margins
par(oma=c(1, 0, 0, 3),mgp=c(2, 1, 0))
xlimNas = c(min(fullCLMMNasSlope$beta), max(fullCLMMNasSlope$beta))
ylimNas = c(0,1)
plot(0,0,xlim=xlimNas, ylim=ylimNas, type="n", ylab=expression(Probability), xlab="", xaxt = "n",main="Predicted curves - Nasalisation",cex=2,cex.lab=1.5,cex.main=1.5,cex.axis=1.5)
axis(side = 1, at = c(0,fullCLMMNasSlope$beta),labels = levels(percNasDF$ContextIPA), las=2,cex=2,cex.lab=1.5,cex.axis=1.5)
xsNas = seq(xlimNas[1], xlimNas[2], length.out=100)
lines(xsNas, plogis(fullCLMMNasSlope$Theta[1] - xsNas), col='black')
lines(xsNas, plogis(fullCLMMNasSlope$Theta[2] - xsNas)-plogis(fullCLMMNasSlope$Theta[1] - xsNas), col='red')
lines(xsNas, plogis(fullCLMMNasSlope$Theta[3] - xsNas)-plogis(fullCLMMNasSlope$Theta[2] - xsNas), col='green')
lines(xsNas, plogis(fullCLMMNasSlope$Theta[4] - xsNas)-plogis(fullCLMMNasSlope$Theta[3] - xsNas), col='orange')
lines(xsNas, 1-(plogis(fullCLMMNasSlope$Theta[4] - xsNas)), col='blue')
abline(v=c(0,fullCLMMNasSlope$beta),lty=3)
abline(h=0, lty="dashed")
abline(h=1, lty="dashed")
legend(par('usr')[2], par('usr')[4], bty='n', xpd=NA,lty=1, col=c("black", "red", "green", "orange", "blue"), 
       legend=c("Oral", "2", "3", "4", "Nasal"),cex=0.75)

#dev.off()
