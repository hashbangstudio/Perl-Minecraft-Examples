use strict;
#import the needed modules
use lib 'mcpi';
use Minecraft;
use Block 'AIR';
use warnings;


# Create a connection to the Minecraft game
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

# Set coordinates (position) for the block that is slightly away from the player
# Note y is the vertical coordinate, x and z the horizontal
my $blockXposn = $playerPosition->x + 1;
my $blockZposn = $playerPosition->z + 1;
# set the y coordinate to be at the height of the world at the (x,z) horisontal coordinate
my $blockYposn = $mc->getHeight($blockXposn, $blockZposn);
my $blockToPlace = AIR;
my $numOfArgs = @ARGV;
if ($numOfArgs == 1 or $numOfArgs == 2) {
    #remove any trailing and starting brackets and split on commas
    my $blockText = $ARGV[0];
    $blockText =~ s/^\(//;
    $blockText =~ s/\)$//;
    my @blockArgs = split("," , $blockText);

    my $blockId = int($blockArgs[0]);
    my $blockData = int($blockArgs[1]);

    $blockToPlace = Block::->new($blockId,$blockData);
    if ($numOfArgs == 2){
        my $coordText = $ARGV[1];
        $coordText =~ s/^\(//;
        $coordText =~ s/\)$//;
        my @coords = split(',', $coordText);
        #print ("using coords = @coords\n");
        #Ensure use integers and not fractional/decimal numbers
        $blockXposn = int($coords[0]);
        $blockYposn = int($coords[1]);
        $blockZposn = int($coords[2]);
    }
}else{
    print("To place block next to player:\n");
    print("Usage : perl script.pl blockId,blockData\n");
    print("To place block at a specific coordinate\n");
    print("Usage : perl script.pl blockId,blockData x,y,z\n");
    print("Expected 1 or 2 aguments but received $numOfArgs\n");
    exit();
}

print ("Placing block at ($blockXposn, $blockYposn, $blockZposn)\n");

$mc->setBlock($blockXposn, $blockYposn, $blockZposn, $blockToPlace);

