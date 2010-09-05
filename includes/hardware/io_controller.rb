class IOController < MatrixController
  # Controlls all IO to do with the servo cards, and possibly any other hardware
  
  def get_pir
    [0, 1, 2, 3].map {|x| read_input(x)}
  end
  
  def led_on(n)
    send_command(n, "set_modes", 78, :on, 1)
  end
  
  def led_off(n)
    send_command(n, "set_modes", 78, :off, 1)
  end
  
  private
  
  def read_input(n)
    send_command(0, "get_input", n + 79)
  end
end