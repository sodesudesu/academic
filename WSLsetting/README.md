# WSLでubuntuをインストールし、Python、R、LaTeXなどの開発環境をemacsで用意する

（準備中）

忘れないためのいい加減なメモなので、うそをついているかもしれません。
次のものを参考にしました：

- [奥村晴彦さんのWebページおよびYouTube動画](https://okumuralab.org/~okumura/misc/221004.html)

## WSLとUbuntuのインストール

ずぶんはWindown Terminalというアプリを使ってインストールをおこないいました。
曖昧な記憶ですが、Windows Terminalはデフォルトでインストールされているはずです。
されていなければ、Microsoft storeからタダでダウンロードできます。

Windows Terminalではデフォルトでpower shellが立ち上がると思いますが、これを管理者権限で立ち上げます。
そのために、Windows Terminalのウィンドウの上らへんにある下矢印をクリックし、Windows Power Shellというやつをコントロールを押しながらクリックします。

「変更を加えるのを許可しますか」的なメッセージには「はい」と回答します。

次のコマンドを入力すれば、wsl2がインストールされ勝手にubuntuもインストールしてくれます。
（2023年11月10日現在、Ubuntu22.04が入ります。）

```
PS C:\Users\MrChildren> wsl --install
```

インストールが終了すると、再起動しろという旨のメッセージが表示されるので、Windowsの再起動をします。

## アップグレードと諸問題への解決策

再起動後に再びWindows Terminalを起動します。
ウィンドウの上の方にある下矢印をクリックすると、ubuntuというボタンができていると思うので、それをクリックすると、ubuntuが起動できます。

user名とパスワードを聞かれるので、登録をします。

パッケージの更新をするために、以下のコマンドを順に実行します。

```
sudo apt update
```

```
sudo apt upgrade
```

パスワードを聞かれると思いますが、先ほど登録したものを入力します。

ここで、過去にずぶんが直面したトラブルシューティング（？）を記しておきます。

- **wslを再インストール後に起動すると、「WSLにアタッチできませんでした・・・見つかりません。」というメッセージがでて先へ進めない。**アンインストール前のubuntuの情報を削除する必要があるらしいので、`wsl --unregister Ubuntu`というコマンドを入力したら解決できるはずです。
- **初期user登録画面に遷移せず、root権限で止まってしまう。**ubuntuの初回起動時は勝手にuser登録をさせられるはずなのに、たまにrootで起動してしまいます。この状態から、`adduser MrChildren`でユーザー名を登録し（MrChildrenの部分には自分で決めたuser名を入力してください）、`sudo gpasswd -a MrChildren sodo`でsudo権限をMrChildrenに（くどいが、MrChildrenの部分は自分のuser名に置き換えてください）与えます。このように（ある意味）手動でuser登録をすれば、問題は解決されます。

## 各プログラミング言語の開発環境の構築

### Python

Pythonはデフォルトで入っているはずです。

2023年11月10日現在は以下の通り：

```
MrChildren@DESKTOP-9R867O9:~$ python3
Python 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
```

しかし、pythonのパッケージ管理に必要なpipは入っていないようなので、次のコマンドでインストールします。

```
sudo apt install python3-pip
```

バージョンを確認してみますと、2023年11月11日現在pip 22.0.2がインストールされるようです。
これは最新版でないので、アップグレードをします。

```
pip install --upgrade pip
```

### C言語、C++などのコンパイラのインストール

ずぶん（←ところでこの一人称は謎）は受講している講義や電子工作でC言語やC++をたまに使うので、これらの環境もつくっておきます。
次のコマンドを実行するだけで、これらのコンパイラやFortranのコンパイラ、makeなどが使えるようになります。

```
sudo apt install build-essential
```

### R

R本体のインストールはCRANの[このページ](https://cran.ism.ac.jp/bin/linux/ubuntu/)に従っておこないます。
以下、2023年10月11日におこなったインストール手順です。

Dirmngrとsoftware-properties-commmon（これらが何なのか詳しく知らないが、、、）の最新バージョンのものをインストールします。

```
sudo apt install software-properties-common dirmngr
```

GPGキーのダウンロードと保存をおこないます。

```
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
```

リポジトリの追加をおこないます。

```
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/"
```

上の`jammy`と書かれている部分は、自分のコードネームに合わせて書き換えてください。
コードネームは`lsb_release -a`と打てば教えてくれます。

とうとう最新のRのインストールができます。

```
sudo apt install r-base
```

これで、Rが使えるようになったので、確認します。
そのままTerminalで、`R`と打てば、Rが起動します。

```
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

```
> 1 + 1
[1] 2
```

```
> NotMrChildren = c("sakurai", "suzuki", "nakagawa", "tahara", "taiyo")
> NotMrChildren
[1] "sakurai"  "suzuki"   "nakagawa" "tahara"   "taiyo"
```

```
> MrChildren = NotMrChildren[-5]
> MrChildren
[1] "sakurai"  "suzuki"   "nakagawa" "tahara"
```

Rの終了は`q()`でできます。

Rの統合環境として人気が高いRstudioもインストールしておきます。
ずぶんはemacsのR用のプラグインであるESSを使っていくつもりですが、たまにバグるのがつらいです。
だから保険としてRstudioは使えるようにします。
（と思ったが、なんか苦戦しているので保留。）

### LaTeX

2023年11月11日現在、以下のコマンドでTeX Live 2021がインストールされます。
ずぶんは、あとからあれこれ足りないと怒られるのが面倒なのでfullインストールしましたが、5GBとかなり大容量なものらしいです。

```
sudo apt install texlive-full
```

この後、emacsでの実行環境を準備します。

## emacs

ずぶんは、『ソーシャル・ネットワーク』という映画にもろ影響を受けて（←まったく単純な野郎である）emacsというエディタを触ってみたいとなってます。
ただ、たぶんVisual Studio Codeで操作したほうが（慣れもあって）楽に感じます。
Visual Studio CodeとWSLの連携も簡単なのであとで述べる予定です。

### インストール

インストールするには次のように打って実行します。

```
sudo apt install emacs
```

これでGNU emacsというGUI操作も可能なemacsが入ります。

emacsを起動するには、`emacs`と書いてEnterを押せばよいです。
（なのだが、なぜかWSLのGUIアプリで日本語入力がうまくいかない――具体的には、日本語で文字を書いてEnterを押すまで表示されないでも変換候補にはひょうじされている）――ので、`emacs`のかわり`emacs -nw`といコマンドを入れると、Windows Terminal上でemacsが使え、日本語入力も問題なくおこなえます。そもそも、コマンドだけで華麗にファイルを操作するマーク・ザッカーバーグにあこがれてemacsを使いはじめたわけだから、まあこれで何も問題ないのだが。）
