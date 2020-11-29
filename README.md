# formbuildr
[![R-CMD-check](https://github.com/inSileco/formbuildr/workflows/R-CMD-check/badge.svg)](https://github.com/inSileco/formbuildr/actions?query=workflow%3AR-CMD-check)
[![codecov](https://codecov.io/gh/inSileco/formbuildr/branch/main/graph/badge.svg?token=P5FVU296ZG)](https://codecov.io/gh/inSileco/formbuildr)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

An R :package: to readily build forms with the command line interface.


## Simple creation of forms 

```R
R> q1 <- fob_among("Fruits?", c("Apple", "Pear"), "fruit", confirm = TRUE)
R> q2 <- fob_yorn("Be or not to be", "shake")
R> s1 <- fob_section("Next part")
R> q3 <- fob_date("When was that?", "date")
R> q4 <- fob_pattern("2 letters + 1 digit", "^[A-Za-z]{2}[0-9]$")
R> f1 <- fob_output(function(fruit, date, ...) paste0(date, ": I ate one", fruit))
R> myform <- q1 %+% q2 %+% s1 %+% q3 %+% q4 %+% f1
R> res <- myform()   
❓ Fruits?
ℹ Multiple choices:
1: Apple
2: Pear
Enter your choice:  1
⚠ Confirmed?
[Y]es or [N]o: Y
❓ Be or not to be
Enter [Y]es or [N]o:  N
✔ validated!
☰ Next part
❓ When was that?
Enter your answer (a date %Y-%m-%d):  2020-12-01
✔ validated!
❓ 2 letters + 1 digit ❓
Enter your answer:000  
⚠ Validation failed, try again!
Enter your answer:ok1
✔ validated!

R> res
$answers
$answers$fruit
[1] "Apple"

$answers$shake
[1] FALSE

$answers$date
[1] "2020-12-01"

$answers$answer_2
[1] "ok1"


attr(,"class")
[1] "form_answers"
```

Alternatively, you can use `join(q1, q2, q3, q4)` to create the same form.
Note that forms can also be combined, just as questions, so what follows 

```R
R> q5 <- fob_int("How many?")
R> myform2 <- myform %+% q5
```

adds one question to the previous form, the answer to which should be an integer. 
Also, see `multi()` to repeat the form, e.g `multi(myform, 2)`.


## Form from file 

See `form_from_file()`.


## Exporting results 

So far, results are returned as a list and can be exported as "YAML" using `export_answer()`. For instance the following

```
R> export_answer(res, "answers.yaml")   
```

creates `answers.yaml` with the following content:

```yaml
answers:
  fruit: Apple
  shake: no
  date: '2020-12-01'
  answer_2: ok1
```


## Direct validation

Once a form created it can be also used for direct validation, i.e. one can skip the interactive parts a check whether answers are correctly formatted: 

```R 
R> myform2(1, "Y", "2010-01-01", "ok1", 1)
$answers
$answers$fruit
[1] "Apple"

$answers$shake
[1] TRUE

$answers$date
[1] "2010-01-01"

$answers$answer_2
[1] "ok1"

$answers$answer_2
[1] 1


attr(,"class")
[1] "form_answers"
```

Currently `NA` is returned when the format is not correct 

```R 
$answers
$answers$fruit
[1] "Apple"

$answers$shake
[1] TRUE

$answers$date
[1] "2010-01-01"

$answers$answer_2
[1] "ok1"

$answers$answer_2
[1] NA


attr(,"class")
[1] "form_answers"
```


## Meta

* Please report any issues or bugs: https://github.com/inSileco/formbuildr/issues
* License: GPL-3
* Please note that this package is released with a Contributor Code of Conduct (https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.