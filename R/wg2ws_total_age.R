wg2ws_total_age <- function(WG, age = NA) {

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

}
