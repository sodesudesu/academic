# WSLでubuntuをインストールし、Python、R、LaTeXなどの開発環境を用意する

（準備中）

忘れないためのいい加減なメモなので、うそをついているかもしれません。

WindowsでRの開発環境を準備しようとすると、パッケージ保存先のパスに日本語が入り、インストールがストップしてしまうというトラブルがあるらしいです。
一度Linuxに開発環境を作ってしまうのが楽だと思います。

## 準備

- Windows10でもWSLのインストールは可能ですが、Windows11でWSLをインストールすればWSLgでのGUIアプリの使用がデフォルトで可能です（Windows10でもできるの？）。
Xサーバのインストールや毎回の起動などの手間が省けるので、以下ではWindows11環境を想定しています。
- 画面の下の検索のところで「Windowsの機能の有効化または無効化」と入力し、それを選択します。
「仮想マシンプラットフォーム」にチェックがついていることを確認します。

## WSL2 のインストール

### Windows TerminalをインストールしてWSLもインストール

Linux 環境への入口（の一つ）として Windows Terminal というアプリをインストールします。
（もしかするとすでに入っているかもしれません。）

Windows Terminalを開くとデフォルトでWindows PowerShellが立ち上がると思いますが、これを管理者権限で立ち上げます。
そのために、Windows Terminalのウィンドウの上らへんにある「v」をクリックし、Windows PowerShellというやつをコントロールを押しながらクリックします。

「変更を加えるのを許可しますか」的なメッセージには「はい」と回答します。

次のコマンドを入力すれば、wsl2がインストールされ勝手にubuntuもインストールしてくれます。
（2023年11月10日現在、Ubuntu22.04が入ります。）
```sh
PS C:\Users\taiyo> wsl --install
```
インストールが終了すると、再起動しろという旨のメッセージが表示されるので、Windowsの再起動をします。

### aptのアップグレード

再起動後に再びWindows Terminalを起動します。
ウィンドウの上の方にある下矢印をクリックすると、ubuntuというボタンができていると思うので、それをクリックすると、ubuntuが起動できます。

user名とパスワードの登録をさせられます（登録しろと表示されない場合は下の\x{SNOWMAN}の解説へ）。

パッケージ情報の更新をするために、以下のコマンドを順に実行します。
```
sudo apt update
```
```
sudo apt upgrade
```

パスワードを聞かれると思いますが、先ほど登録したものを入力します。

\x{SNOWMAN}
初期user登録画面に遷移せず、root権限で止まってしまうことも稀にあるみたいです。
その場合、そのままubuntuのterminalで
```sh
adduser MrChildren
```
を打ち込みユーザー名を登録し（MrChildrenの部分には自分で決めたuser名を入力してください）、
```sh
sudo gpasswd -a MrChildren sodo
```
でsudo権限をMrChildrenに（くどいが、MrChildrenの部分は自分のuser名に置き換えてください）与えます。

### 再インストールをした場合

wslを再インストール後に起動すると、「WSLにアタッチできませんでした・・・見つかりません。」というメッセージがでて先へ進めないことがあります。
アンインストール前のubuntuの情報を削除する必要があるらしいので、
```sh
wsl --unregister Ubuntu
```
というコマンドを入力したら解決できるはずです。
上の「aptのアップグレード」という節の操作をおこなってください。

## 各プログラミング言語の開発環境の構築

すでに、perlやawk、pythonは使える状態になっています。
以下、2024年2月8日現在のバージョン：
```sh
taiyo@DESKTOP-904B5HO:~$ perl -v

This is perl 5, version 34, subversion 0 (v5.34.0) built for x86_64-linux-gnu-thread-multi
(with 58 registered patches, see perl -V for more detail)

Copyright 1987-2021, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using "man perl" or "perldoc perl".  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.
```

```sh
taiyo@DESKTOP-904B5HO:~$ awk -V
GNU Awk 5.1.0, API: 3.0 (GNU MPFR 4.1.0, GNU MP 6.2.1)
Copyright (C) 1989, 1991-2020 Free Software Foundation.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.
```

```sh
taiyo@DESKTOP-904B5HO:~$ python3 -V
Python 3.10.12
```

### ビルドツールのインストール

```sh
sudo apt install build-essectial
```
と入力すれば、ビルドツールがインストールされます。

