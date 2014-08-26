#!/usr/bin/env perl

#Tell perl to use strict mode
use strict;
# Tell perl where to find the minecraft api modules
use lib 'mcpi';
# Require and import the Minecraft module
use Minecraft;
use Block 'DIAMOND_BLOCK';
#Tell perl to print all warnings
use warnings;

sub sendToChatAndConsole{

    my ($minecraft, $message) = @_;
    # print to the perl interpreter standard output (terminal probably)
    print($message,"\n");
    # send message to the minecraft chat
    $minecraft->postToChat($message);
}

#    First thing you do is create a connection to minecraft
#    This is like dialling a phone.
#    It sets up a communication line between your script and the minecraft world

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();


sendToChatAndConsole($mc, "Saving Checkpoint");
#Save a checkpoint for the world state
$mc->saveCheckpoint();

#wait for 2 seconds 
sleep(2);
sendToChatAndConsole($mc, "Building Wall");
# Get the player position
my $playerPosition = $mc->player->getTilePos();

my $wallStartXposn = $playerPosition->x + 6;
my $wallStartYposn = $playerPosition->y + 1;
my $wallZposn      = $playerPosition->z + 6;

my $wallEndXposn = $wallStartXposn + 10;
my $wallEndYposn = $wallStartYposn + 6;

# Create a wall
$mc->setBlocks($wallStartXposn , $wallStartYposn, $wallZposn,
               $wallEndXposn,    $wallEndYposn,   $wallZposn,
               DIAMOND_BLOCK);

#wait for 4 seconds 
sleep(4);

sendToChatAndConsole($mc, "Restoring Checkpoint");
# Set the world back to the state it was in at the last saved checkpoint
$mc->restoreCheckpoint();

sendToChatAndConsole($mc, "Making World unbreakable");
$mc->setting('world_immutable', 1);
#wait for 8 seconds 
sleep(8);
sendToChatAndConsole($mc, "Making World breakable");
$mc->setting('world_immutable', 0);
#wait for 4 seconds 
sleep(4);
#Follow the player
sendToChatAndConsole($mc, "Set Camera to follow the player");
$mc->camera->setFollow();
#wait for 4 seconds 
sleep(4);
sendToChatAndConsole($mc, "Making nametags visible");
$mc->setting('nametags_visible', 1);
#wait for 6 seconds 
sleep(6);
sendToChatAndConsole($mc, "Making nametags invisible");
$mc->setting('nametags_visible', 0);
#wait for 4 seconds 
sleep(4);
sendToChatAndConsole($mc, "Set Camera to normal player first person");
$mc->camera->setNormal();

#wait for 2 seconds 
sleep(2);
sendToChatAndConsole($mc, "Turning off AutoJump");
$mc->player->setting('autojump', 0);

#wait for 8 seconds 
sleep(8);
sendToChatAndConsole($mc, "Turning on AutoJump");
$mc->player->setting('autojump', 1);



