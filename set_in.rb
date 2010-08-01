$: << File.expand_path(File.dirname(__FILE__) + "/includes")
require "servo_controller/init.rb"

@interfaces.interfaces.each do |interface|
  interface.init_servos(1, 64)
  interface.set_servos(1, 2000, 64)
end