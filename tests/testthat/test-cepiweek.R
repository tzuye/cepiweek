# usethis::use_testthat() # active testthat
# usethis::use_test("cepiweek") # crée le test de cepiweek

test_that("Generate Continuous Epidemiological Week Index for a Date Column", {
  k <- data.frame(
    num = c(1, 2, 3),
    date = c("2024-01-15", "2025-02-12", "2026-08-01"))
  k = cepiweek(k, col_date = "date")
})
