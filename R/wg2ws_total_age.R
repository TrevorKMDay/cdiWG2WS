#' wg2ws_total_age
#'
#' @param WG Words and Gestures total score.
#' @param age Age in months (optional). A different, more accurate model is
#'  used if age is supplied.
#'
#' @return Adjusted score, rounded to the nearest integer. Does not return
#'  values below 0 or greater than 680.
#'
#' @importFrom usethis use_data_raw
#'
#' @export

wg2ws_total_age <- function(WG, age = NA) {

  if (age > 18 | is.na(age)) {

    newdata <- data.frame(total_WG = WG, age = age)
    newdata$age_c <- age - 18

    if (is.na(age)) {
      use_data_raw("total_wg2ws_noage_model")
      y_hat <- predict(total_wg2ws_noage_model, newdata)
    }  else {
      use_data_raw("total_wg2ws_model")
      y_hat <- predict(total_wg2ws_model, newdata)
    }

    # Cutoff at 0/680
    y_hat <- replace(y_hat, y_hat < 0, 0)
    y_hat <- replace(y_hat, y_hat > 680, 680)
    y_hat <- unname(round(y_hat))

    return(y_hat)

  } else if (age < 8) {

    message("Age is below normed range (<8 months), returning input unchanged.")
    return(WG)

  } else if (age > 40) {

    message("Age is greater than 40 months, not performing projection.")
    return(NA)

  } else {

    message("Age is within normed range (8-18 months), returning input unchanged.")
    return(WG)

  }

}
