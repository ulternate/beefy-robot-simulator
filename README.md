# beefy-robot-simulator
Solution and test files for the Beefy Robot Simulator task

## Instructions

#### Using simulator.rb
To run the simulator open a command prompt or terminal from the directory containing **beefy.rb**, **commands.txt** and **simulator.rb** and use `ruby simulator.rb`

The available commands for **commands.txt** are:

```txt
PLACE x,y,face_dir	= Place the robot a x,y on the table facing in the direction of face_dir (NORTH, SOUTH, EAST or WEST only)
MOVE = move the robot 1 step in the direction it is facing
LEFT = Rotate 90 degrees to the left
RIGHT = Rotate 90 degrees to the right
REPORT = Report the position of the robot on the table
```

There can only be one command per line

An example **commands.txt** file is below:

```txt
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```

It's expected output is `3,3,NORTH`

#### Manually
Beefy can also be run manually in **irb** by opening **irb** in the same directory as above and importing **beefy.rb** using

```ruby
# Import beefy.rb from the directory (assuming irb is opened when CD'd into the directory)
require './beefy.rb'

# a Beefy object can be initiated using
beefy = Beefy.new(1,2,"EAST")

# Each Beefy object has the following commands available
beefy.place(x,y,face_dir) # Place Beefy in a new location on the table
beefy.move # Move Beefy 1 step in the direction it is facing
beefy.left # Rotate 90 degrees to the left
beefy.right # Rotate 90 degrees to the right
beefy.report # Report the position on the table of Beefy
```
