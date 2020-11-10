context("NULL")

q1 <- fob_among("Fruits?", c("Apple", "Pear"), "fruit", confirm = TRUE)
q2 <- fob_yorn("Be or not to be", "shake")
q3 <- fob_date("When was that?", "date")
q4 <- fob_pattern("2 letters + 1 digit", "^[A-Za-z]{2}[0-9]$")
myform <- q1 %+% q2 %+% q3 %+% q4
# res <- myform()