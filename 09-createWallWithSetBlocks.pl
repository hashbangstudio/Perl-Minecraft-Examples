use strict;
use lib 'mcpi';
use Minecraft;
use Block 'DIAMOND_BLOCK';
use warnings;

#    First thing you do is create a connection to minecraft
#    This is like dialling a phone.
#    It sets up a communication line between your script and the minecraft world

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

my $wallStartXposn = $playerPosition->x + 6;
my $wallStartYposn = $playerPosition->y + 1;
my $wallZposn      = $playerPosition->z + 6;

my $wallEndXposn = $wallStartXposn + 10;
my $wallEndYposn = $wallStartYposn + 6;

# Create a wall
$mc->setBlocks($wallStartXposn , $wallStartYposn, $wallZposn,
               $wallEndXposn,    $wallEndYposn,   $wallZposn,
               DIAMOND_BLOCK);
               
