#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
use warnings;

#    First thing you do is create a connection to minecraft
#    This is like dialling a phone.
#    It sets up a communication line between your script and the minecraft world

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

my $playerPos = $mc->player->getTilePos();


my $message = "You are at (".$playerPos->x.", ".$playerPos->z.")";
print $message, "\n";
# send message to the minecraft chat
$mc->postToChat($message);

#Seed the random number generator (set it up)
#This should not be called more than once per process (this script in this case)
srand();

# Set initial values for amount to shift horizontral coordinates by
# rand() creates a number between 0 and number given (defaults to 1 if none given) 
my $xShift = int(rand(21))-10;
my $zShift = int(rand(21))-10;

# Set variables for the new position
my $newXpos = $playerPos->x + $xShift;
my $newZpos = $playerPos->z + $zShift;

# Set y position to be the height of the world so not in middle of a block
my $newYpos =  $mc->getHeight($newXpos, $newZpos);

# Set the position of the player
$mc->player->setTilePos($newXpos, $newYpos, $newZpos);
#$mc->player->setPos($newXpos, $newYpos, $newZpos); # set actual position rather that Tile
$message = "You have been moved to ($newXpos, $newZpos)";

print $message, "\n";
# send message to the minecraft chat
$mc->postToChat($message);

