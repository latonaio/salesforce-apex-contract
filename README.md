# sf-apex
salesforce sand box 環境で動作する Apex コードを管理します。

## 動作環境
salesforce の CLI の sfdx を使用します。[こちらから](https://developer.salesforce.com/docs/atlas.ja-jp.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm) を参考にインストールしてください。

- OS: Linux, Mac, Windows

- CPU: amd64, arm64
## 使用方法
下記コマンドを実行する事で既存の make コマンドの一覧と説明を出力します。
```
$ make
sf-login             sandbox 環境にログインします。
sf-all-retrieve      全ての Apex code を取得します。
sf-class-retrieve    クラス単位で Apex code を取得します。
sf-all-deploy        全ての Apex code をデプロイします。
sf-class-deploy      クラス単位で Apex code をデプロイします。
```
引数のある make コマンドは、引数なしで叩く事で使用例が出力されます。
```
$ make sf-class-retrieve
Usage: make sf-class-retrieve class=TargetClassName
```

### login
sfdx を使用するに当たって sandbox 環境にログインする必要があります。下記コマンドを実行してログインしてください。
```
$ make sf-login
```

### retrieve
#### 全ての Apex code を取得
下記コマンドを使用する事で sandbox 環境にある Apex コードを取得できます。(コードは `force-app/main/default` に、上書きされます。)
取得範囲は `manifest/package.xml` に記載されています。
```
$ make sf-all-retrieve
```

#### クラス単位での取得
下記コマンドを使用する事で sandbox 環境に ローカルの Apex コードをクラス単位で取得できます。
※ ローカル環境にコードが上書きされるので、注意して使用してください。
取得範囲は `manifest/package.xml` に記載されています。
```
$ make sf-class-deploy class=TargetClassName
```

#### フォルダー単位での取得
```
$ sfdx force:source:deploy -p {folder path}
```

### deploy
#### 全ての Apex code をデプロイ
下記コマンドを使用する事で sandbox 環境に ローカルの Apex コードを deploy できます。
※ ローカル環境のコードがそのまま反映されるので、注意して使用してください。
取得範囲は `manifest/package.xml` に記載されています。
```
$ make sf-all-deploy
```

#### クラス単位でのデプロイ
下記コマンドを使用する事で sandbox 環境に ローカルの Apex コードをクラス単位で deploy できます。
※ ローカル環境のコードがそのまま反映されるので、注意して使用してください。
取得範囲は `manifest/package.xml` に記載されています。
```
$ make sf-class-deploy class=TargetClassName
```

#### フォルダー単位でのデプロイ
```
$ sfdx force:source:deploy -p {folder path}
```

その他 Apex Class 単位でのデプロイなどは、[こちら](https://developer.salesforce.com/docs/atlas.ja-jp.sfdx_dev.meta/sfdx_dev/sfdx_dev_develop_any_org.htm) を参考にしてください
