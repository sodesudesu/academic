<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [1. 前半](#1-前半)
  - [1.1. 演算子形式の量子論](#11-演算子形式の量子論)
    - [1.1.1. 古典論と量子論の違い](#111-古典論と量子論の違い)
    - [1.1.2. （気は早いが）ここまでのまとめ](#112-気は早いがここまでのまとめ)
    - [1.1.3. 系の（純粋）状態を表す](#113-系の純粋状態を表す)
    - [1.1.4. 物理量を表す](#114-物理量を表す)
    - [1.1.5. 測定値をどう表すか](#115-測定値をどう表すか)
    - [1.1.6. 測定値の確率分布を表す](#116-測定値の確率分布を表す)
    - [1.1.7. 時間発展について](#117-時間発展について)

<!-- /code_chunk_output -->


# 1. 前半

## 1.1. 演算子形式の量子論

### 1.1.1. 古典論と量子論の違い

- 古典論

    ある時刻にそれぞれの物理量の値は一定値に定まっている。
    測定によってそれらの値を知る。

- 量子論

    ある時刻にすべての物理量は一定値に定まっていることは一般にない。
    （ある系の状態）を測定したときに得られる値はランダムに現れるがその確率分布は決まっている。

    eg
    電子スピンが$+1$方向の状態$\ket{\rightarrow}$の$z$方向スピンを測定。

    測定値$S_z = + \dfrac{\hbar}{2},\, \dfrac{\hbar}{2}$がランダムに現れる。
    確率分布$P(S_z)$は定まっている。

### 1.1.2. （気は早いが）ここまでのまとめ

> 量子論：
    ある時刻にすべての物理量は一定値に定まっていることは一般にない。
    （ある系の状態）を測定したときに得られる値はランダムに現れるがその確率分布は決まっている。

よって、知りたいこと：
- 系の状態はどう表されるか。
- 物理量はどう表されるか。
- 測定値はどう表されるか。
- 確率分布はどう表されるか。

### 1.1.3. 系の（純粋）状態を表す
 
**（数学）複素ヒルベルト空間**

複素ヒルベルト空間$\mathcal{H}$：内積が定義された完備なベクトル空間。
$$
\ket{\psi} = \begin{pmatrix} c_1 \\ c_2 \\ \vdots \\ c_N \end{pmatrix} ,\, c_1 ,\, \cdots , c_N \in \mathbb{C}
$$

内積は次のように書く：
$$
\braket{\phi | \psi} = (z_1^* , z_2^*, \cdots , z_N^*) \begin{pmatrix} c_1 \\ c_2 \\ \vdots \\ c_N \end{pmatrix}
$$

※つまり、内積の前の部分はベクトルを転置させてそれぞれの要素の複素共役をとる。

内積の性質（の内この先使いそうなもの）：
- $\bra{\phi} \left( \ket{\psi_1} + \ket{\psi_2} \right) = \braket{\phi | \psi_1} + \braket{\phi | \psi_2}$
- $\left( \bra{\phi_1} + \bra{\phi_2} \right) \ket{\psi} = \braket{\phi_1 | \psi} + \braket{\phi_2 | \psi}$
- $\braket{\phi | c\psi} = c\braket{\phi | \psi} ,\, c \in \mathbb{C}$
- $\braket{c\phi | \psi} = c^* \braket{\phi | \psi}$
- $\braket{\phi | \psi} = \braket{\psi | \phi}^* $
- $\braket{\psi | \psi} \ge 0$
- $\braket{\psi | \psi} = 0 \Leftrightarrow \ket{\psi} = 0$

ノルムが次のように定義される：
$$
\| \psi \| = \sqrt{\braket{\psi | \psi}} \ge 0
$$

**（物理の要請）**

量子力学の系の（純粋）状態は複素ヒルベルト空間$\mathcal{H}$の規格化された（射線$e^{i\theta}\ket{\psi}$の中から一つ代表をとった）ベクトル$\ket{\psi}$で表される。


> - [x] 系の状態はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の規格化された射線$e^{i\theta}\ket{\psi}$
> - [ ] 物理量はどう表されるか。
> - [ ] 測定値はどう表されるか。
> - [ ] 確率分布はどう表されるか。

### 1.1.4. 物理量を表す

**（数学）線形演算子**

線形演算子$\hat{A}$（この先ただ単に演算子と呼ぶ）：

$\ket{\psi_1},\,\ket{\psi_2} \in \mathcal{H},\, c_1 ,\,c_2 \in \mathbb{C}$に対して
$$
\hat{A} \left( c_1 \ket{\psi_1} + c_2 \ket{\psi_2} \right) = c_1 \hat{A} \ket{\psi_1} + c_2 \hat{A} \ket{\psi_2}
$$

**（数学）エルミート演算子**

$\ket{\phi}$と$\hat{A}\ket{\psi}$の内積$\braket{\phi | \hat{A} \psi} =: \braket{\phi | \hat{A} | \psi}$について
$$
\braket{\phi | \hat{A} | \psi} = \braket{\hat{A}^\dagger \phi | \psi}
$$
上に現れた$\hat{A}^\dagger$：エルミート演算子（$\hat{A}$の転置行列の複素共役をとったもの）

例えば、
$$
\hat{A} = \begin{pmatrix} a & b \\ c & d \end{pmatrix} ,\, \hat{A} = \begin{pmatrix} a^* & c^* \\ b^* & d^* \end{pmatrix}
$$

一応$\braket{\phi | \hat{A} | \psi} = \braket{\hat{A}^\dagger \phi | \psi}$を確かめる：
$$
\braket{\phi | \hat{A} | \psi} = \sum_{i = 0}^N z_i^* \sum_{j = 0}^N \left( A_{ij} c_j \right) = \sum_{i,j = 0}^N A_{ij} z_i^* c_j \\
\braket{\hat{A}^\dagger \phi | \psi} = \sum_{j = 0}^N\left( \sum_{i = 0}^N A_{ij} z_i \right)^* c_j  = \sum_{i,j = 0}^N A_{ij} z_i^* c_j
$$

（補足）

自己共役演算子$\hat{A}$の定数倍$k\hat{A}$も自己共役演算子。

**（物理の要請）**

物理量はヒルベルト空間$\mathcal{H}$の自己共役演算子で表される。

eg
スピン演算子：
$$
\hat{S}_x = \dfrac{\hbar}{2}\hat{\sigma}_x ,\, \hat{S}_y = \dfrac{\hbar}{2}\hat{\sigma}_y ,\, \hat{S}_z = \dfrac{\hbar}{2}\hat{\sigma}_z
$$

※$\hat{\sigma}_x = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} ,\, \hat{\sigma}_x = \begin{pmatrix} 0 & -i \\ i & 0 \end{pmatrix} ,\, \hat{\sigma}_x = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}$をパウリ演算子という。
$\hat{\sigma}_\alpha$は自己共役演算子だから、その定数倍の$\hat{S}_\alpha$も自己共役演算子。

> - [x] 系の状態はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の規格化された射線$e^{i\theta}\ket{\psi}$
> - [x] 物理量はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の自己共役演算子
> - [ ] 測定値はどう表されるか。
> - [ ] 確率分布はどう表されるか。

### 1.1.5. 測定値をどう表すか

**（物理の要請）**

自己共役演算子$\hat{A}$で表される物理量の測定値はその固有値のどれか。

**（数学）自己共役演算子とその固有値の性質**

１　自己共役演算子の固有値は実数：$\hat{A} \ket{\psi} = a \ket{\psi} ,\, a \in \mathbb{R}$

なぜならば
$$
\braket{a | \hat{A} | a} = a\braket{a | a} \\
\braket{a | \hat{A} | a} = \braket{\hat{A}^\dagger a | a} = \braket{\hat{A} a | a} = a^* \braket{a | a}
$$
$\ket{a} \neq 0$より$\braket{a | a} \neq 0$だから$a\braket{a | a} = a^* \braket{a | a}$のためには$a$が実数。

２　自己共役演算子$\hat{A} \in \mathrm{有限な} \mathcal{H}$。
$\hat{A}$の固有ベクトルを縮退しているものも含めてすべて集めれば$\mathcal{H}$の正規直交基底になるように選べる。

つまり、任意の$\ket{\psi} \in \mathcal{H}$について適当な複素数$\psi_l (a)$を用いて次のように書ける：
$$
\ket{\psi} = \sum_l \sum_a \psi (a^{(l)}) \ket{a^{(l)}}
$$
※$l$は縮退の分を表す。
※固有値が連続的な場合は
$$
\ket{\psi} = \int_a da \int_l dl \, \psi (a^{(l)}) \ket{a^{(l)}}
$$

> - [x] 系の状態はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の規格化された射線$e^{i\theta}\ket{\psi}$
> - [x] 物理量はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の自己共役演算子
> - [x] 測定値はどう表されるか。
>   - 固有値
> - [ ] 確率分布はどう表されるか。

### 1.1.6. 測定値の確率分布を表す

**（物理の要請）**

物理量$\hat{A}$を測定してある値$a$を得る確率：
$$
P(a) = \sum_{l = 0}^{N_a} |\braket{a^{(l)} | \psi}|^2
$$

もちろん${}^1 P(a) \ge 0,\, {}^2 \sum_a P(a) = 1$を満たす。

示す：

1：$\ket{\psi} = \sum_l \sum_a \psi (a^{(l)}) \ket{a^{(l)}}$の両辺に左から$\bra{\psi^{(l)}}$をかけて、$\psi(a^{(l)}) = \braket{a^{(l)} | \psi}$。
$\psi(a^{(l)}) \in \mathbb{C}$より、
$$
P(a) = \sum_{l = 0}^{N_a} |\braket{a^{(l)} | \psi}|^2 = |\psi(a^{(l)})|^2 \ge 0
$$

２：
$$
\sum_{a} P(a) = \sum_{a} \sum_{l = 0}^{N_a} |\braket{a^{(l)} | \psi}|^2 = \sum_{a} \sum_{l = 0}^{N_a} \braket{\psi | a^{(l)}}\braket{a^{(l)} | \psi} \\
= \sum_{a} \sum_{l = 0}^{N_a} \braket{\psi | a^{(l)}} \psi(a^{(l)}) =  \braket{\psi | \sum_{a} \sum_{l = 0}^{N_a} \psi(a^{(l)}) a^{(l)}}  = \braket{\psi | \psi} = 1$$
（最初の要請：系の状態は規格化されたベクトルで表される、を使った）

eg

（落ち着かないと思うので）ここで計算問題をやる。

スピン$z$成分を表す物理量$\hat{S}_z = \dfrac{\hbar}{2}\hat{\sigma}_z = \dfrac{\hbar}{2} \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}$を測定したときの固有値と確率。
話を（少しでも）簡単にするために$\hat{\sigma}_z$の固有ベクトル・固有値を考える。
$$\begin{align}
\hat{\sigma}_z \begin{pmatrix} x_1 \\ x_2 \end{pmatrix} &= \lambda \begin{pmatrix} x_1 \\ x_2 \end{pmatrix} \notag \\
\begin{pmatrix} 1 - \lambda & 0 \\ 0 & -1 -\lambda \end{pmatrix} \begin{pmatrix} x_1 \\ x_2 \end{pmatrix} &= 0 \notag
\end{align}$$
よって$\lambda = \pm 1$。

- $\lambda = +1$のとき、固有ベクトル$\ket{\uparrow} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$。
- $\lambda = -1$のとき、固有ベクトル$\ket{\downarrow} = \begin{pmatrix} 0 \\ 1 \end{pmatrix}$。

適当な状態$\ket{\psi} = \begin{pmatrix} c_1 \\ c_2 \end{pmatrix}$の$\hat{\sigma}_z$を測定したとき、測定値が$\lambda = +1$の確率は
$$
P(+1) = |\braket{\uparrow | \psi}|^2 = c_1^2
$$

（少し具体的に...）スピン$+x$方向の状態は$\ket{\rightarrow} = \dfrac{1}{\sqrt{2}}\left( \ket{\uparrow} + \ket{\downarrow} \right)$と書ける（$\lambda = +1$の状態と$\lambda = -1$の状態の1:1の混合状態。自分で計算して確かめられる）。
この状態について、$\lambda = +1$である確率は
$$
P(+1) = |\braket{\uparrow | \rightarrow}|^2 = \dfrac{1}{2} |\bra{\uparrow} \left( \ket{\uparrow} + \ket{\downarrow}\right)|^2 = \dfrac{1}{2}
$$

> - [x] 系の状態はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の規格化された射線$e^{i\theta}\ket{\psi}$
> - [x] 物理量はどう表されるか。
>   - 複素ヒルベルト空間$\mathcal{H}$の自己共役演算子
> - [x] 測定値はどう表されるか。
>   - 固有値
> - [x] 確率分布はどう表されるか。
>   - ボルンの確率規則$P(a) = \sum_{l = 0}^{N_a} |\braket{a^{(l)} | \psi}|^2$

### 1.1.7. 時間発展について

**（物理の要請）**

$\hat{H}$をエネルギーを表す自己共役演算子ハミルトンとする。
系の状態$\ket{\psi}$が時間発展するとすると、時刻$t$の状態$\ket{\psi(t)}$について次の関係が成り立つ：
$$
i\hbar \dfrac{d}{dt}\ket{\psi(t)} = \hat{H} \ket{\psi(t)}
$$