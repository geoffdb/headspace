class ServoGridController < MatrixController
  # Controlls the entire grid.
  
  class ServoState
    attr_accessor :position, :speed
  end
  
  # Servos are numbered 0..255, book style.
  # Mapped to 0..63 on each interface
  
  def method_missing(method, *args)
    if args.size == 1
      # One argrument, very little work to do here.
      if args.first.is_a? Array
        quads = map_servos(args.first)
        quads.each_with_index do |servos, index|
          if !servos.empty?
            send_command(index, method, [servos])
          end
        end
      else
        # Must just be an int
        quads = map_servos([args.first])
        quads.each_with_index do |servos, index|
          if !servos.empty?
            send_command(index, method, [servos.first])
          end
        end
      end
    elsif args.size == 2
      # Args are [start_servo, count]
      # We need to extract this into an array of ids
      quads = map_servos(Array.new(args.last) {|x| x + args.first})
      quads.each_with_index do |servos, index|
          if !servos.empty?
            # Extract back into a start and count
            send_command(index, method, [servos.first, servos.size])
          end
        end
      end
    else
      # Three arguments
      # [start, details, count]
      if details.is_a? Integer || details.is_a? Symbol
        # This is easy to handle, a bit like for two arguments
        quads = map_servos(Array.new(args.last) {|x| x + args.first})
        quads.each_with_index do |servos, index|
            if !servos.empty?
              # Extract back into a start and count
              send_command(index, method, [servos.first, args[1], servos.size])
            end
          end
        end
      else
        # Bit tricker, details is an array, we need to seperate it with the ids
        quads = map_servos(Array.new(args.last) {|x| x + args.first})
        # Match each servo id with its detail
        quads.map! {|x| x.map {|y| [y, args[1].shift]}}
        quads.each_with_index do |servos, index|
            if !servos.empty?
              # Extract back into a start and count
              send_command(index, method, [servos.first.first, servos[1].map {|x| x.last}, servos.size])
            end
          end
        end
      end
    end
  end
  
  private
  
  
end