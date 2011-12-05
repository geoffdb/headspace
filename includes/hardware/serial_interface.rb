class SerialInterface
  def initialize(port, baud = 115200, data = 8, stop = 2)
    @link = SerialPort.new(port)
    @link.baud = baud
    @link.data_bits = data
    @link.stop_bits = stop
    #@link.flow_control = SerialPort::HARD
    @link.read_timeout = 1000
  end
  
  def send(command)
    @link.write(command)
  end
  
  def receive
    @link.getc
  end
end
