range_prop <- function(x, name) {
  if (is.null(x)) return(list())

  # Character vector always left as is
  if (is.character(x)) {
    return(named_list(name, x))
  }

  assert_that(is.numeric(x), length(x) <= 2)
  n_miss <- sum(is.na(x))

  if (n_miss == 0) {
    named_list(name, x)
  } else if (n_miss == 1) {
    if (is.na(x[1])) {
      named_list(paste0(name, "Max"), x[2])
    } else {
      named_list(paste0(name, "Min"), x[1])
    }
  } else if (n_miss == 2) {
    list()
  }

}

named_list <- function(names, ...) {
  setNames(list(...), names)
}

#' Convert the name of a property to the name of its default scale.
#'
#' This is mainly used to ensure that similar properties share the same
#' scale by default - e.g. \code{x} and \code{x2} should use the same
#' scale.
#'
#' @param prop character vector of property names. Any unrecognised names
#'   are left unchanged.
#' @return character vector of default scale names.
#' @keywords internal
#' @export
#' @examples
#' prop_to_scale(c("x", "x2"))
#' prop_to_scale(c("foo", "bar"))
#' prop_to_scale(c("opacity", "fillOpacity", "strokeOpacity"))
prop_to_scale <- function(prop) {
  simplify <- c(
    "x2" = "x",
    "y2" = "y",
    "fillOpacity" = "opacity",
    "strokeOpacity" = "opacity",
    "innerRadius" = "radius",
    "outerRadius" = "radius",
    "startAngle" = "angle",
    "endAngle" = "angle"
  )

  matches <- match(prop, names(simplify))
  prop[!is.na(matches)] <- simplify[prop[!is.na(matches)]]
  prop
}

#' Given the type of a ggvis scale, get the name of its corresponding vega scale
#'
#' @param type property type: numeric, ordinal, nominal, logical or datetime.
#' @keywords internal
scaletype_to_vega_scaletype <- function(type) {
  unname(c(
    "numeric" = "quantitative",
    "ordinal" = "ordinal",
    "nominal" = "ordinal",
    "logical" = "ordinal",
    "datetime" = "time"
  )[type])
}

valid_scale_types <- c("numeric", "ordinal", "nominal", "logical", "datetime")

valid_scales <- c("x", "y", "stroke", "fill", "shape", "size", "fontSize",
                  "opacity", "angle", "radius")
