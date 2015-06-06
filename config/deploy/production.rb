set :stage, :production


server "justforeign.com", user: "deployuser", roles: %w{web app db}
# Important! set your branch from git!
set :branch, "master"
set :nginx_server_name, "justforeign.com"

set :nginx_use_spdy, false
set :nginx_ssl_certificate, "justforeign.pem"
set :nginx_ssl_certificate_key, "justforeign.key"

set :nginx_enable_pagespeed, true
set :nginx_pagespeed_enabled_filters, "lazyload_images"

set :unicorn_workers, 2