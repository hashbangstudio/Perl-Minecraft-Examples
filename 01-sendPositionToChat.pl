#!/usr/bin/env perl

#Tell perl to use strict mode
use strict;
# Tell perl where to find the minecraft api modules
use lib 'mcpi';
# Require and import the Minecraft module
use Minecraft;
#Tell perl to print all warnings
use warnings;
 
#    First thing you do is create a connection to minecraft
#    This is like dialling a phone.
#    It sets up a communication line between your script and the minecraft world

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the position of the Tile that the player is currently in
my $playerPosition = $mc->player->getTilePos();

# create the output message as a string
my $message = "You are at (".$playerPosition->x.", ".$playerPosition->y.", ".$playerPosition->z.")";
      
# print to the perl interpreter standard output (terminal probably)
print($message,"\n");

# send message to the minecraft chat
$mc->postToChat($message);

