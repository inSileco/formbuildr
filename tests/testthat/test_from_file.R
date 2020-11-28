context("Create form from text")


test_that("Error", {
  expect_error(form_from_file("files_test/form_wrong_1.txt"))
  expect_error(form_from_file("files_test/form_wrong_2.txt"))
})


form1 <- form_from_file("files_test/form_right.txt")
res <- form1("1", "2020-11-27")
test_that("Form from file", {
  expect_equal(res$apples, 1)
  expect_equal(res$today, "2020-11-27")
})