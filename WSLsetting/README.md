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
そのために、Windows Terminalのウィンドウの下矢印をクリックし、Windows Power Shellというやつをコントロールを押しながらクリックします。

「変更を加えますか」的なメッセージには「はい」と回答します。

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

### 
