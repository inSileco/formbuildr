# formbuildr
[![R-CMD-check](https://github.com/inSileco/formbuildr/workflows/R-CMD-check/badge.svg)](https://github.com/inSileco/formbuildr/actions?query=workflow%3AR-CMD-check)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

An R :package: to build forms with the command line interface.


```R
R> q1 <- one_among("Fruits?", c("Apple", "Pear"), "fruit")
R> q2 <- yes_or_no("Be or not to be", "shake")
R> q3 <- match_pattern("3 letters + 1 digit", "^[A-Za-z]{3}[0-9]$")
R> myform <- q1 %+% q2 %+% q3
R> res <- myform()   
❓ Fruits? ❓
ℹ Multiple choices:
1 :  Apple 
2 :  Pear 
Enter your choice: 1  
✔ validated!
❓ Be or not to be? ❓
Enter [Y]es or [N]o: no
✔ validated!
❓ 3 letters + 1 digit ❓
Enter your answer:1111
⚠ Validation failed, try again!
Enter your answer:oki8
✔ validated!

R> res 
$fruit
[1] "Apple"

$shake
[1] FALSE

$answer_3
[1] "oki8"

attr(,"class")
[1] "form_answers"

R> export_answer(res, "answers.yaml")   
```

the last line returns `answers.yaml` with the following content:

```yaml
fruit: Apple
shake: no
answer_3: oki8
```


# Meta

* Please report any issues or bugs: https://github.com/inSileco/formbuildr/issues
* License: GPL-3
* Please note that this package is released with a Contributor Code of Conduct (https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.