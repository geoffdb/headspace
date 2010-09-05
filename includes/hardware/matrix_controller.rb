class MatrixController
  QuadrantRanges = [0..63, 64..127, 128..191, 192..255]
  
  def initialize(interfaces)
    @interfaces = interfaces
  end
  
  def send_command(interface, command, args)
    # Using the __send__ method incase the interface impliments its own send method
    @interfaces[interface].__send__(command, *args)
  end
  
  # Handles a number 0..255, and returns book-style quadrant, 0..3.
  def quadrant(n)
    if n % 16 > 7
      # We're on the right
      if (n / 16) > 7
        # At the bottom
        return 3
      else
        return 1
      end
    else
      # On the left
      if (n / 16) > 7
        return 2
      else
        return 0
      end
    end
  end
  
  # Maps a array of internal servo ids to an array of board ids per quadrant
  # 0..255 => 1..64 + 1..64 + 1..64 + 1..64
  def map_servos(servos)
    quadrants = [[], [], [], []]
    servos.each do |servo|
      QuadrantRanges.each_with_index do |range, index|
        if range.include? servo
          # +1 handles the boards prefered indexing
          quadrants[index] << (servo + 1) - index * 64
        end
      end
    end
    quadrants
  end
end





