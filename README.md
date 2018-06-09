The R script "rating_experiments_VQ_Nas.R" is used to generate Cumulative Link Mixed Models (CLMM) using the "ordinal" package. 
This was used on two rating experiments for ratings of voice quality and nasalisation in pharyngeals in Iraqi Arabic. 
The script starts by computing the two CLMMs based on the ratings of 6 raters. It specifies three crossed random factors (subject, item and
rater). A By-rater random slope for context is used to allow rater to vary with respect to their responses. 
The ".RData" file contains the actual data and CLMM models, and a few other details.

Following these, two chunks of code are provided to genrate two graphs using base R graphics. These graphs provide the predicted curves for each of the rating experiments (3 levels for Voice Quality; 5 for nasalisation). These predicted curves and the figures were implemented in R via a modified version of the scripts available from http://web.maths.unsw.edu.au/~loicthibaut/ordinalLab.html and http://stats.stackexchange.com/questions/89474/interpretation-of-ordinal-logistic-regression. 
See the two tiff images for examples.

A Notebook is available [here](Rating-VQ-Nas-Phonetica.nb.html).

For more details, see the reference:
* Khattab, G., Al-Tamimi, J., and Al-Siraih, W., (in press). "Nasalisation in the production of Iraqi Arabic pharyngeals". Phonetica.
