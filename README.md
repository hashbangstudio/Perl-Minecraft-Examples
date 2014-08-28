Perl-Minecraft-Examples
=======================

A set of examples showing the usage of the Perl API and Minecraft-Pi

To use these examples first you need to have Minecraft installed:

1. Go to http://pi.minecraft.net
2. Click on *Downloads* in the menu bar
3. Click on the download link
  * As of 15th May 2014 the link was:
  * https://s3.amazonaws.com/assets.minecraft.net/pi/minecraft-pi-0.1.1.tar.gz

4. Unzip/Uncompress this file by navigating to it in the *File Manager* and right clicking on it and click on *Extract here*
5. Go into the newly created folder *mcpi*
6. Double click on the file *minecraft-pi* and choose *Execute*
7. This will have opened up Minecraft, you need to start a game and create a new world

Now that Minecraft is running and you are in the world you can run the examples.
All examples can be run from the command line in LXTerminal.

##Running the Examples in LXTerminal

1. Open LXTerminal by double clicking on the icon on the desktop or click on :
  Start Menu > Accessories > LXTerminal

2. Navigate to the folder where these examples are, assuming you have uncompressed the zip folder or cloned the repository in your home folder :
 `cd Perl-Minecraft-Examples`
3. Type: `perl filename.pl` and press enter (where filename is the examples to try)
4. Where the script expects arguments you supply those after the filename. For example:
   `perl 02-sendArgsMessageToChat.pl "This is a message"`
5. Have fun in Minecraft!
