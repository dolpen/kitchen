sites cookbook
==============

 * nginx を yum でインストール(ユーザー/グループを作ります)
 * ログ配置先を作成し、パーミッションを設定します
 * nginx.conf をテンプレートから作成し、配置します


Usage
-----

`nginx` を `run_list` に追加してください

```json
{
  "name":"my_ap_node",
  "run_list": [
    "recipe[nginx]"
  ]
}
```

Author
------
dolpen

