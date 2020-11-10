context("NULL")

q1 <- one_among("Fruits?", c("Apple", "Pear"), "fruit")
q2 <- one_yorn("Be or not to be", "shake")
q3 <- one_date("When was that?", "date")
q4 <- match_pattern("2 letters + 1 digit", "^[A-Za-z]{2}[0-9]$")
myform <- q1 %+% q2 %+% q3 %+% q4
# res <- myform()   