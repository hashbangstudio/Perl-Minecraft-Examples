#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
use warnings;

#ARGV is a list of the command line arguments given
my $numOfArguments = @ARGV;

if ($numOfArguments == 2){
    
    
    # Create a connection to Minecraft
    # Any communication with the world must use this object
    my $mc = Minecraft::->create();

    my $playerPos = $mc->player->getTilePos();

    #create a message to send
    my $message = "You are at (".$playerPos->x.", ".$playerPos->y.", ".$playerPos->z.")";
    print $message, "\n";
    # send message to the minecraft chat
    $mc->postToChat($message);
    
    # Set variables for the new position
    my $newXpos = int($ARGV[0]);
    my $newZpos = int($ARGV[1]);
    
    # Set y position to be the height of the world so not in middle of a block
    my $newYpos =  $mc->getHeight($newXpos, $newZpos);

    # Set the position of the player
    $mc->player->setTilePos($newXpos, $newYpos, $newZpos);
    # Get the current position that the player is located at in the world
    $playerPos = $mc->player->getTilePos();
    $message = "You have been moved to  (".$playerPos->x.", ".$playerPos->y.", ".$playerPos->z.")";

    print $message, "\n";
    # send message to the minecraft chat
    $mc->postToChat($message);
}
else{
    print("Expected two values arguments for script, but received ".($numOfArguments)."\n");
    print("Usage: perl script.pl xCoord zCoord\n");
    print("Example usage: perl script.pl 9 -8\n");
    exit();
}

