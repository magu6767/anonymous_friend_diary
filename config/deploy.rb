# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

set :application, "anonymous_friend_diary"
set :repo_url, "git@github.com:magu6767/anonymous_friend_diary.git"
set :deploy_to, '/var/www/html/anonymous_friend_diary'

set :pty, true
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system storage}
append :linked_dirs, "log", "tmp/pids", "tmp/sockets"

set :rbenv_type, :user
set :rbenv_ruby, '3.0.5'

set :keep_releases, 2

# Puma設定
set :puma_threads, [4, 16]
set :puma_workers, ENV.fetch('WEB_CONCURRENCY') { 4 }
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil

# その他の設定
set :use_sudo, false
set :deploy_via, :remote_cache

set :branch, 'main'

# developmentとtestを除外
set :bundle_without, %w{development test}.join(' ')

namespace :deploy do
  desc 'Upload database.yml and master.key'
  task :upload do
    on roles(:app) do |host|
      execute "mkdir -p #{shared_path}/config"
      upload! 'config/database.yml', "#{shared_path}/config/database.yml"
      upload! 'config/master.key', "#{shared_path}/config/master.key"
    end
  end
end