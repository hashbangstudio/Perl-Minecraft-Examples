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

print("Please enter text to send to chat: ");
my $message = <STDIN>;
# print to the perl interpreter standard output (terminal probably)
print($message, "\n");
# send message to the minecraft chat
$mc->postToChat($message);

