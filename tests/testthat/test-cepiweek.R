# usethis::use_testthat() # activates testthat
# usethis::use_test("cepiweek") # creates the test file for cepiweek

library(testthat)

test_that("cepiweek generates correct continuous epidemiological week index", {

  # Test data
  df = data.frame(
    num = c(1, 2, 3),
    date = c("2024-01-15", "2025-02-12", "2026-08-01")
  )

  # Call the function
  df = cepiweek(df, col_date = "date")

  # Check that the 'cepiweek' column was created
  expect_true("cepiweek" %in% names(df))

  # Check the type of the column
  expect_type(df$cepiweek, "integer")

  # Check that the number of rows remains unchanged
  expect_equal(nrow(df), 3)

  # Check that the values are increasing (continuity of the index)
  expect_true(all(diff(df$cepiweek) >= 0))

  # Check that the weeks are consistent for a known date
  expect_equal(df$cepiweek[1], min(df$cepiweek))

})
