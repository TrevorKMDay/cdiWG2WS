wg2ws_category_score <- function(wg, category, age = NA) {

  # If age is supplied and is less than 18, pass through category value
  if (!is.na(age) & age <= 18) {
    message("Age is less than or equal to 18, passing through value")
    return(wg)
  }

  if (category == "sounds") {

    # No adjustment is needed for sounds, it is identical between WG, WS
    return(wg)

  } else if (category == "connecting_words") {

    # Pass through for the moment
    return(NA)

  } else {

    cat_models <- readRDS("data/WS_category_models.rds")

  }

}
