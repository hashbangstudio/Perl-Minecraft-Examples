#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
use warnings;

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

my @allIds = $mc->getPlayerEntityIds();
my $message = "";
# create the output message as a string
foreach my $id (@allIds){
    $message = "id is $id";
    # print to the perl interpreter standard output (terminal probably)
    print($message);
    # send message to the minecraft chat
    $mc->postToChat($message);
}
