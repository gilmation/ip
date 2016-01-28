#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#require 'rvm/capistrano'
#require 'bundler/capistrano'

set :application, "ip"

# the ip or name of the domain
set :domain, '79.125.118.188'

# the path to your new deployment directory on the server
# by default, the name of the application (e.g. "/var/www/sites/example.com")
set :deploy_to, "/var/www/sites/#{application}"

set :repository, "git@github.com:gilmation/ip.git"

# the branch you want to clone (default is master)
set :branch, "master"

# the name of the deployment user-account on the server
set :user, "deploy"

# Core Capistrano values
set :current_dir, 'live'

set :scm, :git
set :ssh_options, { :forward_agent => true, :port => 22, :user => 'deploy' }
set :deploy_via, :remote_cache
set :copy_strategy, :checkout
set :keep_releases, 3
set :use_sudo, false
set :copy_compression, :bz2

# Roles
role :app, domain #"#{application}"
role :web, domain #"#{application}"
role :db,  domain, :primary => true #"#{application}", :primary => true

after "deploy", "deploy:create_sym_links", "deploy:remove_non_prod_dirs"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do

  desc "Remove non production directories from the deployed application"
  task :remove_non_prod_dirs, :roles => :app do
    run "rm #{current_release}/config/deploy.rb && rm #{current_release}/Capfile && rm #{current_release}/ip_client.rb && rm #{current_release}/.rvmrc"
  end

  desc "Create any symlinks that we need"
  task :create_sym_links, :roles => :app do
    run "ln -s #{deploy_to}/#{shared_dir}/config/basic.yml #{current_release}/config/basic.yml"
  end

  # Do nothing
  task :restart, :roles => :app, :except => { :no_release => true } do ; end

  desc "Simplified this one to only chmod the latest_release dir"
  task :finalize_update do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
  end

  desc "Output deployment target app"
  task :print_target_app do
    puts "App is [#{application}]"
  end

  #
  # Github style deployment
  #
  desc "Setup a GitHub-style deployment"
  task :setup, :except => { :no_release => true } do
    run "if ! [ -e #{current_path} ]; then git clone #{repository} #{current_path}; fi"
  end

  desc "Update the deployed code"
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git reset --hard; git clean -fd; git pull origin; git reset --hard #{branch}"
  end

  desc "Turn off the symlinking for Github style deployment"
  task :symlink, :except => { :no_release => true } do
    # Do nothing
  end

  desc "Turn off the symlinking for Github style deployment"
  task :create_symlink, :except => { :no_release => true } do
    # Do nothing
  end
end
