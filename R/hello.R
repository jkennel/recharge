# # Hello, world!
# #
# # This is an example function named 'hello'
# # which prints 'Hello, world!'.
# #
# # You can learn more about package authoring with RStudio at:
# #
# #   http://r-pkgs.had.co.nz/
# #
# # Some useful keyboard shortcuts for package authoring:
# #
# #   Build and Reload Package:  'Ctrl + Shift + B'
# #   Check Package:             'Ctrl + Shift + E'
# #   Test Package:              'Ctrl + Shift + T'
# library(data.table)
# dat <- data.table(datetime = 1:10, wl = rnorm(10), recharge = cumsum(abs(rnorm(10))))
# T_orig <- dat$datetime
# H_orig <- dat$wl
# len <- length(T_orig)
# h1 <- T_orig[2:(len - 1)] - T_orig[1:(len - 2)]
# h2 <- T_orig[3:len] - T_orig[2:(len - 1)]
# H1 <- H_orig[1:(len - 2)]
# H2 <- H_orig[2:(len - 1)]
# H3 <- H_orig[3:len]
# dHdT_orig <- ( h1^2*H3 + (h2^2 - h1^2)*H2 - h2^2*H1 )/( h1*h2*(h1+h2) )
#
#
# central_derivative <- function(dat, dep, time_var) {
#
#   # time differences
#   dat[, k1 := shift(get(time_var), 1, type = 'lead') - get(time_var)]
#   dat[, k2 := shift(get(time_var), 2, type = 'lead') - shift(get(time_var), 1, type = 'lead')]
#
#   dat[, wl_1 := shift(get(dep), 1, type = 'lead')]
#   dat[, wl_2 := shift(get(dep), 2, type = 'lead')]
#
#   dat[, deriv := (k1^2 * wl_2 + (k2^2 - k1^2) * wl_1 - k2^2 * get(dep)) /
#         (k1 * k2 * (k1 + k2))]
#
# }
#
# central_derivative(dat, 'wl', 'datetime')
# central_derivative(dat, 'recharge', 'datetime')
