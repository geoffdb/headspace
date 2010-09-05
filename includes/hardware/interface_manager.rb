# This file probes all ttyUSB devices found and then
# creates new SercoController interfaces. It then uses
# data from the hardware to assign IDs

class InterfaceManager
  attr_reader :servo_interfaces
  
  # Constants first
  SearchPath = "/dev/ttyUSB*"
  
  IdInputs = [83, 84]
  
  def initialize(debug = false)
    # Find all usb serial interfaces
    interfaces = Dir.glob(SearchPath)
    
    # For each interface add it to the list
    # of interfaces
    @servo_interfaces = []
    
    interfaces.each do |port|
      interface = ServoController.new(port, debug)
      
      # Get the details of the id ports
      id = IdInputs.map {|x| interface.get_input(x)}.map {|x| x / 255}.inject(0) {|code, data| code * 2 + data }
      
      @servo_interfaces[id] = interface
    end
  end
end