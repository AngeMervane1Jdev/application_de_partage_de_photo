# config valid only for current version of Capistrano
lock '3.6.0'

set :application, 'achieve'
set :repo_url, 'https://github.com/AngeMervane1Jdev/application_de_partage_de_photo.git'
set :branch, ENV['BRANCH'] || 'main'
set :deploy_to, '/var/www/achieve'

set :linked_files, %w{.env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}
set :keep_releases, 5
set :rbenv_ruby, '2.6.5'
set :rbenv_type, :system
set :log_level, :info
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['/home/ange/.ssh/id_rsa']

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end
  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end