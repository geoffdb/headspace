class MatrixController
  QuadrantMappings = [{}, {}, {}, {}]
  
  # To help generating the mappings
  GridSize = 16
  QuadrantSize = 8
  
  # Generate the contents of QuadrantMappings
  8.times do |y|
    8.times do |x|
      QuadrantMappings[0][GridSize * y + x] = QuadrantSize * y + x
      QuadrantMappings[1][GridSize * y + (x + QuadrantSize)] = QuadrantSize * y + x
      QuadrantMappings[2][GridSize * (y + QuadrantSize) + x] = QuadrantSize * y + x
      QuadrantMappings[3][GridSize * (y + QuadrantSize) + (x + QuadrantSize)] = QuadrantSize * y + x 
    end
  end
  
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
      QuadrantMappings.each_with_index do |mapping, index|
        if mapping.keys.include? servo
          # +1 handles the boards prefered indexing
          quadrants[index] << mapping[servo] + 1
        end
      end
    end
    quadrants
  end
end





