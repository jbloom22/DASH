set.seed(0)

dot <- function(x){
  return(sum(x * x))
}

# Public
K = 3
M = 10000

# Alice's private data
N1 = 1000
y1 = rnorm(N1)
X1 = matrix(rnorm(N1 * M), N1, M)
C1 = matrix(rnorm(N1 * K), N1, K)

# Bob's private data
N2 = 2000
y2 = rnorm(N2)
X2 = matrix(rnorm(N2 * M), N2, M)
C2 = matrix(rnorm(N2 * K), N2, K)

# Carla's private data
N3 = 1500
y3 = rnorm(N3)
X3 = matrix(rnorm(N3 * M), N3, M)
C3 = matrix(rnorm(N3 * K), N3, K)

# Alice computes and secret shares...
yy1 = dot(y1)
Xy1 = t(X1) %*% y1
XX1 = apply(X1,2,dot)

Cty1 = t(C1) %*% y1
CtX1 = t(C1) %*% X1

R1 = qr.R(qr(C1))

# Bob computes and secret shares...
yy2 = dot(y2)
Xy2 = t(X2) %*% y2
XX2 = apply(X2, 2, dot)

Cty2 = t(C2) %*% y2
CtX2 = t(C2) %*% X2

R2 = qr.R(qr(C2))

# Carla computes and secret shares...
yy3 = dot(y3)
Xy3 = t(X3) %*% y3
XX3 = apply(X3, 2, dot)

Cty3 = t(C3) %*% y3
CtX3 = t(C3) %*% X3

R3 = qr.R(qr(C3))

# Secure multi-party computation is independent of sample sizes:
D = N1 + N2 + N3 - K - 1

yy = yy1 + yy2 + yy3
Xy = Xy1 + Xy2 + Xy3
XX = XX1 + XX2 + XX3

Cty = Cty1 + Cty2 + Cty3
CtX = CtX1 + CtX2 + CtX3

invR = solve(qr.R(qr(rbind(R1, R2, R3))))

Qty = t(invR) %*% Cty 
QtX = t(invR) %*% CtX

QtyQty = dot(Qty)
QtXQty = t(QtX) %*% Qty
QtXQtX = apply(QtX, 2, dot)

yyq = yy - QtyQty
Xyq = Xy - QtXQty
XXq = XX - QtXQtX

beta = Xyq / XXq
sigma = sqrt((yyq / XXq - beta^2) / D)
tstat = beta / sigma
pval = 2 * pt(-abs(tstat), D)

df = data.frame(beta=beta, sigma=sigma, tstat=tstat, pval=pval)

# Verify correctness for the first M0 columns of X:
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
