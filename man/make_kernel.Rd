% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_kernel.R
\name{make_kernel}
\alias{make_kernel}
\title{make_kernel}
\usage{
make_kernel(order, R)
}
\arguments{
\item{order, }{the degree of the 1st non-zero moment, an even number since all these kernels
are orthogonal to odd polynomials.  If NULL then a uniform kernel is constructed}

\item{R, }{support is -R to R and kernel is smooth at the boundary}
}
\value{
a list containing coefficients of the even polynomial kernel, veck, Range, R,
and functions for the kernel and its cdf, kern and kern_cdf.
}
\description{
constructs polynomial kernels
}
\examples{
# The order of the kernel is power of the first non-zero moment. Kernels will have support between
# -R and R.  Order must be an even number because all kernels are orthogonal to odd polynomials 
# since they are symmetric
order = 8
R = 5
k=blipCDF:::make_kernel(order,R)

# check it is a kernel
area = with(k, integrate(kern, lower = -R, upper = R, R = R, veck = veck, subdivisions = 10000)$value)
area

# plot
s = seq(-R,R,.001)
y = with(k, kern(s, R=R, veck=veck))
plot = plot(s,y)
plot

# check orthogonality to a polynomial less than the order 
test_fcn = as.data.frame(vapply(0:order, FUN = function(r) {
  test_fcn = function(x) (x^r)*with(k, kern(x, R=R, veck = veck))
  test_int = integrate(test_fcn, lower = -R, upper = R,subdivisions = 10000)
  return(c(test_int$abs.error, test_int$value))
}, FUN.VALUE = c(1,1)))
rownames(test_fcn) = c("abs_error", "integral")
colnames(test_fcn) = as.character(0:(order))
# We see the integral of the kernel times an 8th degree polynomial is non trivial
test_fcn

}
