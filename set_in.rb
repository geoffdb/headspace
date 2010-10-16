$: << File.expand_path(File.dirname(__FILE__) + "/includes")
require "master.rb"

@com.servo_interfaces.each do |interface|
  interface.init_servos(1, 64)
  interface.set_servos(1, 1865, 64)
  8.times do |x|
    interface.set_servos(1, 1100, (x + 1) * 8)
    sleep 5
  end
end
