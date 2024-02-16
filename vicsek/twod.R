## 2次元vicsekモデル
## 2024/02/14

rm(list=ls())
library(animation)

## 計算ステップ数
time = 100
## バクテリア数
n = 10000
## 一辺の大きさ
l = 10

## ノイズ強度
eta = 0.01
## 相互作用の範囲
R = 1
## 初期速度
v_0 = 0.1

## ランダムな初期条件
ran_x = runif(n, 1, l)
ran_y = runif(n, 1, l)
ran_theta = runif(n, 0, 2*pi)

bact = data.frame(id=1:n, x=ran_x, y=ran_y, theta=ran_theta)


vicsek = function() {
    
    for (t in 1:time) {

        past_x = bact$x
        past_y = bact$y
        
        plot(0, 0, type="n", xlim=c(0, l), ylim=c(0, l))
    
        for (i in 1:n) {
            
            neighbor = 0 # 隣人の初期化

            for (j in 1:n) {
                d = (bact$x[i] - bact$x[j])^2 + (bact$y[i] - bact$y[j])^2
                if (0<d && d<R^2)
                    neighbor = neighbor + cos(bact$theta[j]) + 1i*sin(bact$theta[j])
            }

            ## 角度
            bact$theta[i] = Arg(neighbor) + eta
            ## 位置
            bact$x[i] = (past_x[i] + v_0 * cos(bact$theta[i])) %% l
            bact$y[i] = (past_y[i] + v_0 * sin(bact$theta[i])) %% l

            arrows(bact$x[i], bact$y[i],
                   bact$x[i]+l/40*cos(bact$theta[i]), bact$y[i]+l/40*sin(bact$theta[i]),
                   length=l/10000)
        }
    }
}

saveGIF(vicsek(), movie.name="sample.gif", interval=0.04)
