# ft_server
### This repogitory is for my studying about Docker


### 基礎動作
 What is Docker container?->OSレベルでコンテナイメージを作成し、自信もイメージとして、パッケージ化している。
とりあえず、  
```docker container run hello-world```  
のcommandを実効してみると、hello-wordlというイメージかが起動され、コンテナが実効される。<br>
この際以下の流れで物事が起きている。<br>
1:docker クライアント(command)がdockerdemon(サーバ)に命令（demonとかクライアントとかは、docker公式ドキュメントを見ると分かる。）<br>
2:docker demonが[hello-world]イメージをdockerhubから取得<br>
3:docker demonがイメージからコンテナを作成。メッセージを常時するプログラムをここで実効<br>
4:docker demonがメッセージをdockerクライアントに送信し、ターミナルに表示<br>

 
### nginxの展開 
```docker container run -p 8080:80 nginx```<br>
```--name```<br>
でコンテナに名前をつけられる。つけないと、適当に名前がつく。同じ名前のコンテナは作ることができないので、注意<br>

```docker container run --name mynginx -d -p 8081:80 ngix:1.9.15-alpine```<br>
```-d```でコンテナをデーモンとして起動できる（バックグラウンドで実効）<br>

```-p 80:80```コンテナのhost portが80でmap port が80という意味。```nginx```というイメージを使っている。

```docker contaier ls```<br>
で現在動いているコンテナの確認
```docker ps```<br>
でも可能

起動しているコンテナは<br>
```docker container stop <container name>```<br>
で停止可能

## docker commandについて
```docker ＜サブコマンド＞　＜操作＞　＜オプション＞```
#### <サブコマンド>
```help, container, image```
#### <操作>
```run, stop, rm, pull, image```
#### <オプション>
```--help, -d, -it, --name```  

```docker container run <イメージ名>　<コンテナで実行するcommand>```<br>
コンテナで実行するcommandは、imageごとにデフォルトで実行されるcommandが指定されているため、省略した場合には、それが実行される。<br>
コンテナを直接操作したい場合には、```-it```を用いる<br>
```-t```は```--tty```オプションと```-i```は```--interactive```の二つをくっつけたオプション（-が省略形で、--が長い指定系）<br>
```-d,--detach```は、コンソールを離れ、バックグラウンドで起動するオプション。<br>
フォアグラウンドで起動した場合には、コンソールで```Ctrl-P``` ```Ctrl-Q```を行うとバックグラウンドに持っていける。<br>
バックグラウンドで起動しているコンテナ端末に入るためには、```container attach <コンテナ名>```を用いる。<br>
バックグラウンドでただ、runする場合は、すぐにstopしてしまう。ただ、stopした場合でもコンテナのキャッシュが残るから、同名のコンテナを作ることはできない。<br>
```--rm```オプションは、コンテナが停止されたらコンテナを即破棄するオプションである。<br>

```docker container exec```ですでに稼働しているコンテナに対してcommand操作を行うことができるようになる。<br>

```docker container exec nginx_container date```<br>
```docker container exex -it nginx_container bash```<br>
```dcoker container exec nginx_container sh -c "echo 'hello docker' > /hello.txt"```<br>
```docker container exec nginx_conatiner cat /hello.txt```<br>


```docker conatiner inspect <コンテナ名>```で特定のコンテナの情報を知ることができる。<br>
```docker container run -d -p 8080:80 nginx```で起動したコンテナのlogを
```docker container logs <コンテナID>```でlodで確認できる。<br>
ログを継続して表示したい場合には```-f```オプションを用いる```docker container logs -f <コンテナID>``` <br>
```-t, --timestamps```オプションで、ログにタイムスタンプをつけることができる。<br>
コンテナの統計情報は
```docker container stats```で見れるが、このままだとリアルタイムの情報を出力し続けてしまうので、
```docker conatiner stats --no-stream```を用いる。
出したい情報を制限する場合には、```--format```オプションを用いる。
```docker conatier ls --format='tabale {{.ID}}\t{{.Names}}\t{{.Ports}}'```<br>
```docker stop <コンテナ名>```でストップしたコンテナは```docker start <コンテナ名>```で再起動することができる。しかし、この場合、コンテナ上で書き込まれたデータなどは停止前の状態を引き継ぐので注意。
```docker container restart <コンテナ名>```コンテナを再起動できる。この場合も、停止前の状態を引き継ぐ。
コンテナの本質は使い捨てができることなので、これらのcommandの使用はあまり推奨されていない。 <br>
停止して、状態を保持する必要があるなら、ボリューム機能などを用いて、データ永続化を行うのがよい。
コンテナの破棄は```docker conatiner rm <コンテナ名>```
起動していないコンテナを全て削除する場合には```docker container prune```を用いる。```-f```を用いると消去の際の確認がなくなる。


