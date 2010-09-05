# Check if we need to set debug mode, and then load the interfaces
if Object.const_defined? "DEBUG"
  @com = InterfaceManager.new(true)
else
  @com = InterfaceManager.new
end

# Create a new GridController instance
@grid = GridController.new(@com.servo_interfaces)