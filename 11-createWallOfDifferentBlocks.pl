#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
use Block;
use warnings;

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

# define the position of the bottom left block of the wall
my $blockXposn   = $playerPosition->x + 6;
my $firstColumnX = $blockXposn;
my $blockYposn   = $playerPosition->y + 1;
my $blockZposn   = $playerPosition->z + 6;

# id of block to create
my $id = 0;

# Create a wall using nested for loops
foreach ((1..6)){
    # increase the height of the current row to be built
    $blockYposn += 1;
    $blockXposn = $firstColumnX;
    foreach((1..10)){
        #increase the distance along the row that the block is placed at
        $blockXposn += 1;
        print("Creating block with id = $id at ($blockXposn, $blockYposn, $blockZposn)\n");
        # Create a block
        # If the id doesn't exist in the Minecraft world
        # The message will still be sent but no block will be created
        $mc->setBlock($blockXposn, $blockYposn, $blockZposn, Block::->new($id));
        # Wait for 0.5 seconds
        sleep(0.5);
        # increment the id of the block to create
        $id += 1;
    }
}
