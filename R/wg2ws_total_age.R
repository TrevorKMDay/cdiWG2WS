#' wg2ws_total_age
#'
#' @param WG Words and Gestures total score.
#' @param age Age in months (optional). A different, more accurate model is
#'  used if age is supplied.
#'
#' @return Adjusted score, rounded to the nearest integer. Does not return
#'  values below 0 or greater than 680.
#'
#' @examples
#'
#' # A 24-month old with 250 words
#' wg2ws_total_age(250, 24)
#' 330
#'
#' # A score of 250 known to be collected out of range, but without an age
#' wg2ws_total_age(250)
#' 331
#'
#' @export

wg2ws_total_age <- function(WG, age = NA) {

  if (age > 18 | is.na(age)) {

    newdata <- data.frame(total_WG = WG, age = age)
    newdata$age_c <- age - 18

    if (is.na(age)) {
      data("total_wg2ws_noage_model")
      y_hat <- predict(total_wg2ws_noage_model, newdata)
    }  else {
      data("total_wg2ws_model")
      y_hat <- predict(total_wg2ws_model, newdata)
    }

    # Cutoff at 0/680
    y_hat <- replace(y_hat, y_hat < 0, 0)
    y_hat <- replace(y_hat, y_hat > 680, 680)
    y_hat <- unname(round(y_hat))

    return(y_hat)

  } else if (age < 8) {

    message("Age is below normed range, returning input")
    return(WG)

  } else {

    message("Age is within normed range, returning input")
    return(WG)

  }

}
