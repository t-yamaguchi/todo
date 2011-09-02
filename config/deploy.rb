require "bundler/capistrano"
require 'capistrano_colors'

set :application, "todo"
set :repository,  "git@github.com:t-yamaguchi/todo.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.70.62"                          # Your HTTP server, Apache/etc
role :app, "192.168.70.62"                          # Your HTTP server, Apache/etc
role :db, "192.168.70.62", :primary => true                          # Your HTTP server, Apache/etc

set :use_sudo, false
set :deploy_to, "/var/webapps/#{application}"
set :branch, "v0.0.1"

set :bundle_dir, fetch(:shared_path)+"/bundle"

set :user do
  Capistrano::CLI.ui.ask "production user : "
end
set :scm_user do
  Capistrano::CLI.ui.ask "github.com user : "
end
set :scm_passphrase do
  Capistrano::CLI.ui.ask "github.com passphrase : "
end
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
