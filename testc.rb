# Program to do general tests on the headspace matrix

require 'includes/master'

if false
# Some servos cannot be tested generally
ExcludedServos = Array.new(4) {|x| 64 + 8 + 16 * x} + Array.new(4) {|x| 128 + 64 + 8 + 16 * x}

# Set the excluded servos as inputs
ExcludedServos.each do |servo|
  @grid.set_servos(servo, 1300, 1)
  @grid.set_modes(servo, :input, 1)
end
end

# Set everything in
@grid.set_servos(0, 1800, 256)

sleep 3

# Start with a test of the rows.
8.times do |row|
  @grid.set_servos((row) * 16, 1700, 16)
  sleep 10
  @grid.set_servos((row) * 16, 1800, 16)
end

sleep 3

# Now test columns
8.times do |col|
  8.times do |row|
    @grid.set_servos((row) * 16 + col, 1700, 1)
  end
  sleep 10
  8.times do |row|
    @grid.set_servos((row) * 16 + col, 1800, 1)
  end
end

sleep 5

if false
# Now test excluded servos
ExcludedServos.each do |servo|
  @grid.set_modes(servo, :servo, 1)
  @grid.set_servos(servo, 1700, 1)
  sleep 1
  @grid.set_servos(servo, 1300, 1)
  @grid.set_modes(servo, :input, 1)
end
end