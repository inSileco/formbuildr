context("Word and text")


test_that("word question", {
  q1 <- fob_word("")
  expect_equal(q1("cool"), "cool")
  expect_true(is.na(q1("co cool")))
})

test_that("text question", {
  q1 <- fob_text("")
  expect_equal(q1("Everything's fine!"), "Everything's fine!")
  q2 <- fob_text("", max = 5)
  expect_message(q2("Everything's fine!")) 
  expect_equal(suppressMessages(q2("Everything's fine!")), "Every")
})

test_that("email question", {
  q1 <- fob_email("")
  expect_equal(q1("rrr@pro.com"), "rrr@pro.com")
  expect_true(is.na(q1("rrr@pro.c")))
})

