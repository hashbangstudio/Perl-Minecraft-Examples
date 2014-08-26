#!/usr/bin/env perl

use strict;
# We have to import the minecraft api module to do anything in the minecraft world
use lib 'mcpi';
use Minecraft;
use warnings;
    
# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

while(1){
    my @hits = $mc->events->pollBlockHits();
    my $numOfHits = @hits;
   # print("$numOfHits\n");
    if ($numOfHits > 0){
        foreach(@hits){print "$_\n";}
        
    }
    sleep(1)
}
