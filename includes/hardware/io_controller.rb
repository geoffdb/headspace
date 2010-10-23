class IOController < MatrixController
  # Controlls all IO to do with the servo cards, and possibly any other hardware
  
  def get_pir
    [0, 1, 2, 3].map {|x| read_input(x)}
  end
  
  def led_on(n)
    send_command(n, "set_modes", [76, :on, 1])
  end
  
  def led_off(n)
    send_command(n, "set_modes", [76, :off, 1])
  end
  
  def led_blink(n, time = 0.1)
    Thread.new do
      led_on(n)
      sleep time
      led_off(n)
    end
  end
  
  def relay_on(n)
    send_command(n, "set_modes", [74, :on, 1])
  end
  
  def relay_off(n)
    send_command(n, "set_modes", [74, :off, 1])
  end
  
  private
  
  def read_input(n)
    send_command(1, "get_input", [n + 77])
  end
end