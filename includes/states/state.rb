class StateServo
  attr_accessor :value
  
  def initialize
    @value = 0
    # Value should be 0 to 100
  end
  
  def inspect
    value
  end
end

class State
  attr_accessor :servos
  
  # Represents the state of the artwork at an instant.
  # Supports math to allow intermedatories to be
  # created easily
  
  # Constants
  GridSize = 16
  
  def initialize
    @servos = Array.new(GridSize ** 2) {StateServo.new}
  end
  
  def self.from_tga(filename)
    # This method is a crude version. Not for production use.
    # No averaging is used here, and the image is downsampled.
    
    state = self.new
    image = Pixels.open_tga(filename)
    data = (0..255).to_a.map do |y|
      image.get_row_rgb(y).map {|x| (x.first.to_f / 2.56).to_i }
    end
    
    data = (0..15).map do |y|
      (0..15).map do |x|
        data[y * 16][x * 16]
      end
    end
    
    puts data.inspect
    
    data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        state.servo(x, y).value = cell
      end
    end
    
    state
  end
  
  def servo(*args)
    if args.size == 1
      @servos[args.first]
    else
      @servos[args[0] + args[1] * GridSize]
    end
  end
  
  def to_a
    @servos.map {|x| x.value}
  end
  
  def +(b)
    a = self.dup
    a.servos.each_with_index do |servo, index|
      a.servos[index].value = a.servos[index].value + b.servos[index].value
    end
    a
  end
  
  def -(b)
    a = self.dup
    a.servos.each_with_index do |servo, index|
      a.servos[index].value = a.servos[index].value - b.servos[index].value
    end
    a
  end
  
  def /(n)
    a = self.dup
    a.servos.each {|servo| servo.value = servo.value / n}
    a
  end
  
  def *(n)
    a = self.dup
    a.servos.each {|servo| servo.value = servo.value * n}
    a
  end
  
  def intermediaries(a, n)
    (1..n).map {|x| a + (((self - a) * x) / n)}
  end
  
  def dup
    a = ArtworkState.new
    a.servos = []
    @servos.each do |servo|
      a.servos << servo.dup
    end
    a
  end
end