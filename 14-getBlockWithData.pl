use strict;
use lib 'mcpi';
use Minecraft;
use Block 'AIR', 'WOOL';
use BlockData 'getBlockNameFromId', 'colourNameToId';
use warnings;

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft->create();

# Get the current tile/block that the player is located at in the world
my $playerPosition = $mc->player->getTilePos();

my $height = $mc->getHeight($playerPosition->x, $playerPosition->z);
# create the output message as a string
my $message = "Height is $height";

# print to the perl interpreter standard output (terminal probably)
print("$message\n");

# send message to the minecraft chat
$mc->postToChat($message);

# Get the type of block for the highest point in world
# This is done at the horizonal player posn
my $blockAndData = $mc->getBlockWithData($playerPosition->x, $height , $playerPosition->z);

if ($blockAndData->id == AIR->id){
     # Need to do height minus one for this as not flower etc
     $blockAndData = $mc->getBlockWithData($playerPosition->x, $height -1 , $playerPosition->z);
}

my $blockName = getBlockNameFromId($blockAndData->id);
# Add to message, the type of block stood on
$message = "Block is of type ".$blockAndData->id." which is ".$blockName;

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
