Kitchen
==============

所有vpsのレシピまとめです

前提
------------

- Ruby 2.0.0 以上
- Bundler(gem install で入ります)

rbenv を推奨します。
osx の場合は http://www.d-wood.com/blog/2014/03/20_5847.html

導入
----------

#### 準備と依存の解決

- リポジトリを clone します
- clone したディレクトリに入って
```
bundle install --path vendor/bundle
```
- 成功したら
```
bundle exec berks vendor cookbooks
```

#### 対象のサーバーに chef クライアントをインストール

初回に1度だけやっておく必要があります
```
bundle exec knife solo prepare [user@]server_or_ip
```

#### 対象のサーバーに chef レシピを反映

レシピを更新する際にも行います。自動化対象です
```
bundle exec knife solo cook [user@]server_or_ip
```
