#' Generate Continuous Epidemiological Week Index for a Date Column
#'
#' This function adds a continuous epidemiological week index to a data frame
#' by assigning each date to a sequential week number starting from a reference
#' date.
#'
#' The generated weeks do not reset at calendar year boundaries and are not ISO
#' 8601 or MMWR weeks. You can specify the start date for week counting; if none
#' is provided, the minimum date in the column is used.
#'
#' This design is intended for epidemiological modeling, time-series analysis,
#' and nowcasting applications.
#'
#' @param data A data frame containing the date column.
#' @param col_date Name of the date column (string).
#' @param start Optional start date for counting weeks (Date or string).
#'   Defaults to the minimum date in the column \code{col_date}.
#'
#' @return A data frame with an added \code{cepiweek} column containing
#'   continuous week indices.
#'
#' @examples
#' k <- data.frame(
#'   num = c(1, 2, 3),
#'   date = c("2024-01-15", "2025-02-12", "2026-08-01")
#' )
#' cepiweek(k, col_date = "date")
#'
#'
#' @details
#' \href{https://github.com/DeginaDaniel/cepiweek}{GitHub of the package}.
#'
#' @export
cepiweek = function(data, col_date, start = NULL) {
  # s'assurer que la colonne est au format Date
  data[[col_date]] = as.Date(data[[col_date]])

  # date minimale et maximale
  date_min = if (is.null(start))
    min(data[[col_date]], na.rm = TRUE)
  else
    as.Date(start)
  date_max = max(data[[col_date]], na.rm = TRUE)

  # premier lundi à partir de date_min
  date_min_d1w = lubridate::floor_date(date_min, unit = "week", week_start = 1)

  # dernier lundi avant date_max
  date_max_d1w = lubridate::floor_date(date_max, unit = "week", week_start = 1)
  date_max_d7w = date_max_d1w + 6

  # séquence complète de dates
  date_seq = seq(date_min_d1w, date_max_d7w, by = "day")

  # numéro de semaine épidémiologique
  week_id = rep(1:ceiling(length(date_seq)/7),
                each = 7)[seq_along(date_seq)]

  # dataframe calendrier
  date_week = data.frame(
    date = date_seq,
    week = week_id)

  # affectation directe
  data$cepiweek = week_id[match(data[[col_date]], date_week$date)]

  return(data)
}
