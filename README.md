# formbuildr
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

R :package: to build forms with the command line interface.


```R
R> q1 <- yes_or_no("Everything Ok?")
R> q2 <- yes_or_no("Be or not to be?")
R> q3 <- yes_or_no("KevCaz?")
R> myform <- q1%+%q2%+%q3
R> myform()
❓ Everything Ok?
[Y]es or [No]: f
⚠ Validation failed, try again!
[Y]es or [No]: Y 
✔ validated!
❓ Be or not to be?
[Y]es or [No]: Y 
✔ validated!
❓ KevCaz?
[Y]es or [No]: Y 
✔ validated!
[[1]]
[1] TRUE

[[2]]
[1] TRUE

[[3]]
[1] TRUE

```