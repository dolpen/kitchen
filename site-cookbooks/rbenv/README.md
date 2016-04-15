rbenv Cookbook
==============

 * rbenv をシステムワイドに導入します
 
Requirements
------------

#### packages

- `git` - https://github.com/chef-cookbooks/git.git

Usage
-----

`rbenv` を `run_list` に追加してください

```json
{
  "name":"my_ap_node",
  "run_list": [
    "recipe[rbenv]"
  ]
}
```

Author
------
dolpen

