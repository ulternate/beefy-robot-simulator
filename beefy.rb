# Created: Daniel Swain
# Date: 15/06/2016
# 
# Ruby class representing the Beefy Robot itself.
# 
# Used by simulator.rb to store the current position and direction that the robot Beefy is facing.

# Beefy the robot's class, defining methods for getting the position and face direction and initialising the Robot.
class Beefy
	# Attribute accessor to create getter and setter methods for Beefy's x_pos, y_pos and face_dir (direction)
	attr_accessor :x_pos, :y_pos, :face_dir

	# Initialiser method to set the intial position and facing direction for Beefy (using the PLACE x,y,face command)
	def initialize(x_pos, y_pos, face_dir)
		@x_pos = x_pos
		@y_pos = y_pos
		@face_dir = face_dir
	end

	# Custom to_s method for Beefy to use to report it's position on the table tob (using the REPORT command)
	def to_s
		return "#{@x_pos},#{@y_pos},#{@face_dir}"
	end
end
