# formbuildr
[![R-CMD-check](https://github.com/inSileco/formbuildr/workflows/R-CMD-check/badge.svg)](https://github.com/inSileco/formbuildr/actions?query=workflow%3AR-CMD-check)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

An R :package: to build forms with the command line interface.


```R
R> q1 <- one_among("Fruits?", c("Apple", "Pear")) 
R> q2 <- yes_or_no("Be or not to be?")
R> q3 <- yes_or_no("KevCaz?")
R> myform <- q1 %+% q2 %+% q3
R> myform() 
❓ Fruits?
ℹ Multiple choices
1 :  Apple 
2 :  Pear 
Enter your choice: 1
✔ validated!
❓ Be or not to be?
[Y]es or [No]: no
✔ validated!
❓ KevCaz?
[Y]es or [No]: yup
⚠ Validation failed, try again!
[Y]es or [No]: Y 
✔ validated!
[[1]]
[1] "Apple"

[[2]]
[1] FALSE

[[3]]
[1] TRUE

```


# Meta 

* Please report any issues or bugs: https://github.com/inSileco/formbuildr/issues
* License: GPL-3
* Please note that this package is released with a Contributor Code of Conduct (https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.