例えば、gcc
```sh
taiyo@DESKTOP-904B5HO:~$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/11/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu 11.4.0-1ubuntu1~22.04' --with-bugurl=file:///usr/share/doc/gcc-11/README.Bugs --enable-languages=c,ada,c++,go,brig,d,fortran,objc,obj-c++,m2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-11 --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-bootstrap --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib --enable-libphobos-checking=release --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch --disable-werror --enable-cet --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-11-XeT9lY/gcc-11-11.4.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=/build/gcc-11-XeT9lY/gcc-11-11.4.0/debian/tmp-gcn/usr --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu --with-build-config=bootstrap-lto-lean --enable-link-serialization=2
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
```
やmake
```sh
taiyo@DESKTOP-904B5HO:~$ make -v
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```
やwget
```sh
taiyo@DESKTOP-904B5HO:~$ wget -V
GNU Wget 1.21.2 built on linux-gnu.

-cares +digest -gpgme +https +ipv6 +iri +large-file -metalink +nls
+ntlm +opie +psl +ssl/openssl

Wgetrc:
    /etc/wgetrc (system)
Locale:
    /usr/share/locale
Compile:
    gcc -DHAVE_CONFIG_H -DSYSTEM_WGETRC="/etc/wgetrc"
    -DLOCALEDIR="/usr/share/locale" -I. -I../../src -I../lib
    -I../../lib -Wdate-time -D_FORTIFY_SOURCE=2 -DHAVE_LIBSSL -DNDEBUG
    -g -O2 -ffile-prefix-map=/build/wget-8g5eYO/wget-1.21.2=.
    -flto=auto -ffat-lto-objects -flto=auto -ffat-lto-objects
    -fstack-protector-strong -Wformat -Werror=format-security
    -DNO_SSLv2 -D_FILE_OFFSET_BITS=64 -g -Wall
Link:
    gcc -DHAVE_LIBSSL -DNDEBUG -g -O2
    -ffile-prefix-map=/build/wget-8g5eYO/wget-1.21.2=. -flto=auto
    -ffat-lto-objects -flto=auto -ffat-lto-objects
    -fstack-protector-strong -Wformat -Werror=format-security
    -DNO_SSLv2 -D_FILE_OFFSET_BITS=64 -g -Wall -Wl,-Bsymbolic-functions
    -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -Wl,-z,now
    -lpcre2-8 -luuid -lidn2 -lssl -lcrypto -lz -lpsl ftp-opie.o
    openssl.o http-ntlm.o ../lib/libgnu.a

Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://www.gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```
がインストールされるようです。

ここまでの内容は[奥村晴彦さんのWebページおよびYouTube動画](https://okumuralab.org/~okumura/misc/221004.html)を見るのがわかりやすいと思います。

### Python

Pythonは（最新ではないが）デフォルトで入っています。
しかし、pythonのパッケージ管理に必要なpipは入っていないようなので、次のコマンドでインストールします。

```sh
sudo apt install python3-pip
```

バージョンを確認してみますと、2023年11月11日現在pip 22.0.2がインストールされるようです。
これは最新版でないので、アップグレードをします。

```sh
pip install --upgrade pip
```

### R

#### 楽な方法その1

aptでインストールできます。
```sh
sudo apt install r-base
```

### 楽な方法その2

CRANの[このページ](https://cran.ism.ac.jp/bin/linux/ubuntu/)に従っておこないます。
以下、2023年10月11日におこなったインストール手順です。

Dirmngrとsoftware-properties-commmon（これらが何なのか詳しく知らないが、、、）の最新バージョンのものをインストールします。

```sh
sudo apt install software-properties-common dirmngr
```

GPGキーのダウンロードと保存をおこないます。

```sh
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
```

リポジトリの追加をおこないます。

```sh
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/"
```

上の`jammy`と書かれている部分は、自分のコードネームに合わせて書き換えてください。
コードネームは`lsb_release -a`と打てば教えてくれます。

とうとう最新のRのインストールができます。

```sh
sudo apt install r-base
```

これで、Rが使えるようになったので、確認します。
そのままTerminalで、`R`と打てば、Rが起動します。

```R
MrChildren@DESKTOP-9R867O9:~$ R

R version 4.3.2 (2023-10-31) -- "Eye Holes"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R は、自由なソフトウェアであり、「完全に無保証」です。
一定の条件に従えば、自由にこれを再配布することができます。
配布条件の詳細に関しては、'license()' あるいは 'licence()' と入力してください。

R は多くの貢献者による共同プロジェクトです。
詳しくは 'contributors()' と入力してください。
また、R や R のパッケージを出版物で引用する際の形式については
'citation()' と入力してください。

'demo()' と入力すればデモをみることができます。
'help()' とすればオンラインヘルプが出ます。
'help.start()' で HTML ブラウザによるヘルプがみられます。
'q()' と入力すれば R を終了します。
```

使えます：

```R
> 1 + 1
[1] 2
```

```R
> NotMrChildren = c("sakurai", "suzuki", "nakagawa", "tahara", "taiyo")
> NotMrChildren
[1] "sakurai"  "suzuki"   "nakagawa" "tahara"   "taiyo"
```

```R
> MrChildren = NotMrChildren[-5]
> MrChildren
[1] "sakurai"  "suzuki"   "nakagawa" "tahara"
```

Rの終了は`q()`でできます。

Rの統合環境として人気が高いRstudioもインストールしておきます。
ずぶんはemacsのR用のプラグインであるESSを使っていくつもりですが、たまにバグるのがつらいです。
だから保険としてRstudioは使えるようにします。
（と思ったが、なんか苦戦しているので保留。）

#### ソースからビルドする

パッケージのバージョンで矛盾を起こしてストップしないよう、dockerを作成し繊細にRの開発環境を準備する方法です。

### LaTeX

#### お気楽な方法〜aptでインストール

2023年11月11日現在、以下のコマンドでaptに登録されているTeX Live 2021がインストールされます。
ずぶんは、あとからあれこれ足りないと怒られるのが面倒なのでfullインストールしましたが、5GBとかなり大容量なものらしいです。
```
sudo apt install texlive-full
```
