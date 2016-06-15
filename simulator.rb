# Created: Daniel Swain
# Date: 15/06/2016
# 
# Ruby file to run the commands for moving a Beefy Robot
# 
# Uses the beefy.rb class file to initialize a Beefy Robot if given a valid PLACE command and a Beefy Robot doesn't exist
# 
# Requires a commands.txt file to run automated commands for the Beefy Robot, otherwise commands can be made directly
# on a Beefy object by initialising a new Beefy object and using the public methods in the Beefy class
# 
# NOTE: This file can be run from a command prompt in the directory with the simulator.rb, beefy.rb, command_validator.rb and commands.txt file
# with `ruby simulator.rb`. This file will be used to test the performance of the Beefy Robot Simulator by using various commands.txt files 
# to send valid and illegal commands and confirm this file and the Beefy class and CommandValidator modules perform as required.

# Require the beefy.rb file to be able on initialise Beefy robots with the simulation commands file
# Require the command_validator.rb file to enable checking if a PLACE command is valid
require_relative "beefy"
require_relative "command_validator"

# Get the directory name from the current simulator.rb file so it can run from any location
dir_name = File.dirname(__FILE__)

# The variable used to store a reference to an eventual Beefy robot. As this is a string, I can check to see if beefy.is_a?(Beefy)
# for my MOVE, LEFT, RIGHT and REPORT commands and only execute them if a valid Beefy object is stored in this variable (i.e.
# a PLACE x,y,face_dir command has been successfully made previously).
beefy = ""

# Use the IO.foreach method to get each line of the commands.txt file rather than File.open(file).each_line or File.readlines(file)
# as the latter two methods open the entire file into memory, whereas IO.foreach only accesses each line at a time
File.foreach(File.join(dir_name, "commands.txt")) do |line|
  # Split the command via the space to get PLACE, MOVE, LEFT, RIGHT or REPORT when checking the first value in the resulting array
  split_command = line.split(" ")

  # Handle the command from the current line in the file
  case split_command.first
  when "PLACE"
    # Try and get the position string from the PLACE x,y,face_dir command
    position_string = split_command.last if split_command.length == 2

    # if we have the position string split via ","
    if position_string
      split_position = position_string.split(",")

      # Get the position from the split_position array
      if split_position.length == 3
        x_pos = split_position[0].to_i
        y_pos = split_position[1].to_i
        face_dir = split_position[2]

        # Check if the place command is valid using the Beefy::CommandValidator.is_placement_valid? methods and if it is initialise a new Beefy object
        if CommandValidator.is_placement_valid?(x_pos, y_pos, face_dir)
          # If our beefy object has already been placed then the beefy variable will be a Beefy object and we need to update it's position, otherwise 
          # place a new Beefy object with the valid x, y and face_dir
          if beefy.is_a?(Beefy)
            beefy.x_pos = x_pos
            beefy.y_pos = y_pos
            beefy.face_dir = face_dir
          else
            beefy = Beefy.new(x_pos, y_pos, face_dir)
          end
        else
          puts "The placement command (#{line}) for the Beefy object was not valid and was ignored."
        end
      else
        # Couldn't correctly split the position command into x, y and face_dir
        puts "Unable to get the x_pos, y_pos and face_direction for Beefy from the following command: #{line}"
      end
    else
      # The initial PLACE command didn't have any x, y and face_dir info as the command was likely just PLACE
      puts "The entered PLACE command was missing the x,y and face_direction part. Ensure your command is formatted 'PLACE x,y,face_direction', you entered: #{line}"
    end

  when "MOVE"
    # Move the Beefy robot, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
    if beefy.is_a?(Beefy)
      beefy.move
    else
      puts "Ignoring the command '#{line}' as no Beefy robot exists yet on the table."
    end

  when "LEFT"
    # Turn the Beefy robot left, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
    if beefy.is_a?(Beefy)
      beefy.left
    else
      puts "Ignoring the command '#{line}' as no Beefy robot exists yet on the table."
    end

  when "RIGHT"
    # Turn the Beefy robot right, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
    if beefy.is_a?(Beefy)
      beefy.right
    else
      puts "Ignoring the command '#{line}' as no Beefy robot exists yet on the table."
    end

  when "REPORT"
    # Report the position of the Beefy robot, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
    if beefy.is_a?(Beefy)
      puts beefy.to_s
    else
      puts "Ignoring the command '#{line}' as no Beefy robot exists yet on the table."
    end

  else
    # Unable to match the command to the required 'PLACE x,y,DIR' , 'MOVE', 'LEFT', 'RIGHT' or 'REPORT' commands.
    puts "Ignoring the command '#{line}' as it isn't a valid 'PLACE x,y,DIR' , 'MOVE', 'LEFT', 'RIGHT' or 'REPORT' command."
  end
end
