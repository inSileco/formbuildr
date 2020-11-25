context("Choices")


test_that("Month", {
  q1 <- fob_month("")
  q2 <- fob_month("", output = "id")
  expect_equal(q1(3), "March")
  expect_true(is.na(q1(13)))
  expect_equal(q2(3), 3)
})

test_that("Weekday", {
  q1 <- fob_weekday("")
  q2 <- fob_weekday("", output = "id")
  expect_equal(q1(1), "Monday")
  expect_true(is.na(q1(12)))
  expect_equal(q2(1), 1)
})