# Simple Role Syntax
# ==================
set :rvm_ruby_version, '2.1@stargazer'
server '37.139.20.93', user: 'terminal', roles: [:web, :app, :db]
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "tcp://0.0.0.0:9999"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true

task :load_envs do
  exec "#{shared_path}/env.sh"
end

after "deploy:started", "load_envs"