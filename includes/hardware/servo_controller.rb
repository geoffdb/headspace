# Impliments a servo-controller on a fairly low level
class ServoController
  attr_reader :port
  
  # Here we mixin the commands
  include ServoControllerCommands
  
  #Constant required to send commands
	CommHeader = "\252\240U"
	
  # If debug is true then all commands will be echoed
  # allong with their arguments
	def initialize(port, debug = false)
		@link = SerialInterface.new(port)
    @debug = debug
    @port = port
  end
	
  private
	
  # This method takes an array of arguments and creates a
  # commandstring, sends it and then returs the reply.
	def send_command(args, return_true_value = false)
		command = args.inject(CommHeader.dup) {|a,b| a + b.chr}
		
    if @debug
      puts args.inspect
      puts command.inspect
    end
		
		@link.send(command)
		
		result = @link.receive
    
    if result == 0 and !return_true_value
      true
    else
      result
    end
  end
end