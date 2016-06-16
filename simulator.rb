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
require_relative "beefy"

# Get the directory name from the current simulator.rb file so it can run from any location
dir_name = File.dirname(__FILE__)

# The variable used to store a reference to an eventual Beefy robot. As this is a string, I can check to see if beefy.is_a?(Beefy)
# for my MOVE, LEFT, RIGHT and REPORT commands and only execute them if a valid Beefy object is stored in this variable (i.e.
# a PLACE x,y,face_dir command has been successfully made previously).
beefy = ""

# Check if the commands text file exists in the directory with the simulator, otherwise warn the user.
if File.file?(File.join(dir_name, "commands.txt"))
  # Use the IO.foreach method to get each line of the commands.txt file rather than File.open(file).each_line or File.readlines(file)
  # as the latter two methods open the entire file into memory, whereas IO.foreach only accesses each line at a time
  File.foreach(File.join(dir_name, "commands.txt")) do |line|
    # Remove all carriage return characters from the line (i.e. \n \r)
    command = line.gsub(/\r|\n/,"")
    # Split the command via the space to get PLACE, MOVE, LEFT, RIGHT or REPORT when checking the first value in the resulting array
    split_command = command.split(" ")

    # Handle the command from the current line in the file (Note, if we want to enable PLACE, place, or any mixed case command we can
    # add '.upcase' to the end of 'split_command.first' to convert the command string from place to PLACE, as it is now place will 
    # result in a warning message saying the command was ignored).
    case split_command.first
    when "PLACE"
      # Try and get the position string from the PLACE x,y,face_dir command
      position_string = split_command.last if split_command.length == 2

      # if we have the position string split via ","
      if position_string
        split_position = position_string.split(",")

        # Get the position from the split_position array
        if split_position.length == 3
          # The Beefy.is_placement_valid? method will check if the x,y coordinates are valid numbers and that the face_dir is
          # one of NORTH, SOUTH, EAST, WEST. So I am not checking their type here
          x_pos = split_position[0]
          y_pos = split_position[1]
          face_dir = split_position[2]

          # If our beefy object has already been placed then the beefy variable will be a Beefy object and we need to update it's position, otherwise
          # check for a valid placement and try and place a new Beefy object with the x, y and face_dir provided.
          if beefy.is_a?(Beefy)
            # The Beefy.place method calls the Beefy.is_placement_valid? method to check the validity of the potential placement (checking input type and
            # face direction for approved values)
            beefy.place(x_pos, y_pos, face_dir)
          else
            if Beefy.is_placement_valid?(x_pos, y_pos, face_dir)
              # As the placement is valid then x_pos and y_pos are correctly inputted numbers (or string representations i.e. "1") and the face_dir is correct
              # so initiate a new beefy object with the provided x_pos, y_pos (as integers) and face_dir
              beefy = Beefy.new(x_pos.to_i, y_pos.to_i, face_dir)
            end
          end
        else
          # Couldn't correctly split the position command into x, y and face_dir
          puts "Unable to get the x_pos, y_pos and face_direction for Beefy from the following command: #{command}"
        end
      else
        # The initial PLACE command didn't have any x, y and face_dir info as the command was likely just PLACE
        puts "The entered PLACE command was missing the x,y and face_direction or you included spaces between the x,y,face_direction values." \
              "Ensure your command is formatted 'PLACE x,y,face_direction', you entered: #{command}"
      end

    when "MOVE"
      # Move the Beefy robot, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
      if beefy.is_a?(Beefy)
        beefy.move
      end

    when "LEFT"
      # Turn the Beefy robot left, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
      if beefy.is_a?(Beefy)
        beefy.left
      end

    when "RIGHT"
      # Turn the Beefy robot right, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
      if beefy.is_a?(Beefy)
        beefy.right
      end

    when "REPORT"
      # Report the position of the Beefy robot, but only if the beefy variable is a Beefy class object otherwise it hasn't been placed yet so we can ignore this command
      if beefy.is_a?(Beefy)
        puts beefy.to_s
      end

    else
      # Unable to match the command to the required 'PLACE x,y,DIR' , 'MOVE', 'LEFT', 'RIGHT' or 'REPORT' commands.
      puts "Ignoring the command '#{command}' as it isn't a valid 'PLACE x,y,DIR' , 'MOVE', 'LEFT', 'RIGHT' or 'REPORT' command."
    end
  end
else
  puts "No 'commands.txt' file located in the directory.\nPlease use a valid 'commands.txt' file with one line per command or manually" \
        " simulate the Beefy robot using a new Beefy class object."
end
