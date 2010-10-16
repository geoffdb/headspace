# Add the includes director to the load path, so includes
# like "hardware/init.rb" will work.
$: << File.expand_path(File.dirname(__FILE__))

# Require rubygems, bundler, and any required gems
require "rubygems"
require "bundler/setup"

# Bundler will requore all gems inside the Gemfile
Bundler.require(:default)

# Now to require our own libraries.
require "hardware"
require "database"
require "states"