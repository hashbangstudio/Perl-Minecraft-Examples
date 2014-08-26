#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
use Block 'WOOL';
use BlockData 'getBlockNameFromId', 'colourNameToId';
use warnings;


# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft->create();

my $xPos = 0;
my $yPos = 0;
my $zPos = 0;

my $numOfArgs = @ARGV;
if ($numOfArgs == 3){
        $xPos = int($ARGV[0]);
        $yPos = int($ARGV[1]);
        $zPos = int($ARGV[2]);
}elsif($numOfArgs == 2){
     $xPos = int($ARGV[0]);
     $zPos = int($ARGV[1]);
     #Get the block that would be stood on at this Horiz posn
     $yPos = $mc->getHeight($xPos, $zPos) - 1;

}else{
    print("Number of arguments incorrect \n");
    print("Expected 2 or 3 arguments but got $numOfArgs \n");
    print("Usage with 3 args: perl script.pl xcoord ycoord zcoord\n");
    print("Usage with 2 args: perl script.pl xcoord zcoord\n");
    exit();
}

# Get the type of block
# This is done at the passed in coords
my $blockAndData = $mc->getBlockWithData($xPos, $yPos , $zPos);

my $blockName = getBlockNameFromId($blockAndData->id);
# Add to message, the type of block stood on
my $message = "Block is of type ".$blockAndData->id." which is ".$blockName;

# print to the perl interpreter standard output (terminal probably)
print("$message\n");

# send message to the minecraft chat
$mc->postToChat($message);

my $dataMessage = "Block data is ".$blockAndData->data;
print("$dataMessage\n");
$mc->postToChat($dataMessage);

my %colourHash = colourNameToId;
if ($blockAndData->id == WOOL->id){
    print("Is Wool Block - ");
    my @keys = keys(%colourHash);
    foreach (@keys){
        if ($colourHash{$_} == $blockAndData->data){
            my $colMsg = "Colour is $_";
            print("$colMsg\n");
            $mc->postToChat($colMsg);
        }
    } 
}
