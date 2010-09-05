class ServoGridController
  # Controlls the entire grid.
  
  class ServoState
    attr_accessor :position, :speed
  end
  
  def initialize(interfaces)
    @interfaces = interfaces
  end
  
  # Servos are numbered 0..255, book style.
  # Mapped to 0..63 on each interface
  # Inputs are numbered 0..15, 0..3 on interface 1, 4..7 on 2 etc.
  # Inputs are mapped to ports 73..76
  # Outputs are numbered 0..15, as with inputs
  # Mapped to ports 77..80
  
  
  
  private
  
  def send_command(interface, command, args)
    @interfaces[interfaces]
  end
  
  def quadrant(n)
    if n % 16 > 7
      # We're on the right
      if (n / 16) > 7
        # At the bottom
        return 4
      else
        return 2
      end
    else
      # On the left
      if (n / 16) > 7
        return 3
      else
        return 1
      end
    end
  end
end