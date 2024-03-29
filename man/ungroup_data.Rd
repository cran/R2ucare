% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ungroup_data.R
\name{ungroup_data}
\alias{ungroup_data}
\title{Ungroup encounter capture-recapture data in individual histories}
\usage{
ungroup_data(X, effX)
}
\arguments{
\item{X}{matrix of encounter capture-recapture histories}

\item{effX}{vector with numbers of individuals with that particular encounter history}
}
\value{
matrix with ungrouped capture-recapture histories and counts in the last column (should be 1s)
}
\description{
This function splits encounter histories in as many individual histories as required.
}
\examples{
# Generate fake capture-recapture dataset
X = matrix(round(runif(9)),nrow=3)
freq=c(4,3,-8)
cbind(X,freq)
ungroup_data(X,freq)
}
\author{
Olivier Gimenez <olivier.gimenez@cefe.cnrs.fr>, Roger Pradel, Rémi Choquet
}
\keyword{package}
