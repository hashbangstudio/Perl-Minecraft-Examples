#!/usr/bin/env perl

use strict;
# We have to import the minecraft api module to do anything in the minecraft world
use lib 'mcpi';
use Minecraft;
use warnings;

sub printAvailableCameraModes{
    print("Available camera modes are:\n");
    print("normal, follow, fixed\n");
}

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

my $minNumOfParams = 2;
my $numOfParamsGiven = @ARGV;

if ($numOfParamsGiven >= $minNumOfParams){
    my $cameraMode = $ARGV[0];
    print $cameraMode;
    if ($cameraMode eq "follow"){
        $mc->camera->setFollow($ARGV[1]);
    }elsif ($cameraMode eq "normal"){
        $mc->camera->setNormal($ARGV[1]);
    }elsif ($cameraMode eq "fixed"){
        if ($numOfParamsGiven == 4) {
            #should verify arguments are integer coordinates
            $mc->camera->setFixed();
            $mc->camera->setPos($ARGV[1], 
                                $ARGV[2], 
                                $ARGV[3]);
        }else{
                print("insufficient parameters given. ");
                print("Require 4 but got $numOfParamsGiven\n");
        }
    }else{
            print("Unknown camera mode parameter given ", $ARGV[1]);
            printAvailableCameraModes();
    }
}else{
    print("insufficient parameters given");
    print("Require $minNumOfParams, got $numOfParamsGiven\n");
}
