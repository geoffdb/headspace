require "includes/master"

led_chase

sleep 5

puts "power up"
power_up

# Set everything in
@grid.set_servos(0, 1700, 256)

sleep 3

puts "rows"
# Start with a test of the rows.
16.times do |row|
  @grid.set_servos(row * 16, 1300, 16)
  sleep 0.5
  puts "awake"
  led_chase(0.05)
  @grid.set_servos(row * 16, 1700, 16)
end

sleep 3

puts "cols"
# Now test columns
16.times do |col|
  16.times do |row|
    @grid.set_servos(row * 16 + col, 1300, 1)
  end
  sleep 0.5
  puts "awake"
  led_chase(0.05)
  16.times do |row|
    @grid.set_servos(row * 16 + col, 1700, 1)
  end
end

sleep 3
led_chase

# Set everything in
puts "retract"
@grid.set_servos(0, 1800, 256)

# 10 secs chaos
puts "chaos"
time = 0
while time < 10
  wait = rand * 1.5
  time += wait
  sleep wait
  256.times do |q|
    @grid.set_servos(q, (rand > 0.5) ? 1200 : 1800, 1) if (rand > 0.7)
  end
end

puts "face"
state = State.from_tga("faces/group2028.tga")
@grid.load_state(state)
sleep 4.5

puts "power down"
power_down

first = true

maxwait = 200
minwait = 10

while true
  led_chase
  
  if !first
    if (rand > 0.4)
    # Faces
      puts "face"
      face = Dir.glob("faces/*").random_element
      state = State.from_tga(face)
      power_up
      @grid.load_state(state)
      sleep 4.5
    else
      # 10 secs chaos
      puts "chaos"
      time = 0
      power_up
      while time < 10
        wait = rand * 1.5
        time += wait
        sleep wait
        256.times do |q|
          @grid.set_servos(q, (rand > 0.5) ? 1200 : 1800, 1) if (rand > 0.7)
        end
      end
    end
  else
    first = false
  end
    
  puts "power down"
  power_down
  
  wait = ((maxwait - minwait) * rand) + minwait
  puts "sleeping for #{wait}"
  
  t = 0
  while t < wait
    sleep 1
    t += 1
    puts "waited for #{t} secconds, #{wait - t} remaining"
    puts "PIRs are #{@io.get_pir.inspect}"
    led_chase if (t % 4 == 0)
  end
    
  puts "awake"
  
  while @io.get_pir != [255, 255, 255, 255]
    puts @io.get_pir.inspect
    led_chase
    sleep 4
  end
  
  if (maxwait < 4 * 60 * 60) && false
    maxwait *= 2
    minwait *= 2
  end
end