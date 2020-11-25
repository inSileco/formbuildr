context("Any")

test_that("int", {
  expect_equal(fob_int(), fob_any("int"))
  expect_equal(fob_int(field_name = "howmany"), fob_any("int", field_name = "howmany"))
  expect_equal(fob_month(), fob_any("month"))
})