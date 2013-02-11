# Add RVM's lib directory to the load path.
#:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.
#require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, '1.9.3p374'
#set :rvm_type, :system  # Don't use system-wide RVM
set :rvm_bin_path, '/usr/local/rvm/bin'
set :rails_env, "development"

set :user, "root"
#set :password, "password"
set :domain, "miguelwicht.com"
set :application, "Letoh"
set :repository,  "git@github.com:miguelwicht/letoh.git"
set :deploy_to, "/var/www/vhosts/miguelwicht.com/letoh"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# set :default_environment, {
#   'PATH' => "#{deploy_to}/bin:$PATH",
#   'GEM_HOME' => "#{deploy_to}/gems"
# }


set :scm, :git
# Or: 'accurev', 'bzr', 'cvs', 'darcs', 'git', 'mercurial', 'perforce', 'subversion' or 'none'

role :web, domain                           # Your HTTP server, Apache/etc
role :app, domain                           # This may be the same as your 'Web' server
role :db,  domain, :primary => true         # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update_code", :bundle_install
desc "Running the bundle install"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end