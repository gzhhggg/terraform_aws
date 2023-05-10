# 概要
terraformの学習用

# インフラ構成図
![aws_test drawio (2)](https://user-images.githubusercontent.com/93046615/233839082-00025119-2848-448c-9c03-afaf80959ed0.png)

# 確認内容
protectサブネットのEC2にapacheをインストールして画面確認  
ロードバランサーが機能していることの確認  
踏み台サーバーからしかアクセスできないことの確認  
RDSにはプライベートサブネットのインスタンスからしかアクセスできないことの確認  
ドメインは「お名前ドットコム」で購入

# 今後すること
github actionsを使ったterraform plan applyの実行
ecr・ecsを使ってサーバー構築
ci/cdの実装
