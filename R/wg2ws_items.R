wg2ws_items <- function(items, error_on_missing = TRUE) {

  data("g_dict")

  items_not_in_dict <- items[!(items %in% g_dict$item_definition)]

  if (length(items_not_in_dict) > 0 & error_on_missing) {
    stop(paste0("Items ``", paste(items_not_in_dict, collapse = ", "),
               "'' not in gestures dictionary!"))
  } else {

    locs <- match(items, g_dict$item_definition)
    category <- g_dict$category[locs]

  }

  return(category)

}
