% Generated by roxygen2 (4.0.1): do not edit by hand
\name{layer_lines}
\alias{layer_lines}
\title{Layer lines on a plot.}
\usage{
layer_lines(vis, ...)
}
\arguments{
\item{vis}{Visualisation to modify.}

\item{...}{Visual properties.}
}
\description{
Layer lines on a plot.
}
\examples{
mtcars2 <- dplyr::mutate(mtcars, cyl = factor(cyl))
mtcars2 \%>\% ggvis(~wt, ~mpg, stroke = ~cyl) \%>\% layer_lines()

# Equivalent to
mtcars2 \%>\% ggvis(~wt, ~mpg, stroke = ~cyl) \%>\%
  group_by(cyl) \%>\% dplyr::arrange(wt) \%>\% layer_paths()
}
\seealso{
\code{link{mark_path}}
}

