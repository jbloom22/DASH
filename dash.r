set.seed(0)

dot <- function(x){
  return(sum(x * x))
}

# Public
N1 = 1000
N2 = 2000
N3 = 1500
M = 10000
K = 3

D = N1 + N2 + N3 - K - 1

# Alice
y1 = rnorm(N1)
X1 = matrix(rnorm(N1 * M), N1, M)
C1 = matrix(rnorm(N1 * K), N1, K)
R1 = qr.R(qr(C1))

# Bob
y2 = rnorm(N2)
X2 = matrix(rnorm(N2 * M), N2, M)
C2 = matrix(rnorm(N2 * K), N2, K)
R2 = qr.R(qr(C2))

# Carla
y3 = rnorm(N3)
X3 = matrix(rnorm(N3 * M), N3, M)
C3 = matrix(rnorm(N3 * K), N3, K)
R3 = qr.R(qr(C3))

# Public or tree or SMC
invR = solve(qr.R(qr(rbind(R1, R2, R3))))

# Alice
Q1 = C1 %*% invR
Qty1 = t(Q1) %*% y1
QtX1 = t(Q1) %*% X1

yy1 = dot(y1)
Xy1 = t(X1) %*% y1
XX1 = apply(X1,2,dot)

# Bob
Q2 = C2 %*% invR
Qty2 = t(Q2) %*% y2
QtX2 = t(Q2) %*% X2

yy2 = dot(y2)
Xy2 = t(X2) %*% y2
XX2 = apply(X2, 2, dot)

# Carla
Q3 = C3 %*% invR
Qty3 = t(Q3) %*% y3
QtX3 = t(Q3) %*% X3

yy3 = dot(y3)
Xy3 = t(X3) %*% y3
XX3 = apply(X3, 2, dot)

# Public or SMC
yy = yy1 + yy2 + yy3
Xy = Xy1 + Xy2 + Xy3
XX = XX1 + XX2 + XX3

Qty = Qty1 + Qty2 + Qty3
QtX = QtX1 + QtX2 + QtX3

QtyQty = dot(Qty)
QtXQty = t(QtX) %*% Qty
QtXQtX = apply(QtX, 2, dot)

yyq = yy - QtyQty
Xyq = Xy - QtXQty
XXq = XX - QtXQtX

# Public
beta = Xyq / XXq
sigma = sqrt((yyq / XXq - beta^2) / D)
tstat = beta / sigma
pval = 2 * pt(-abs(tstat), D)

df = data.frame(beta=beta, sigma=sigma, tstat=tstat, pval=pval)

# Compare to primary analysis for first M0 columns of $X$
M0 = 5

y = c(y1 ,y2, y3)
X = rbind(X1, X2, X3)
C = rbind(C1, C2, C3)

res = matrix(nrow=0,ncol=4)
for (m in 1:M0) {
  fit = lm(y ~ X[,m] + C - 1)
  res = rbind(res,as.vector(summary(fit)$coefficients[1,]))
}

df2 = data.frame(beta=res[,1], sigma=res[,2], tstat=res[,3], pval=res[,4])

all.equal(df[1:M0,],df2) # Returns TRUE
