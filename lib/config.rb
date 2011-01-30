# Prevent configatron from being reinitialized if invoked via the Rakefile.
if not defined?(configatron)
  require 'rakefile'
end

require 'compass'

Compass.add_project_configuration 'compass-config.rb'