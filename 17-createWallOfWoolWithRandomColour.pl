#!/usr/bin/env perl

use strict;
use Time::HiRes;
#import the needed modules for communication with minecraft world
use lib 'mcpi';
use Minecraft;
use Block 'WOOL';
use BlockData;
use warnings;

# create a function to create a random block of wool
sub getWoolBlockWithRandomColour{
    #Generate a random number within the allowed range of colours 0-15
    # Random num generator is automatically seeded with srand() by perl on first call
    my $randomNumber = int(rand(16));
    print("Random number to be used = $randomNumber\n");
    my $block = WOOL->withData($randomNumber);
    return $block;
}


# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

# define the position of the bottom left block of the wall
my $blockXposn = $playerPosition->x + 6;
my $firstColumnX = $blockXposn;
my $blockYposn = $playerPosition->y + 1;
my $blockZposn = $playerPosition->z + 6;
my $halfSecInMicroSec = 500 * 1000;
# Create a wall using nested for loops
foreach(1..6){
    # increase the height of the current row to be built
    $blockYposn += 1;
    $blockXposn = $firstColumnX;
    foreach(1..10){
        #increase the distance along the row that the block is placed at
        $blockXposn += 1;
        print("Creating block at ($blockXposn, $blockYposn, $blockZposn)\n" );
        # Create a block
        $mc->setBlock($blockXposn, $blockYposn, $blockZposn, getWoolBlockWithRandomColour());
        Time::HiRes::usleep($halfSecInMicroSec);
    }
}
