setwd("G:/My Drive/Research/MCDI/cdiWG2WS/")

library(tidyverse)

devtools::load_all()

g_dict <- g_dict
s_dict <- s_dict

wg2ws_get_cat_function("time_words", age = FALSE)

# Reminder: in/inside combine on WS
random <- sample(wg2ws_list_items("WG"), 380)
c("in", "inside") %in% random

test_table <- wg2ws_items(random)

test_result_noage <- wg2ws_category_score(test_table, age = NA, verbose = TRUE)
test_result_30mo <- wg2ws_category_score(test_table, age = 30, verbose = TRUE)
test_result_36mo <- wg2ws_category_score(test_table, age = 36, verbose = TRUE)

head(test_result_noage)

wg2ws_summarize_cat(test_result_36mo)

# Do some simulations to see if the in/inside difference matters much

size <- 10000
simulations <- list(rep(NA, size))

for (i in 1:size) {

  simulations[[i]] <- sample(g_dict$item_definition, runif(1, 1, 396))

}

sim_tbl <- tibble(sim = simulations) %>%
  mutate(
    in_inside = map_int(sim, ~sum(c("in", "inside") %in% .x))
  ) %>%
  filter(
    in_inside == 2
  ) %>%
  mutate(
    result1 = map(sim, ~wg2ws_category_score(wg2ws_items(.x), age = 30)),
    result2 = map(sim, ~wg2ws_category_score(wg2ws_items(.x), age = 30,
                                             WG_total = length(.x)))
  )

sim_tbl2 <- sim_tbl %>%
  mutate(
    sum1 = map_int(result1, ~sum(.x$new_value)),
    sum2 = map_int(result2, ~sum(.x$new_value))
  )

cor(sim_tbl2$sum1, sim_tbl2$sum2)
sum(sim_tbl2$sum1 != sim_tbl2$sum2)
