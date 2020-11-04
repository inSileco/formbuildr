# formbuildr
[![R-CMD-check](https://github.com/inSileco/formbuildr/workflows/R-CMD-check/badge.svg)](https://github.com/inSileco/formbuildr/actions?query=workflow%3AR-CMD-check)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

An R :package: to build forms with the command line interface.


```R
R> q1 <- one_among("Fruits?", c("Apple", "Pear"), "fruit") 
R> q2 <- yes_or_no("Be or not to be?", "shake")
R> q3 <- yes_or_no("R u doing ok?")
R> myform <- q1 %+% q2 %+% q3
❓ Fruits?
ℹ Multiple choices
1 :  Apple 
2 :  Pear 
Enter your choice: 1 
✔ validated!
❓ Be or not to be?
[Y]es or [No]: no 
✔ validated!
❓ R u doing ok?
[Y]es or [No]: grrr   
⚠ Validation failed, try again!
[Y]es or [No]: Y      
✔ validated!

R> res
$fruit
[1] 1

$shake
[1] "NO"

[[3]]
[1] "Y"

attr(,"class")
[1] "form_answers"

R> export_form(res, "answers.yaml")   
```

the last line returns `answers.yaml` with the following content: 

```yaml
fruit: 1.0
shake: 'NO'
'': 'Y'
```


# Meta 

* Please report any issues or bugs: https://github.com/inSileco/formbuildr/issues
* License: GPL-3
* Please note that this package is released with a Contributor Code of Conduct (https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.