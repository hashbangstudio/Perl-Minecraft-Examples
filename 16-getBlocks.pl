use strict;
# We have to import the minecraft api module to do anything in the minecraft world
use lib 'mcpi';
use Minecraft;
use Block ;
use BlockData ;
use warnings;
#
#             NOTE THAT THE getBlocks() FUNCTION IS BUGGED IN THE API
#             THIS EXAMPLE WILL NOT WORK
#

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the current tile/block that the player is located at in the world
my $playerPosition = $mc->player->getTilePos();

my $height = $mc->getHeight($playerPosition->x, $playerPosition->z);
# create the output message as a string
my $message = " height is $height";

# Get the type of block for the highest point in world at horiz player posn
my $blocksInCuboid = $mc->getBlocks($playerPosition->x, $height, $playerPosition->z, 
                              $playerPosition->x + 10, $height, $playerPosition->z + 10);

print($blocksInCuboid);

# print to the perl interpreter standard output (terminal probably)
print($message);

# send message to the minecraft chat
$mc->postToChat($message);
