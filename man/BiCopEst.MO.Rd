% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MarshallOlkin.R
\name{BiCopEst.MO}
\alias{BiCopEst.MO}
\title{Estimation of Marshall-Olkin copulas}
\usage{
BiCopEst.MO(
  u1,
  u2,
  method,
  par.start = 0.5,
  kernel = "gaussian.Phi",
  gamma = 0.95,
  alpha = 1,
  niter = 100,
  C_eta = 1,
  ndrawings = 10,
  naveraging = 1
)
}
\arguments{
\item{u1}{vector of observations of the first coordinate, in \eqn{[0,1]}.}

\item{u2}{vector of observations of the second coordinate, in \eqn{[0,1]}.}

\item{method}{a character giving the name of the estimation method, among:
\itemize{
  \item \code{curve}: \eqn{\alpha} is estimated by inversion of
    the probability measure of the diagonal
    \eqn{\{(u,v): u = v\}}{ {(u,v): u = v} }
  \item \code{itau}: \eqn{\alpha} is estimated by inversion of Kendall's tau
  \item \code{MMD}: \eqn{\alpha} is estimated by MMD optimization
}}

\item{par.start}{starting parameter of the gradient descent.
(only used for \code{method = "MMD"})}

\item{kernel}{the kernel used in the MMD distance
(only used for \code{method = "MMD"}) :
  it can be a function taking in parameter \code{(u1, u2, v1, v2, gamma, alpha)}
  or a name giving the kernel to use in the list:
  \itemize{
    \item \code{"gaussian"}: Gaussian kernel \eqn{k(x,y) = \exp(-\|\frac{x-y}{\gamma}\|_2^2)
    }{k(x,y) = exp( - || (x-y) / gamma ||_2^2)}
    \item \code{"exp-l2"}: \eqn{k(x,y) = \exp(-\|\frac{x-y}{\gamma}\|_2)
    }{k(x,y) = exp( - || (x-y) / gamma ||_2)}
    \item \code{"exp-l1"}: \eqn{k(x,y) = \exp(-\|\frac{x-y}{\gamma}\|_1)
    }{k(x,y) = exp( - || (x-y) / gamma ||_1)}
    \item \code{"inv-l2"}: \eqn{k(x,y) = 1/(1+\|\frac{x-y}{\gamma}\|_2)^\alpha
    }{k(x,y) = 1 / ( 1 + || (x-y) / gamma ||_2 )^\alpha}
    \item \code{"inv-l1"}: \eqn{k(x,y) = 1/(1+\|\frac{x-y}{\gamma}\|_1)^\alpha
    }{k(x,y) = 1 / ( 1 + || (x-y) / gamma ||_1 )^\alpha}
  }
 Each of these names can receive the suffix \code{".Phi"}, such as \code{"gaussian.Phi"}
 to indicates that the kernel \eqn{k(x,y)} is replaced by
 \eqn{k(\Phi^{-1}(x) , \Phi^{-1}(y))} where \eqn{\Phi^{-1}} denotes the quantile
 function of the standard Normal distribution.}

\item{gamma}{parameter \eqn{\gamma} to be used in the kernel.
(only used for \code{method = "MMD"})}

\item{alpha}{parameter \eqn{\alpha} to be used in the kernel, if any.
(only used for \code{method = "MMD"})}

\item{niter}{the stochastic gradient algorithm is composed of two phases:
a first "burn-in" phase and a second "averaging" phase.
If \code{niter} is of size \code{1}, the same number of iterations is used for
both phases of the stochastic gradient algorithm. If \code{niter} is of size \code{2},
then \code{niter[1]} iterations are done for the burn-in phase and \code{niter[2]}
for the averaging phase.
(only used for \code{method = "MMD"})}

\item{C_eta}{a multiplicative constant controlling for the size of the gradient descent step.
The step size is then computed as \code{C_eta / sqrt(i_iter)}
where \code{i_iter} is the index of the current iteration of the stochastic gradient algorithm.
(only used for \code{method = "MMD"})}

\item{ndrawings}{number of replicas of the stochastic estimate of the gradient
drawn at each step. The gradient is computed using the average of these replicas.
(only used for \code{method = "MMD"})}

\item{naveraging}{number of full run of the stochastic gradient algorithm
that are averaged at the end to give the final estimated parameter.
(only used for \code{method = "MMD"})}
}
\value{
the estimated parameter (\code{alpha}) of the Marshall-Olkin copula.
}
\description{
Estimation of Marshall-Olkin copulas
}
\examples{
U <- BiCopSim.MO(n = 1000, alpha = 0.2)
estimatedPar <- BiCopEst.MO(u1 = U[,1], u2 = U[,2], method = "MMD", niter = 1, ndrawings = 1)
\donttest{
estimatedPar <- BiCopEst.MO(u1 = U[,1], u2 = U[,2], method = "MMD")
}

}
\references{
Alquier, P., Chérief-Abdellatif, B.-E., Derumigny, A., and Fermanian, J.D. (2022).
Estimation of copulas via Maximum Mean Discrepancy.
Journal of the American Statistical Association, \doi{10.1080/01621459.2021.2024836}.
}
\seealso{
\code{\link{BiCopSim.MO}} for the estimation of
Marshall-Olkin copulas.
\code{\link{BiCopEstMMD}} for the estimation of other parametric copula families by MMD.
}
