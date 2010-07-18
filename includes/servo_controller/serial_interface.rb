require 'rubygems'
require 'serialport'

class SerialInterface
  def initialize(port, baud = 115200, data = 8, stop = 2)
    @link = SerialPort.new(port)
    @link.baud = baud
    @link.data_bits = data
    @link.stop_bits = stop
  end
  
  def send(command)
    @link.write(command)
  end
  
  def receive
    @link.get_c
  end
end