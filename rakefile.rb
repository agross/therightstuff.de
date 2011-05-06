require 'nanoc3'
require 'nanoc3/cli'
require 'rake/clean'
require 'configatron'
require 'dictionary'
Dir.glob(File.join(File.dirname(__FILE__), 'tools/Rake/*.rb')).each do |f|
  require f
end

task :default => ['generate:site']

namespace :env do
  Rake::EnvTask.new do |env|
    env.configure_from = 'properties.yml'
    env.configure_environments_with = lambda do |env_name|
      configure_env_for env_name
    end
  end
  
  def configure_env_for(env_key)
    env_key = env_key || 'development'

    puts "Loading settings for the '#{env_key}' environment"
    yaml = Configuration.load_yaml 'properties.yml', :hash => env_key, :inherit => :default_to, :override_with => :local_properties
    configatron.configure_from_hash yaml

    if File.exists? 'local-properties.yml'
      puts "Loading local settings from 'local-properties.yml'"
      configatron.configure_from_yaml 'local-properties.yml'
    end

    version_package
    update_paths

    CLEAN.include('msdeploy.log'.in(configatron.dir.build))
    CLEAN.include(configatron.dir.deploy)
    CLEAN.include(configatron.dir.site)
    CLEAN.include(configatron.dir.build)
    
    CLOBBER.include(configatron.dir.tmp)
    CLOBBER.include('**/*.template')
    CLOBBER.exclude('tools')
    # Clean template results.
    CLOBBER.map! do |f|
      next f.ext() if f.pathmap('%x') == '.template'
      f
    end

    configatron.protect_all!

    puts configatron.inspect
  end
  
  def version_package
    configatron.deployment.package = "#{configatron.project}-#{configatron.build.number || '1.0.0.0'}.zip".in(configatron.dir.build)
  end
  
  def update_paths
    configatron.app.base_url += configatron.deployment.base_href
    configatron.deployment.location += configatron.deployment.base_href
  end

  # Load the default environment configuration if no environment is passed on the command line.
  if not Rake.application.options.show_tasks and
     not Rake.application.options.show_prereqs and
     not Rake.application.top_level_tasks.any? do |t|
       /^env:/.match(t)
     end
    Rake::Task['env:development'].invoke
  end
end

namespace :generate do
  desc 'Updates the configuration files for the build'
  task :config do
    FileList.new("**/*.template") \
      .exclude("tools") \
      .each do |template|
      QuickTemplate.new(template).exec(configatron)
    end
  end

  desc 'Generates the site from the templates'
  task :site => :config do
    Nanoc3::CLI::Base.shared_base.run("compile")
  end
end

desc 'Packages the build artifacts'
namespace :package do
  desc 'Prepares the web application for packaging'
  task :webapp => [:clean, 'generate:site'] do
    sourceDir = configatron.dir.site
    webAppFiles = FileList.new() \
          .include("#{sourceDir}/**/*.deploy") \
          .include("#{sourceDir}/**/*.swf") \
          .include("#{sourceDir}/**/*.vcf") \
          .include("#{sourceDir}/**/*.gif") \
          .include("#{sourceDir}/**/*.jpg") \
          .include("#{sourceDir}/**/*.jpeg") \
          .include("#{sourceDir}/**/*.png") \
          .include("#{sourceDir}/**/*.ico") \
          .include("#{sourceDir}/**/*.js") \
          .include("#{sourceDir}/**/*.css") \
          .include("#{sourceDir}/**/*.config") \
          .include("#{sourceDir}/**/*.htm?") \
          .include("#{sourceDir}/**/*.xml")

    webAppFiles.copy_hierarchy \
      :source_dir => sourceDir,
      :target_dir => configatron.dir.deploy.to_absolute
  end

  desc 'Creates a zipped archive for deployment'
  task :zip => [:webapp] do
    sz = SevenZip.new \
      :tool => configatron.tools.zip,
      :zip_name => configatron.deployment.package

    Dir.chdir(configatron.dir.deploy) do
      sz.zip :files => FileList.new("**/*")
    end
  end

  task :all => [:zip]
end

desc 'Deploys the build artifacts to the production system'
task :deploy => ['package:all'] do
  MSDeploy.run \
    :tool => configatron.tools.msdeploy,
    :log_file => configatron.deployment.logfile,
    :verb => :sync,
    :source => Dictionary[:contentPath, configatron.dir.deploy.to_absolute.escape],
    :dest => Dictionary[
      :wmsvc, configatron.deployment.server,
      :contentPath, configatron.deployment.location.escape,
      :username, configatron.deployment.user,
      :password, configatron.deployment.password
    ],
    :usechecksum => true,
    #:allowUntrusted => true,
    :skip => [
      Dictionary[
        :objectName, "filePath",
        :skipAction, "Delete",
        :absolutePath, "App_Offline\.htm$"
      ],
      Dictionary[
        :objectName, "dirPath",
        :skipAction, "Delete",
        :absolutePath, "beta"
      ],
      Dictionary[
        :objectName, "dirPath",
        :skipAction, "Delete",
        :absolutePath, "aspnet_client"
      ]
    ]
end
