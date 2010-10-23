require 'includes/master'

x = @com.servo_interfaces.last

x.set_servos(1, 1800, 64)

[33, 41, 49, 57].each do |s|
  x.set_modes(s, :input, 1)
end

8.times do |q|
  sleep 1
  x.set_servos(q * 8 + 1, 1200, 8)
  sleep 3
  x.set_servos(q * 8 + 1, 1800, 8)
end

8.times do |q|
  sleep 1
  8.times do |w|
    x.set_servos(q + 8 * w + 1, 1200, 1)
  end
  sleep 3
  8.times do |w|
    x.set_servos(q + 8 * w + 1, 1800, 1)
  end
end

sleep 5

x.set_servos(1, 1800, 64)