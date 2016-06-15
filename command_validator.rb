# Created: Daniel Swain
# Date: 15/06/2016
# 
# Ruby module that provides methods to validate the inputted commands to the Beefy Robot objects.
# 
# This module is imported in beefy.rb and simulator.rb and allows each beefy robot object to validate the movement commands
# 
# NOTE: simulator.rb will be used to test the performance of the Beefy Robot Simulator by using various commands.txt files 
# to send valid and illegal commands and confirm this file and the Beefy class and CommandValidator modules perform as required.

module CommandValidator
  # Default constants used for the table size and move step size for the simulator.
  TABLE_SIZE = 5
  MOVE_STEP_SIZE = 1

  # Check if the PLACE command for a Beefy object at the given x,y and face direction is valid,
  # i.e. it doesn't place beefy off the table.
  def is_placement_valid?(x_pos, y_pos, face_dir)
    # If any placement is outside the table bounds then return false otherwise the placement puts Beefy on the table
    # in which case lets check if the face_dir for the initial placement is one of NORTH, SOUTH, EAST or WEST
    if x_pos < 0 || x_pos > TABLE_SIZE - 1 || y_pos < 0 || y_pos > TABLE_SIZE - 1
      return false
    else
      # Checking to see if face_dir from the command is one of NORTH, SOUTH, EAST or WEST exactly
      return ["NORTH", "SOUTH", "EAST", "WEST"].include?(face_dir) ? true : false
    end
  end 
  
  # Check if the MOVE command for a Beefy object at the given x,y and face direction will move it off the table
  # x_pos and y_pos are Integers, face_dir a string for the NORTH, SOUTH, EAST, WEST face direction of Beefy
  def is_move_valid?(x_pos, y_pos, face_dir)
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

  # Make the above commands module functions so they can be used without an instance of the Beefy robot (i.e. from simulator.rb)
  module_function :is_placement_valid?, :is_move_valid?
end
