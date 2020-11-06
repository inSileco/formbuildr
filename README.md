# formbuildr
[![R-CMD-check](https://github.com/inSileco/formbuildr/workflows/R-CMD-check/badge.svg)](https://github.com/inSileco/formbuildr/actions?query=workflow%3AR-CMD-check)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

An R :package: to build forms with the command line interface.


```R
R> q1 <- one_among("Fruits?", c("Apple", "Pear"), "fruit")
R> q2 <- yes_or_no("Be or not to be", "shake")
R> q3 <- one_date("When was that?", "date")
R> q4 <- match_pattern("2 letters + 1 digit", "^[A-Za-z]{2}[0-9]$")
R> myform <- q1 %+% q2 %+% q3 %+% q4
R> res <- myform()   
❓ Fruits? ❓
ℹ Multiple choices:
1 :  Apple 
2 :  Pear 
Enter your choice: 1
✔ validated!
❓ Be or not to be ❓
Enter [Y]es or [N]o: no 
✔ validated!
❓ When was that? ❓
Enter your answer (a date %Y-%m-%d): 2000000
⚠ Validation failed, try again!
Enter your answer (a date %Y-%m-%d): 2020-12-01
✔ validated!
❓ 2 letters + 1 digit ❓
Enter your answer:hh1   
✔ validated!

R> res
$fruit
[1] "Apple"

$shake
[1] FALSE

$date
[1] "2020-12-01"

$answer_4
[1] "hh1"

attr(,"class")
[1] "form_answers"

R> export_answer(res, "answers.yaml")   
```

the last line returns `answers.yaml` with the following content:

```yaml
fruit: Apple
shake: no
date: '2020-12-01'
answer_4: hh1
```

Alternatively, you can use `join(q1, q2, q3, q4)` to create the same form. Also,
see `multi()` to repeat the form, e.g `multi(myform, 2)`.


# Meta

* Please report any issues or bugs: https://github.com/inSileco/formbuildr/issues
* License: GPL-3
* Please note that this package is released with a Contributor Code of Conduct (https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.