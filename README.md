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


### docker helpについて
```docker container help```でcontainerカテゴリーのhelpを見ることができる。
```docker contaier run --help```で```docker contaier run```のhelpを見ることができる。
