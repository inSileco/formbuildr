context("Core functionalities")

q1 <- fob_among("Fruits?", c("Apple", "Pear"), "fruit", confirm = TRUE)
q2 <- fob_yorn("Be or not to be", "shake")
q3 <- fob_date("When was that?", "date")
q4 <- fob_pattern("2 letters + 1 digit", "^[A-Za-z]{2}[0-9]$")
q5 <- fob_int("How many?")
myform <- q1 %+% q2 
myform2 <- myform %+% q3
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
  
  expect_equal(q5("0001"), 1)
  expect_true(is.na(q5("l")))
})
  
res1 <- myform(1, 'Y')
res2 <- myform(1, 'j')
res3 <- myform2(1, 'Y', "2012-01-11")
test_that("direct validation form", {
  expect_equal(res1[[1]], "Apple")
  expect_true(res1[[2]])
  expect_true(is.na(res2[[2]]))
  expect_equal(res3[[1]], res1[[1]][[1]])
  expect_equal(res3[[3]], "2012-01-11")
})
  
test_that("classes", {
  expect_equal(class(q1), "form_partial")
  expect_equal(class(join(q1)), "form")
  expect_equal(class(myform), "form")
})