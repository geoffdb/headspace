# Add the includes director to the load path, so includes
# like "hardware/init.rb" will work.
$: << File.expand_path(File.dirname(__FILE__))

# Require rubygems, bundler, and any required gems
require "rubygems"
require "bundler/setup"

# Bundler will requore all gems inside the Gemfile
Bundler.require(:default)

# Now to require our own libraries.

# ========
# Hardware
# ========

# Smooths out the serial interface, and sets up the link
require "hardware/serial_interface"

# Impliments low level servo-controller controll
require "hardware/servo_controller_commands"
require "hardware/servo_controller"

# Deals with finding an identifying the servo controllers
require "hardware/interface_manager"

# Combines the servo controllers into a grid, uses MatrixController
require "hardware/grid_controller"

# IO controller, seperates IO controll from servo, uses MatrixController
# TODO: Currently an empty class.
require "hardware/io_controller"

# Initialize the hardware
require "hardware/init"