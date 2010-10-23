# Program to do general tests on the headspace matrix

require 'includes/master'

# Some servos cannot be tested generally
ExcludedServos = Array.new(4) {|x| 64 + 8 + 16 * x} + Array.new(4) {|x| 128 + 64 + 8 + 16 * x}

# Set the excluded servos as inputs
ExcludedServos.each do |servo|
  @grid.set_servos(servo, 1300, 1)
  @grid.set_modes(servo, :input, 1)
end

# Set everything in
@grid.set_servos(0, 1800, 256)

sleep 3

# Start with a test of the rows.
16.times do |row|
  @grid.set_servos(row * 16, 1200, 16)
  sleep 10
  @grid.set_servos(row * 16, 1800, 16)
end

sleep 3

# Now test columns
16.times do |col|
  16.times do |row|
    @grid.set_servos(row * 16 + col, 1200, 1)
  end
  sleep 10
  16.times do |row|
    @grid.set_servos(row * 16 + col, 1800, 1)
  end
end

sleep 5

# Now test excluded servos
ExcludedServos.each do |servo|
  @grid.set_modes(servo, :servo, 1)
  @grid.set_servos(servo, 1200, 1)
  sleep 5
  @grid.set_servos(servo, 1300, 1)
  @grid.set_modes(servo, :input, 1)
end