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
# to send valid and illegal commands and confirm this file and the Beefy class and CommandValidator modules perform as required.

# Require the command_validator module to gain the validation methods for the Beefy object
# using require_relative to look for the file in the same directory as beefy.rb
require_relative "command_validator"

# Beefy the robot's class, defining methods for getting the position and face direction and initialising the Robot.
class Beefy
  # Include the command_validator module to access the validation mixin(s) for the movements
  include CommandValidator

  # Attribute accessors to create getter and setter methods for Beefy's x_pos, y_pos and face_dir (direction)
  attr_accessor :x_pos, :y_pos, :face_dir

  # Initialiser method to set the initial position and facing direction for Beefy (using the PLACE x,y,face command)
  def initialize(x_pos = 0, y_pos = 0, face_dir)
    @x_pos = x_pos
    @y_pos = y_pos
    @face_dir = face_dir
  end

  # Perform the move action on Beefy using it's original coordinates and the direction it is facing and checking if the move 
  # would be valid using the CommandValidator module function is_move_valid?(x,y,face_dir)
  def move
    if is_move_valid?(@x_pos, @y_pos, @face_dir)
      case @face_dir
      when "NORTH" then @y_pos += 1
      when "EAST" then @x_pos += 1
      when "SOUTH" then @y_pos -= 1
      when "WEST" then @x_pos -= 1
      end
    else
      puts "Ignoring the command to move from #{@x_pos}, #{@y_pos}, #{@face_dir} as I would fall off the table"
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

  # Custom to_s method for Beefy to use to report it's position on the table top (using the REPORT command)
  def to_s
    return "#{@x_pos},#{@y_pos},#{@face_dir}"
  end
end
