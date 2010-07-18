class ArtworkStateServo
  attr_accessor :value
  
  def initialize
    @value = 0
  end
  
  def inspect
    value
  end
end

class ArtworkState
  attr_accessor :servos
  
  # Represents the state of the artwork at a instant.
  # Supports math to allow intermedatories to be
  # created easily
  
  # Constants
  GridSize = 16
  
  def initialize
    @servos = Array.new(256) {ArtworkStateServo.new}
  end
  
  def servo(*args)
    case args.size
    when 1
      @servos[args.first]
    else
      @servos[args[0] + args[1] * GridSize]
    end
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