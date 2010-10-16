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
      id = IdInputs.map {|x| interface.get_input(x)}.map {|x| (1 - (x / 255)).abs}.inject(0) {|code, data| code * 2 + data }
      
      @servo_interfaces[id] = interface
      
      # Set some defaults on the interface while we are here.
      # Set 1..64 as servos,
      # 78 as output
      @servo_interfaces[id].set_modes(1, :servo, 64)
      @servo_interfaces[id].set_modes(78, :output)
      
      # 79..82 on board 0 as input
      @servo_interfaces[id].set_modes(79, :input, 4) if id == 0
    end
  end
end