require './servo_controller.rb'

# This file probes all ttyUSB devices found and then
# creates new SercoController interfaces. It then uses
# data from the hardware to assign IDs

class InterfaceManager
  attr_reader :interfaces
  
  # Constants first
  SearchPath = "/dev/ttyUSB*"
  
  IdInputs = [83, 84]
  
  def initialize
    # Find all usb serial interfaces
    interfaces = Dir.glob(SearchPath)
    
    # For each interface add it to the list
    # of interfaces
    @interfaces = []
    
    interfaces.each do |port|
      interface = ServoController.new(port)
      
      # Get the details of the id ports
      id = IdInputs.map {|x| interface.get_input(x)}.map {|x| 1 if x}.map {|x| x.to_i}.inject(0) {|code, data| code * 2 + data }
      
      @interfaces[id] = interface
    end
  end
end