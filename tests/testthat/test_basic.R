context("NULL")

q1 <- fob_among("Fruits?", c("Apple", "Pear"), "fruit", confirm = TRUE)
q2 <- fob_yorn("Be or not to be", "shake")
q3 <- fob_date("When was that?", "date")
q4 <- fob_pattern("2 letters + 1 digit", "^[A-Za-z]{2}[0-9]$")
myform <- q1 %+% q2 %+% q3 %+% q4
# res <- myform()

test_that("unit questions work", {
  expect_equal(q1(1), "Apple")
  expect_true(is.na(q1(3)))
  
  expect_true(q2("yes"))
  expect_true(!q2("N"))
  expect_true(is.na(q2("k")))
  
  expect_equal(q3("2012-01-11"), "2012-01-11")
  expect_true(is.na(q3("2012-01")))
  
  expect_equal(q4("ll1"), "ll1")
  expect_true(is.na(q4("lll")))
})
  