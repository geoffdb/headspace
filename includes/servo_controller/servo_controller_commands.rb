module ServoControllerCommands
  
	# Define a few constants
	ServoMode = 25
  InputMode = 23
  
  # Set a port(s) into servo mode.
  def init_servos(first_servo, count)
    set_modes(first_servo, :servo, count)
	end
  
  def set_modes(first_servo, modes, count = 1)
    count = modes.to_a.size unless modes.is_a? Integer or count != 1
		modes = [modes] * count if count > 1 and (modes.is_a? Integer or modes.is_a? Symbol)
		modes = modes.to_a if modes.is_a? Range
    
    raise ArgumentError, "Not enough modes provided", caller if modes.size < count
    
    # Should other modes be implimented?
    modes.map do |mode|
      case mode
      when :servo
        ServoMode
      when :input
        InputMode
      else
        raise ArgumentError, "Mode symbol not supported", caller if mode.is_a? Symbol
      end
    end
    
    modes = modes[0, count]
    send_command([4, first_servo, modes.size] + modes)
    
    true if get_result == 0
  end
  
  def get_mode
    # Not implimented
  end
	
	def set_servos(first_servo, locations, count = 1)
    count = locations.to_a.size unless locations.is_a Integer or count != 1
		locations = [locations] * count if count > 1 and locations.is_a? Integer 
		locations = locations.to_a if locations.is_a? Range
    
    raise ArgumentError, "Not enough locations provided", caller if locations.size < count
    
    locations = locations[0, count]
		send_command([1, first_servo, locations.size * 2] + locations.map {|x| reverse_byte_int(x)})
    
    true if get_result == 0
	end
  
  def get_servo
    # Not implimented, no use to us.
  end
	
	def set_speeds(first_servo, speeds, count = 1)
		speeds = speeds.to_a * count if speeds.is_a? Integer
    speeds = speeds.to_a if speeds.is_a? Range
    
    raise ArgumentError, "Not enough speeds provided", caller if speeds.size < count
    
    speeds = speeds[0, count]
		send_command([3, first_servo, speeds.size] + speeds)
    
    true if get_result == 0
  end
  
  # This is for digital channels, analouge not implimented
  def get_input(channel)
    send_command([8, channel, 0])
    
    get_result
  end
  
  private
  
  def reverse_byte_int(value)
    ReverseByteInteger.new(value)
  end
end