### docker helpについて
```docker container help```でcontainerカテゴリーのhelpを見ることができる。
```docker contaier run --help```で```docker contaier run```のhelpを見ることができる。


## Dockerでしちゃだめなこと
#### 環境依存のイメージを作ること。
#### イメージはDockerfileを用いて作り、イメージの作成時点でのソースコードもきちんと残す。
#### docker composeなどを用いて、巨大なアプリは複数のイメージ、コンテナに分散指せる。アプリをマイクロサービス化して、保守点検しやすくするのが大事



## Dockerイメージを使いこなす
たとえば、
```docker search python```とすると、Docker Hub上に上がっているレポジトリの検索ができる。discriptionを全て表示する場合には```docker search python --no-trunc```を用いる<br>
```docker search "is-official=true -f "stars=50" python```
とかで、細かい指定ができる。



## Docker file書き方
```docker run -it -p 80:81 debian:buster /bin/bash```
で```debian:buster```を土台とした、コンテナが作れる。このコンテナの中で色々操作したいから```/bin/bash```を入れてる。
最初の```docker run```commandを打った段階で、コンテナの中に入れるので（```-it```commandのおかげ）その中でapt getしたりして、必要なファイルを増やしていくのが、課題を進める大まかな流れになる。<br>
```-p 80:81```はlocalhost:80にアクセスすると、dockerコンテナの内部でポート81に置いて動いているアプリケーションに接続できるという意味になっている。<br>
```apt -y update && upgrade```をしないと、```apt```コマンドが使える形にならない。```debian"busster```や```/bin/bash```の中に入っているバージョンが最新にならず、以降のインストールがうまくいかない。

```apt install -y nginx```でnginxがコンテナの中にinstallできる。
```service nginx start```をしないと、サービスがスタートしない<br>
この状況で、```http://127.0.0.1:80/```にアクセスすると、"Welcome to nginx!"の表示を見ることができ、実際にnginxが堂さしていることを確認できる。<br>

```apt-get install wget```を用いて```wget```commandを使えるようにしないといけない。
```curl```もいない。　<br>
wordpressのためには、mySQLが必要、mySQLのためには、phpMyAdmin(mySQLの操作がwebブラウザ上から可能となる)が必要、そのためには、Nginxが必要みたいな関係性が存在するみたい。

まずこのサイトから```http://repo.mysql.com/```debian:busterの上で動くmysqlを取ってくることを考えた。


ポート番号の指定が大事。

## 使いそうなapt-get options
```-y```;処理中に現れるプロンプトに対して常にyesを返す。<br>
```-q --quiet```;実行時の処理状況の表示を省略<br>
```--no-remobe```;<br>
```update```;インデックスファイルの更新を行う。<br>
```upgrade```;サーバに対してインストールされている全てのパッケージの更新確認を行い、新しいバージョンが存在するパッケージに関しては更新を行う。<br>
```clean``` aptを使用してローカルホストに蓄えられているrpmファイルの削除を行う。rpmファイルとは、多くのLinuxディストリビューションで使用されるバイナリによるソフトウェアのパッケージのこと。(すぐにcleanして問題ないのか？)


```set -ex```があった方がいい場合があるみたいだが、なんで必要になっているのかよくわからん。<br>
コマンドライン直打ちでできることがdocker fileになるとうまくできない。<br>


## config fileの場所について
nginx.confについて：ect/nginx/nginx.confにいる。<br>





rush02のレビューポイント
まず無印のnormを用いる。
次にmakefileのrelink問題に直面する場合にはNOをつける。
何も編集していない時に再度コンパイルされたらダメ。
makefileにはターゲットがある。
ターゲットの隣には、つかうもの（依存ファイル）を書く。
makefileの中では```echo```コマンドなどが使える。

エラーハンドリングで試すのは、
chmod 000のファイルを渡すことなどが考えられる。
メモリリークにおいてNOをつけることはない。

readの読み込み文字数に関してテストを行う。
文字数の制限がある場合には、その文字数をどう処理するかを考える。
read openのエラー処理をしているかをしっかりみる。
存在しないファイル。権限
ナンバーズディクトの中のファイルは変えない。
仮想メモリの概念が存在するので、待つ場合には、
＃define mallocを作ることで、mallocを壊すことができる。

バイナリファイルを読み込む

google の使ってるmalloc  xmallocがあって、メモリの確保に失敗するとexitしてしまう。プログラムを瞬時に終了させる形になっている。


#define SAFE_FREE(ptr) if (ptr != NULL){free(ptr);ptr = NULL}

defineのプリプロセッサ
gcc -E test.cなんかで、実際に、ないにがソースコードにおいて起きているかをみることができる。defineなど。


void ft_leak((destructor))ってのをつかうと、最後に必ず、system("leaks a.out");