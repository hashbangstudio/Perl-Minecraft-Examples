#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
# Require and import the Block module 
# and the DIAMOND_BLOCK subroutine so calls can be directly made to it
use Block 'DIAMOND_BLOCK';
use warnings;

# Create a connection to the Minecraft game
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

# define the position of the first block
my $blockXposn = $playerPosition->x + 6;
my $firstColumnX = $blockXposn;
my $blockYposn = $playerPosition->y + 1;
my $blockZposn = $playerPosition->z + 6;

#For all the values (rows) 1,2,3,4,5,6 do the enclosed code block
foreach ((1..6)){
    # increase the height of the current row to be built
    $blockYposn += 1; 
    $blockXposn = $firstColumnX;
    #for all the values (columns) 1,2,3,4,5,6,7,8,9,10 do the enclosed code block
    foreach((1..10)){
        #increase the distance along the row that the block is placed at
        $blockXposn += 1;
        print("Creating block at ($blockXposn, $blockYposn, $blockZposn)\n");
        # Create a block
        $mc->setBlock($blockXposn, $blockYposn, $blockZposn, DIAMOND_BLOCK);
        # Wait for 0.5 seconds
        sleep(0.5);
    }
}

