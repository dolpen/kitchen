sites cookbook
==============

 * letsencryptのcertbotをインストールします


Usage
-----

`acme` を `run_list` に追加してください

```json
{
  "name":"my_web_node",
  "run_list": [
    "recipe[acme]"
  ]
}
```

Author
------
dolpen

