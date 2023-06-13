# cdi_wg2ws

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The function of this R package is to provide function for converting
MacArthur-Bates Communicative Development Inventory (CDI) Words and Gestures
(WG) scores collected on individuals outside the normed range (8-18 months)
to appropriate Words and Sentences (WS) scores (see Fenson et al., 1994).

This was done in order to adapt scores collected as part of the Baby Connectome
Project (BCP; Howell et al., 2018), which collected WG scores out of range
for comparison with studies of intellectual and developmental disabilities.

# Functions

## Total Score

`wg2ws_total_age()`

This function converts a total WG score (i.e., 0-396) to WS based on either
WG total score alone or including the effect of age. The models are listed
below:

### Age model

```math
\begin{align}
\hat{y} =
    & -0.74(\textrm{age}) + 1.2(\textrm{WG}) - {} \\
    & 0.014(\textrm{age}^2) - 0.00073(\textrm{WG}^2) + {} \\
    & 0.0074(\textrm{age}^3) + (4.9 \times{} 10^{-6})(\textrm{WG}^3) + {} \\
    & 0.012(\textrm{age})(\textrm{WG}) -
        (5.2 \times{} 10^{-6})(\textrm{age}^2)(\textrm{WG}^2) +
        (7.0 \times{} 10^{-10})(\textrm{age}^3)(\textrm{WG}^3)
\end{align}
```
### No age model

```math
\hat{y} = 1.2(\textrm{WG}) - (6.9\times10^{-4})(\textrm{WG}^2) +
    (4.99\times10^{-6})(\textrm{WG}^3)
```
# Category scores

Because fourteen items are not in the same category between WG and WS, in
order to calculate WS category scores, the entire list of items is needed

# References

 1. Fenson, L., Dale, P. S., Reznick, J. S., Bates, E., Thal, D. J., &
    Pethick, S. J. (1994). "Variability in Early Cognitive Development."
    *Monographs of the Society for Research in Child Development*, 59(5).

 2. Howell, B. R., Styner, M. A., Gao, W., Yap, P.-T., Wang, L., Baluyot, K.,
    Yacoub, E., Chen, G., Potts, T., Salzwedel, A., Li, G., Gilmore, J. H.,
    Piven, J., Smith, J. K., Shen, D., Ugurbil, K., Zhu, H., Lin, W., &
    Elison, J. T. (2018).
    "The UNC/UMN Baby Connectome Project (BCP): An overview of the study design
    and protocol development." *NeuroImage*.
    https://doi.org/10.1016/j.neuroimage.2018.03.049
