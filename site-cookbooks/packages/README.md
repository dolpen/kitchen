Packages Cookbook
==============

 * rbenv をシステムワイドに導入します
 
Requirements
------------

#### packages

- `yum-epel` - https://github.com/opscode-cookbooks/yum-epel.git

Usage
-----

`packages` を `run_list` に追加してください

```json
{
  "name":"my_ap_node",
  "run_list": [
    "recipe[packages]"
  ]
}
```

Author
------
dolpen

