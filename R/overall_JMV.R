#' Overall goodness-of-fit test for the Jolly-Move model
#'
#' This function performs the overall goodness-of-fit test for the Jolly-Move model.
#' It is obtained as the sum of the 5 components Test3G.SR, Test3G.SM, Test3G.WBWA, TestM.ITEC, TestM.LTEC.
#' To perform the goodness-of-fit test for the Arnason-Schwarz model, both the Arnason-Schwarz (AS) and the Jolly-Move models need to be fitted to the data (to our knowledge, only E-SURGE can fit the JMV model).
#' Assuming the overall goodness-of-fit test for the JMV model has produced the value stat_jmv for the test statistic,
#' get the deviance (say dev_as and dev_jmv) and number of estimated parameters (say dof_as and dof_jmv) for both the AS and JMV models.
#' Then, finally, the p-value of the goodness-of-fit test for the AS model is obtained as 1 - pchisq(stat_as,dof_as) where stat_as = stat_jmv + (dev_as - dev_jmv) and dof_as = dof_jmv + (dof_jmv - dof_as)
#' @param X is a matrix of encounter histories
#' @param freq is a vector of the number of individuals with the corresponding encounter history
#' @param rounding is the level of rounding for outputs; default is 3
#' @return This function returns a data.frame with the value of the test statistic, the degrees of freedom and the p-value of the test.
#' @author Olivier Gimenez <olivier.gimenez@cefe.cnrs.fr>, Roger Pradel, Rémi Choquet
#' @keywords package
#' @export
#' @examples
#' \donttest{
#' # read in Geese dataset
#' library(RMark)
#' geese = system.file("extdata", "geese.inp", package = "R2ucare")
#' geese = convert.inp(geese)
#'
#  # add spaces between columns
#' geese.hist = matrix(as.numeric(unlist(strsplit(geese$ch, ''))),nrow=nrow(geese),byrow=TRUE)
#' geese.freq = geese$freq
#'
#' # encounter histories and number of individuals with corresponding histories
#' X = geese.hist
#' freq = geese.freq
#'
#' # load R2ucare package
#' library(R2ucare)
#'
#' # perform overall gof test
#' overall_JMV(X, freq)
#' }

overall_JMV <- function(X,freq,rounding=3){

# compute each component
res_test3Gsr = test3Gsr(X, freq)
res_test3Gsm = test3Gsm(X, freq)
res_testMitec = testMitec(X, freq)
res_testMltec = testMltec(X, freq)
res_test3Gwbwa = test3Gwbwa(X, freq)

# compute overall test (JMV first, then AS)
stat_jmv = round(res_test3Gsr$test3Gsr[1] + res_test3Gsm$test3Gsm[1] + res_test3Gwbwa$test3Gwbwa[1] + res_testMitec$testMitec[1] + res_testMltec$testMltec[1],rounding)
dof_jmv = res_test3Gsr$test3Gsr[2] + res_test3Gsm$test3Gsm[2] + res_test3Gwbwa$test3Gwbwa[2] + res_testMitec$testMitec[2] + res_testMltec$testMltec[2]
pval_jmv = round(1 - stats::pchisq(stat_jmv,dof_jmv),rounding)

res = data.frame(chi2 = stat_jmv,degree_of_freedom = dof_jmv,p_value = pval_jmv)
row.names(res) = 'Gof test for JMV model:'
res

}
