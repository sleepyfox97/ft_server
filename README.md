# ft_server
### This repogitory is for my studying about Docker
# 
# 
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