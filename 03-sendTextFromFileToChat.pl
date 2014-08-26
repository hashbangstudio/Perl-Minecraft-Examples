#!/usr/bin/env perl

use strict;
use lib 'mcpi';
use Minecraft;
use warnings;

#    First thing you do is create a connection to minecraft
#    This is like dialling a phone.
#    It sets up a communication line between your script and the minecraft world

# Create a connection to Minecraft
# Any communication with the world must use this object
my $mc = Minecraft::->create();

# Check that have the appropriate number of command line arguments (one in this case)
#ARGV is a list of the command line arguments given
my $numOfArguments = @ARGV;

if ($numOfArguments == 1){
    # create the output message as a string
    my $filename = $ARGV[0];
    open (my $fileHandle, $filename) or die "Failed to open file $filename\n";
    while (my $line = <$fileHandle>){
        # print to the perl interpreter standard output (terminal probably)
        print($line);
        #remove the trailing newline
        chomp($line);
        # send message to the minecraft chat
        $mc->postToChat($line);
    }
    # Close the file we just opened
    close($fileHandle);
} else{
    print("Expected only one string as argument for script, but received $numOfArguments\n");
    exit();
}

