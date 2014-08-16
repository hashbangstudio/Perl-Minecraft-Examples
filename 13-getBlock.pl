use strict;
use lib 'mcpi';
use Minecraft;
use Block 'AIR';
use BlockData 'getBlockNameFromId';
use warnings;

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft->create();

# Get the current tile/block that the player is located at in the world
my $playerPosition = $mc->player->getTilePos();

my $height = $mc->getHeight($playerPosition->x, $playerPosition->z);
# create the output message as a string
my $message = "Height is $height";

# print to the perl interpreter standard output (terminal probably)
print("$message\n");

# send message to the minecraft chat
$mc->postToChat($message);


# Get the type of block for the highest point in world
# This is done at the horizonal player posn
my $blockIdNum = $mc->getBlock($playerPosition->x, $height , $playerPosition->z);


if ($blockIdNum == AIR->id){
     # Need to do height minus one for this as not flower etc
     $blockIdNum = $mc->getBlock($playerPosition->x, $height -1 , $playerPosition->z);
}

my $blockName = getBlockNameFromId($blockIdNum);
# Add to message, the type of block stood on
$message = "Block is of type $blockIdNum which is $blockName";

# print to the perl interpreter standard output (terminal probably)
print("$message\n");

# send message to the minecraft chat
$mc->postToChat($message);
