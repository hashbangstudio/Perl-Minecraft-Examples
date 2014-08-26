#!/usr/bin/env perl

use strict;
# We have to import the minecraft api module to do anything in the minecraft world
use lib 'mcpi';
use Minecraft;
use Switch;
use warnings;

sub printAvailableCameraModes{
    print("Available camera modes are:\n");
    print("normal, follow, fixed\n");
}

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

my $minNumOfParams = 1;
my $numOfParamsGiven = @ARGV;

if ($numOfParamsGiven >= $minNumOfParams){

    my $cameraMode = $ARGV[0];
    print $cameraMode."\n";
    switch ($cameraMode) {
        case "follow" {
            if ($numOfParamsGiven == 1) {
                $mc->camera->setFollow();
            }elsif ($numOfParamsGiven == 2) {
                $mc->camera->setFollow($ARGV[1]);
            }else{
                print "Expected 1 or 2 parameters but got $numOfParamsGiven"
            }
        }
        case "normal" {
            if ($numOfParamsGiven == 1) {
                $mc->camera->setNormal();
            }elsif ($numOfParamsGiven == 2) {
                $mc->camera->setNormal($ARGV[1]);
            }else{
                print "Expected 1 or 2 parameters but got $numOfParamsGiven"
            }
        }
        case "fixed" {
            if ($numOfParamsGiven == 4) {
                #should verify arguments are integer coordinates
                $mc->camera->setFixed();
                $mc->camera->setPos($ARGV[1], 
                                    $ARGV[2], 
                                    $ARGV[3]);
            }else{
                print("insufficient parameters given. ");
                print("Require 4 but got $numOfParamsGiven\n");
                exit();
            }
        }
        else {
            print("Unknown camera mode parameter given ", $ARGV[0]);
            printAvailableCameraModes();
            exit();
        }
    }
}else{
    print("insufficient parameters given");
    print("Require minimum of $minNumOfParams, got $numOfParamsGiven\n");
    exit();
}
