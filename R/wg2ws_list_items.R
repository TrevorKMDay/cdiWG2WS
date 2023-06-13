#' List instrument items
#'
#' @param instrument "WG" or "WS"
#'
#' @return List of items
#' @export

wg2ws_list_items <- function(instrument) {

  if (instrument == "WG") {
    data("g_dict")
    return(g_dict$item_definition)
  } else if (instrument == "WS") {
    data("s_dict")
    return(s_dict$item_definition)
  }

}
