## ---- message=FALSE, warning=FALSE--------------------------------------------
library(R2ucare)

## ---- message=FALSE, warning=FALSE--------------------------------------------
# # read in text file as described at pages 50-51 in http://www.phidot.org/software/mark/docs/book/pdf/app_3.pdf
dipper <- system.file("extdata", "dipper.txt", package = "RMark")
dipper <- RMark::import.chdata(dipper, field.names = c("ch", "sex"), header = FALSE)
dipper <- as.data.frame(table(dipper))
str(dipper)

## ---- message=FALSE, warning=FALSE--------------------------------------------
dip.hist <- matrix(as.numeric(unlist(strsplit(as.character(dipper$ch),""))),
                   nrow = length(dipper$ch),
                   byrow = T)
dip.freq <- dipper$Freq
dip.group <- dipper$sex
head(dip.hist)
head(dip.freq)
head(dip.group)

## ---- message=FALSE, warning=FALSE--------------------------------------------
dipper <- system.file("extdata", "ed.txt", package = "R2ucare")
dipper <- read_headed(dipper)

## ---- message=FALSE, warning=FALSE--------------------------------------------
dip.hist <- dipper$encounter_histories
dip.freq <- dipper$sample_size
dip.group <- dipper$groups
head(dip.hist)
head(dip.freq)
head(dip.group)

## ---- message=FALSE, warning=FALSE--------------------------------------------
dipper <- system.file("extdata", "ed.inp", package = "R2ucare")
dipper <- read_inp(dipper, group.df = data.frame(sex = c("Male", "Female")))

## ---- message=FALSE, warning=FALSE--------------------------------------------
dip.hist <- dipper$encounter_histories
dip.freq <- dipper$sample_size
dip.group <- dipper$groups
head(dip.hist)
head(dip.freq)
head(dip.group)

## ---- message=FALSE, warning=FALSE--------------------------------------------
mask <- (dip.group == "Female")
dip.fem.hist <- dip.hist[mask,]
dip.fem.freq <- dip.freq[mask]
mask <- (dip.group == "Male")
dip.mal.hist <- dip.hist[mask,]
dip.mal.freq <- dip.freq[mask]

## ---- message=FALSE, warning=FALSE--------------------------------------------
test3sr_females <- test3sr(dip.fem.hist, dip.fem.freq)
test3sm_females <- test3sm(dip.fem.hist, dip.fem.freq)
test2ct_females <- test2ct(dip.fem.hist, dip.fem.freq)
test2cl_females <- test2cl(dip.fem.hist, dip.fem.freq)
# display results:
test3sr_females
test3sm_females
test2ct_females
test2cl_females

## ---- message=FALSE, warning=FALSE--------------------------------------------
overall_CJS(dip.fem.hist, dip.fem.freq)

## -----------------------------------------------------------------------------
overall_test <- overall_CJS(dip.fem.hist, dip.fem.freq) # overall test
twoct_test <- test2ct(dip.fem.hist, dip.fem.freq) # test for trap-dependence
stat_tp <- overall_test$chi2 - twoct_test$test2ct["stat"] # overall stat - 2CT stat
df_tp <- overall_test$degree_of_freedom - twoct_test$test2ct["df"] # overall dof - 2CT dof
pvalue <- 1 - pchisq(stat_tp, df_tp) # compute p-value for null hypothesis: 
                                     # model with trap-dep fits the data well
pvalue

## ---- message=FALSE, warning=FALSE--------------------------------------------
geese <- system.file("extdata", "geese.inp", package = "R2ucare")
geese <- read_inp(geese)

## ---- message=FALSE, warning=FALSE--------------------------------------------
geese.hist <- geese$encounter_histories
geese.freq <- geese$sample_size

## ---- message=FALSE, warning=FALSE--------------------------------------------
test3Gsr(geese.hist, geese.freq)
test3Gsm(geese.hist, geese.freq)
test3Gwbwa(geese.hist, geese.freq)
testMitec(geese.hist, geese.freq)
testMltec(geese.hist, geese.freq)

## ---- message=FALSE, warning=FALSE--------------------------------------------
overall_JMV(geese.hist, geese.freq)

## ---- message=FALSE, warning=FALSE--------------------------------------------
# Assuming the geese dataset has been read in R (see above):
geese.hist[geese.hist > 1] <- 1

## ---- message=FALSE, warning=FALSE--------------------------------------------
# Assuming the geese dataset has been read in R (see above):
geese.hist[geese.hist == 3] <- 2 # all 3s become 2s

## ---- message=FALSE, warning=FALSE,eval=FALSE---------------------------------
#  # Assuming the female dipper dataset has been read in R (see above):
#  t(apply(dip.fem.hist, 1, rev))

## ---- message=FALSE, warning=FALSE,eval=FALSE---------------------------------
#  # Assuming the female dipper dataset has been read in R (see above):
#  mask = (apply(dip.fem.hist, 1, sum) > 0 & dip.fem.freq > 0) # select non-empty histories, and histories with at least one individual
#  sum(!mask) # how many histories are to be dropped?
#  dip.fem.hist[mask,] # drop these histories from dataset
#  dip.fem.freq[mask] # from counts

## ---- message=FALSE, warning=FALSE, eval=FALSE--------------------------------
#  # Assuming the female dipper dataset has been read in R (see above):
#  dip.fem.hist[, c(1,4,6)] # pick occasions 1, 4 and 6 (might be a good idea to clean the resulting dataset)
#  gather_146 <- apply(dip.fem.hist[,c(1,4,6)], 1, max) # gather occasions 1, 4 and 6 by taking the max
#  dip.fem.hist[,1] <- gather_146 # replace occasion 1 by new occasion
#  dip.fem.hist <- dip.fem.hist[, -c(4,6)] # drop occasions 4 and 6

## ---- message=FALSE, warning=FALSE, eval=FALSE--------------------------------
#  # Assuming the geese dataset has been read in R (see above):
#  for (i in 1:nrow(geese.hist)){
#  occasion_first_encounter <- min(which(geese.hist[i,] != 0)) # look for occasion of first encounter
#  geese.hist[i, occasion_first_encounter] <- 0 # replace the first non zero by a zero
#  }
#  # delete empty histories from the new dataset
#  mask <- (apply(geese.hist, 1, sum) > 0) # select non-empty histories
#  sum(!mask) # how many histories are to be dropped?
#  geese.hist[mask,] # drop these histories from dataset
#  geese.freq[mask] # from counts

