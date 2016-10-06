chef_repo_path '.'
cookbook_path [ './cookbooks', './site-cookbooks' ]
role_path      './roles'
data_bag_path  './data-bags'
encrypted_data_bag_secret '.chef/data_bag_key'
ssl_verify_mode :verify_peer

