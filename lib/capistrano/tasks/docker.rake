namespace :docker do
  desc 'Build Docker image'
  task :build do
    on roles(:app) do
      within release_path do
        execute :docker, 'build -t anonymous_app_image .'
      end
    end
  end

  desc 'Run Docker container'
  task :run do
    on roles(:app) do
      execute :docker, 'stop your_app_container || true'
      execute :docker, 'rm your_app_container || true'
      execute :docker, 'run -d --name your_app_container -p 80:3000 anonymous_app_image'
    end
  end
end

after 'deploy:publishing', 'docker:build'
after 'docker:build', 'docker:run'
