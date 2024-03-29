#' Group individual capture-recapture data in encounter histories
#'
#' This function pools together individuals with the same encounter capture-recapture history.
#' @param X matrix of capture-recapture histories
#' @param effX vector with numbers of individuals with that particular capture-recapture history
#' @return matrix with grouped capture-recapture histories and counts in the last column
#' @author Olivier Gimenez <olivier.gimenez@cefe.cnrs.fr>, Roger Pradel, Rémi Choquet
#' @keywords package
#' @export
#' @examples
#' # Generate fake capture-recapture dataset
#' X = matrix(round(runif(300)),nrow=100)
#' freq=rep(1,100)
#' cbind(X,freq)
#' group_data(X,freq)

group_data <- function(X,effX){

# sort data
Y = cbind(X,effX)
s = dim(X)[2]
for (i in s:1) Y = Y[order(Y[,i]),]
# pool data
compteur = 0
effY = Y[,(s+1):dim(Y)[2]]
Y = Y[,-((s+1):dim(Y)[2])]
i = 1
while (i <= dim(Y)[1]){
	j = i
	while ((j <= dim(Y)[1])&&(sum(Y[i,]==Y[j,])==s)){
		j = j+1
	}
   tot1 = sum((effY[i:(j-1)]>0) * effY[i:(j-1)])
   tot2 = sum((effY[i:(j-1)]<0) * effY[i:(j-1)])
   if (any(as.logical(tot1))){
   	compteur = compteur + 1
   	Y[compteur,] = Y[i,]
   	effY[compteur] = tot1
   	}
   if (any(as.logical(tot2))){
   	compteur = compteur + 1
    effY[compteur] = tot2
    Y[compteur,]=Y[i,]
   }
   i = j
}
Y = Y[1:compteur,]
effY = effY[1:compteur]
res = cbind(Y,effY)
res
}
