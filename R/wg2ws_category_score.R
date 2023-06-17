#' Title
#'
#' @param age Age in months.
#' @param wg_table
#' @param verbose
#' @param WG_total
#'
#' @return
#' @export
#'
#' @examples

wg2ws_category_score <- function(wg_table, age = NA, WG_total = NA,
                                 verbose = FALSE) {

  if (!all.equal(colnames(wg_table), c("category", "n"))) {
    stop("Category expects exactly two columns: category and score")
  }

  if (nrow(wg_table) != 22) {
    stop("Expecting all 22 categories - including SEAS/CW.")
  }

  if (is.na(WG_total)) {
    WG_total <- sum(wg_table$n)
    if (verbose)
      message(paste("WG total:", WG_total))
  }

  # Center age
  age_c <- age - 18

  # Hat values
  new_value <- rep(NA, 22)

  for (i in 1:22) {

    the_category <- wg_table$category[i]
    the_score <- wg_table$n[i]

    # Sounds gets passed through: Identical
    if (the_category == "sounds"){
      new_value[i] <- the_score
      next
    }

    # Don't predict
    if (the_category == "connecting_words")
      next

    # message(the_category)
    model_index <- which(cat_models_stripped$category == the_category)
    if (is.na(age))
      model <- cat_models_stripped$lm1[[model_index]]
    else
      model <- cat_models_stripped$lm4[[model_index]]


    # Do model prediction
    new_data = data.frame(cat_total_WG = the_score, age_c = age_c,
                          WG_total_score = WG_total)

    result <- predict(model, newdata = new_data)

    # Add to result
    new_value[i] <- unname(round(result))

  }

  # Floor new values (no values less than 0)
  new_value <- ifelse(new_value < 0, 0, new_value)

  # Max sure no values exceed maximum
  max_value <- as.data.frame(table(s_dict$category), responseName = "max")

  # Get maximum value in order presented
  wg_to_max <- match(wg_table$category, as.character(max_value$Var1))
  maximums <- max_value$max[wg_to_max]
  if (verbose) {
    bad <- sum(new_value > maximums, na.rm = TRUE)
    message(paste("Found", bad, "values in excess"))
  }
  new_value <- ifelse(new_value > maximums, maximums, new_value)

  new_table <- cbind(wg_table, new_value)

  # Predict CW

  awords <- wg_table$n[wg_table$category == "action_words"]
  clothing <- wg_table$n[wg_table$category == "clothing"]
  fd <- wg_table$n[wg_table$category == "food_drink"]
  gr <- wg_table$n[wg_table$category == "games_routines"]
  loc <- wg_table$n[wg_table$category == "locations"]
  pron <- wg_table$n[wg_table$category == "pronouns"]
  quant <- wg_table$n[wg_table$category == "quantifiers"]
  qwords <- wg_table$n[wg_table$category == "question_words"]
  sounds <- wg_table$n[wg_table$category == "sounds"]
  twords <- wg_table$n[wg_table$category == "time_words"]
  toys <- wg_table$n[wg_table$category == "toys"]

  cw_new_data = data.frame(age_c = age_c, WG_total = WG_total,
                           action_words = awords, clothing = clothing,
                           food_drink = fd, games_routines = gr,
                           locations = loc, pronouns = pron,
                           quantifiers = quant, question_words = qwords,
                           sounds = sounds, time_words = twords, toys = toys)

  # Round and truncate to [0, 6]
  cw_new <- round(predict(cw_stripped, cw_new_data))
  cw_new <- ifelse(cw_new > 6, 6, ifelse(cw_new < 0, 0, cw_new))

  if (verbose) message(paste("Connecting words:", cw_new))

  # Add to results
  new_table$new_value[new_table$category == "connecting_words"] <- cw_new

  return(new_table)

}
