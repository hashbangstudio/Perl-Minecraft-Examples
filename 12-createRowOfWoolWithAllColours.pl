use strict;
use lib 'mcpi';
use Minecraft;
use Block 'WOOL';
use warnings;

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Get the player position
my $playerPosition = $mc->player->getTilePos();

# define the position of the bottom left block of the wool row
my $blockXposn   = $playerPosition->x + 6;
my $blockYposn   = $playerPosition->y + 1;
my $blockZposn   = $playerPosition->z + 6;

# for value in the range 0 to 15 inclusive do the enclosed code
foreach((0..15)){
    #increase the distance along the row that the block is placed at
    $blockXposn += 1;
    # $_ is a special variable automatically set by perl
    # it contains the value being used in  the current iteration of the loop
    # in this case the colour of the wool
    print("Creating block with data $_ at ($blockXposn, $blockYposn, $blockZposn)\n");
    # Create a block
    $mc->setBlock($blockXposn, $blockYposn, $blockZposn, WOOL->withData($_));
}
