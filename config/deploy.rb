set :application, "foreignernetwork"

set :log_level, :info

set :scm, :git
# important! https, not ssh
set :repo_url,  "https://github.com/KonstantinSmirnov/foreignernetwork.git"
set :deploy_to, "/var/www/foreignernetwork"
set :user, "deployuser"
set :keep_releases, 5

set :ssh_options, {
  forward_agent: true,
  # important! your current ssh port
  port: 12531
}

set :rbenv_type, :system
#important! change to your current version
set :rbenv_ruby, '2.2.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)}
RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

#set :rbenv_custom_path, '/usr/local/rbenv/bin/rbenv'
#set :use_sudo, true

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :linked_files, %w{.env}
set :linked_dirs, %w{bin log tmp public/assets public/sites public/system}

set :file_permissions_roles, :all
set :file_permissions_paths, ["/usr/local/rbenv"]
set :file_permissions_users, ["deployuser"]
set :file_permissions_chmod_mode, "0770"

after "deploy:updated", "deploy:set_permissions:chmod"

task :finalize_update, :except => {:no_release => true} do
  run <<-CMD
    ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
  CMD
end
