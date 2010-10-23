# Handy fucntions to be used in artwork controll sequences

def power_up
  4.times {|q| @io.relay_on q}
end

def power_down
  4.times {|q| @io.relay_off q}
end

def led_chase(wait = true, t = 0.1)
  th = Thread.new do
    4.times {|q| @io.led_blink(q, t); sleep (t * 2)}
  end
  while th.status
    sleep 0.01
  end  
end