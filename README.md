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
でコンテナに名前をつけられる。つけないと、適当に名前がつく。<br>

```docker container run --name mynginx -d -p 8081:80 ngix:1.9.15-alpine```<br>
```-d```でコンテナをデーモンとして起動できる（バックグラウンドで実効）<br>

```docker contaier ls```<br>
で現在動いているコンテナの確認
```docker ps```<br>
でも可能

起動しているコンテナは<br>
```docker container stop <container name>```
で停止可能

### docker commandについて
```docker ＜サブコマンド＞　＜操作＞　＜オプション＞```
#### <サブコマンド>
```help, container, image```
#### <操作>
```run, stop, rm, pull, image```
#### <オプション>
```--help, -d, -it, --name```  
