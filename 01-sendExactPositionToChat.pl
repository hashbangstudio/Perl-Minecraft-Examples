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

# Get the position that the player is currently at
my $playerPosition = $mc->player->getPos();
#format the output so that is one decimal place
my @coords = ($playerPosition->x, $playerPosition->y, $playerPosition->z);
my @posn = map{sprintf("%.1f", $_)}  @coords;

# create the output message as a string
my $message = "You are at (".$posn[0].", ".$posn[1].", ".$posn[2].")";
      
# print to the perl interpreter standard output (terminal  probably)
print($message, "\n");

# send message to the minecraft chat
$mc->postToChat($message);

