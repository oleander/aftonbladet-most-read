# coding: utf-8
require "bundler"
Bundler.setup(:rakefile)

begin
  require "vlad"
  require "vlad/core"
  require "vlad/git"
  
  # Deploy config
  set :repository,   "git@github.com:oleander/aftonbladet-most-read.git"
  set :revision,     "origin/master"
  set :deploy_to,    "/opt/apps/aftonbladet-most-read"
  set :domain,       "webmaster@burken"
  set :mkdirs,       ["."]
  set :skip_scm,     false
  set :shared_paths, {"vendor" => "vendor"}
  
  set :bundle_cmd, "/usr/local/rvm/bin/webmaster_bundle"
  set :god_cmd, "sudo /usr/bin/god"
  
  namespace :vlad do
    desc "Deploys a new revision of webbhallon and reloads it using God"
    task :deploy => ["update", "copy_database", "bundle", "god:reload", "god:restart", "cleanup"]
    
    remote_task :bundle do
      run "cd #{current_release} && #{bundle_cmd} install --without=rakefile,test --deployment"
    end
    
    remote_task :copy_database do
      run "cp -ax #{shared_path}/db/database.sqlite3 #{current_release}/db/"
      run "cp -ax #{shared_path}/config.yml #{current_release}/lib/"
    end
    
    namespace :god do
      remote_task :reload do
        run "#{god_cmd} load #{current_release}/worker.god"
      end
      
      remote_task :restart do
        run "#{god_cmd} restart aftonbladet-most-read"
      end
    end
  end
rescue LoadError => e
  warn "Some gems are missing, run `bundle install`"
  warn e.inspect
end