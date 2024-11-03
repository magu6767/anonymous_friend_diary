# Pumaの設定ファイル
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
bind        ENV.fetch("BIND") { "tcp://0.0.0.0:3000" }
environment ENV.fetch("RAILS_ENV") { "production" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers ENV.fetch("WEB_CONCURRENCY") { 4 }
preload_app!
plugin :tmp_restart
stdout_redirect 'log/puma.stdout.log', 'log/puma.stderr.log', true
worker_timeout 60
prune_bundler
daemonize true
