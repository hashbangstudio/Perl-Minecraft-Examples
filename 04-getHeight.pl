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

# Set default values for horizontral coordinates
my $xPos = 0;
my $zPos = 0;

# Check that have the appropriate number of command line arguments
#ARGV is a list of the command line arguments given
# It is zero indexed (the first element is at index 0)
my $numOfArguments = @ARGV;
    
if ($numOfArguments == 2){
   $xPos = int($ARGV[0]);
   $zPos = int($ARGV[1]);
}
elsif ($numOfArguments == 0){
   #just use the player position
   my $playerPos = $mc->player->getTilePos();
   $xPos = $playerPos->x;
   $zPos = $playerPos->z;
}
else{
    print("Expected either none or two values as arguments for script, but received ".($numOfArguments)."\n");
    exit();
}

my $height = $mc->getHeight($xPos, $zPos);
my $message = "Height of world is $height at ($xPos, $zPos)";
print "\n$message\n";
# send message to the minecraft chat
$mc->postToChat($message);

