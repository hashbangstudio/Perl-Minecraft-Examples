use strict;
use lib 'mcpi';
use Minecraft;
# Require and import the Block module 
# and the DIAMOND_BLOCK subroutine so calls can be directly made to it
use Block 'DIAMOND_BLOCK';
use warnings;

#    First thing you do is create a connection to minecraft
#    This is like dialling a phone.
#    It sets up a communication line between your script and the minecraft world

# Any communication with the world must use this object
# Create a connection to the Minecraft game
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

# define the position of the block
my $blockXposn = $playerPosition->x + 1;
my $blockYposn = $playerPosition->y + 1;
my $blockZposn = $playerPosition->z + 1;


my $message = "Creating block at ($blockXposn, $blockYposn, $blockZposn)\n";

print($message);
# Create a block
$mc->setBlock($blockXposn, $blockYposn, $blockZposn, DIAMOND_BLOCK);

