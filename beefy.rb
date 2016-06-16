# Created: Daniel Swain
# Date: 15/06/2016
# 
# Ruby class representing the Beefy Robot itself.
# 
# Used by simulator.rb to store the robot's position and handle the moves on that robot from the commands.txt file
# 
# FYI, initialising a Beefy object allows the user to manually place, move and report on the position of the Beefy object
# using the public class methods. These methods are used by simulator.rb to validate and parse commands from a text file 
# 
# NOTE: simulator.rb will be used to test the performance of the Beefy Robot Simulator by using various commands.txt files 
# to send valid and illegal commands and confirm this file and the Beefy class perform as required.

# Beefy the robot's class, defining methods for getting the position and face direction and initialising the Robot.
class Beefy
  # Default constants used for the table size and move step size for the simulator.
  TABLE_SIZE = 5
  MOVE_STEP_SIZE = 1

  # Attribute accessors to create getter and setter methods for Beefy's x_pos, y_pos and face_dir (direction)
  attr_accessor :x_pos, :y_pos, :face_dir

  ################ Public class methods ################
  
  # Check if the PLACE command for a Beefy object at the given x,y and face direction is valid,
  # i.e. it doesn't place beefy off the table.
  def self.is_placement_valid?(x_pos, y_pos, face_dir)
    # Temporary variables used to store the x and y coordinates if the input values are correct (i.e. 0, 1, 2, 3 ...)
    x = 0
    y = 0

    # First, check to see if x_pos and y_pos are valid integers or string representations of numbers. I'm assuming that 'zero', 'one', 'two', 'three'... 
    # are all illegal inputs and that number strings have to be inputted as '0','1','2','3'...
    if x_pos.is_a?(Integer) && y_pos.is_a?(Integer)
      x = x_pos
      y = y_pos
    elsif x_pos.match(/^\d+$/) && y_pos.match(/^\d+$/)
      x = x_pos.to_i
      y = y_pos.to_i
    else
      puts "The PLACE command entered, '#{x_pos},#{y_pos},#{face_dir}' did not include valid numbers for the x and y coordinates."
      return false
    end

    # If we get here then we have gotten valid x and y positions in the PLACE command (i.e. they were either '1' or 1).
    # Now, check if any placement is outside the table bounds, if so then return false otherwise the placement puts Beefy on the table
    # in which case lets check if the face_dir for the initial placement is one of NORTH, SOUTH, EAST or WEST
    if x < 0 || y > TABLE_SIZE - 1 || y < 0 || x > TABLE_SIZE - 1
      return false
    else
      # Checking to see if face_dir from the command is one of NORTH, SOUTH, EAST or WEST exactly
      return ["NORTH", "SOUTH", "EAST", "WEST"].include?(face_dir) ? true : false
    end
  end 
  
  # Check if the MOVE command for a Beefy object at the given x,y and face direction will move it off the table
  # x_pos and y_pos are Integers, face_dir a string for the NORTH, SOUTH, EAST, WEST face direction of Beefy
  def self.is_move_valid?(x_pos, y_pos, face_dir)
    # For each face_dir compare the final position after the move with the table boundary, if the move would keep Beefy on
    # the table then return true so Beefy knows it's OK to move in that direction, else return false
    case face_dir
    when "NORTH"
      return y_pos + MOVE_STEP_SIZE < TABLE_SIZE ? true : false
    when "EAST"
      return x_pos + MOVE_STEP_SIZE < TABLE_SIZE ? true : false
    when "SOUTH"
      return y_pos - MOVE_STEP_SIZE >= 0 ? true : false
    when "WEST"
      return x_pos - MOVE_STEP_SIZE >= 0 ? true : false
    else
      # Can't determine the direction Beefy is facing so return false
      return false
    end
  end

  ################ Initializer ################

  # Initialiser method to set the initial position and facing direction for Beefy (using the PLACE x,y,face command)
  def initialize(x_pos = 0, y_pos = 0, face_dir)
    @x_pos = x_pos
    @y_pos = y_pos
    @face_dir = face_dir
  end

  ################ Public Instance Methods ################

  # Perform the place action on Beefy using the provided coordinates and facing direction. Use the public class method
  # is_placement_valid?(x,y,face_dir) to determine if the placement is valid
  def place(x_pos, y_pos, face_dir)
    if self.class.is_placement_valid?(x_pos, y_pos, face_dir)
      @x_pos = x_pos.to_i
      @y_pos = y_pos.to_i
      @face_dir = face_dir
    end
  end
  
  # Perform the move action on Beefy using it's original coordinates and the direction it is facing and checking if the move 
  # would be valid using the public class method is_move_valid?(x,y,face_dir) from the Beefy class
  def move
    if self.class.is_move_valid?(@x_pos, @y_pos, @face_dir)
      case @face_dir
      when "NORTH" then @y_pos += 1
      when "EAST" then @x_pos += 1
      when "SOUTH" then @y_pos -= 1
      when "WEST" then @x_pos -= 1
      end
    end
  end

  # Turn Beefy 90 degrees to the left.
  # Note, we don't need to check if this move is valid as we don't move the robot, just rotate it in place
  def left
    case @face_dir
    when "NORTH" then @face_dir = "WEST"
    when "EAST" then @face_dir = "NORTH"
    when "SOUTH" then @face_dir = "EAST"
    when "WEST" then @face_dir = "SOUTH"
    end
  end

  # Turn Beefy 90 degrees to the right.
  # Note, we don't need to check if this move is valid as we don't move the robot, just rotate it in place
  def right
    case @face_dir
    when "NORTH" then @face_dir = "EAST"
    when "EAST" then @face_dir = "SOUTH"
    when "SOUTH" then @face_dir = "WEST"
    when "WEST" then @face_dir = "NORTH"
    end
  end

  # Alias for the Beefy.to_s method so a manually started Beefy robot can use the Beefy.report command (in case not using the simulator.rb file)
  def report
    return self.to_s
  end

  # Custom to_s method for Beefy to use to report it's position on the table top (using the REPORT command)
  def to_s
    return "#{@x_pos},#{@y_pos},#{@face_dir}"
  end
end
