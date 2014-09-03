#!/usr/bin/env perl

use strict;
use Time::HiRes;
use lib 'mcpi';
use Minecraft;
use Block 'DIAMOND_BLOCK', 'GLOWING_OBSIDIAN';
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

my $row = 0;
my $column = 0;
my $halfSecInMicroSec = 500 * 1000;
# Create a wall using nested for loops
foreach ((1..6)){
    # increase the height of the current row to be built
    $blockYposn += 1;
    $blockXposn = $firstColumnX;
    $row = $_;
    foreach((1..10)){
        $column = $_;
        #increase the distance along the row that the block is placed at
        $blockXposn += 1;
        print("Creating block at ($blockXposn, $blockYposn, $blockZposn) \n");
        # Create the block
        if (($row == 3) and ($column == 3)){
            # create the Glowing obsisian block only on 3rd row in 3rd column
            $mc->setBlock($blockXposn, $blockYposn, $blockZposn, GLOWING_OBSIDIAN);
        }else{
            $mc->setBlock($blockXposn, $blockYposn, $blockZposn, DIAMOND_BLOCK);
        }
        #wait for 0.5 seconds
        Time::HiRes::usleep($halfSecInMicroSec);
    }
}
