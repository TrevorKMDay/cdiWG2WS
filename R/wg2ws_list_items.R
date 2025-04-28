#' List instrument items
#'
#' @details
#' Simply list the items from each instrument for convenience#'
#'
#' @param instrument "WG" or "WS"
#'
#' @return List of items
#'
#' @importFrom usethis use_data_raw
#'
#' @export
#'
#' @examples
#'
#' wg2ws_list_items("WG")
#' wg2ws_list_items("WS")

wg2ws_list_items <- function(instrument) {

  if (instrument == "WG") {
    use_data_raw("g_dict")
    return(g_dict$item_definition)
  } else if (instrument == "WS") {
    use_data_raw("s_dict")
    return(s_dict$item_definition)
  }

}
