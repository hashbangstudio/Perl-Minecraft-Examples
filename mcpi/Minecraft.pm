use strict;
use lib '.';
#use Connection;
#use Vec3;
#use Event;
use warnings;


BEGIN {
    require Exporter;

    our $VERSION = 0.01;
    our @ISA = qw(Exporter);
    our @EXPORT = qw();
    our @EXPORT_OK = qw(intFloor);
}

package commonFuncs;
use POSIX;
sub intFloor{
    my @elements = map{POSIX::floor($_)}  @_;
    return @elements;
}

sub getNumFromStatusBool{
    my $boolean = shift;
    if ($boolean == 1 || lc($boolean) eq 'true'){
        return 1;
    }else{
        return 0;
    }
}

package CmdPositioner;
use Vec3;
sub new{
        my $this = shift;
        my $class = ref($this) || $this;
        my($conn, $pkg) = @_;
        my $self = {conn => $conn, pkg => $pkg || "Unknown"};
        bless $self, $class;
        return $self;

}

#Methods for setting and getting positions
sub getPos{
    my ($self, $id) = @_;
    #Get entity position (entityId:int) => Vec3
    my $s = $self->{conn}->send_and_receive($self->{pkg}. ".getPos", $id);
    return Vec3::->new(split(",",$s));
}

sub setPos{
    my ($self, $id, @data) = @_;
    #Set entity position (entityId:int, x,y,z)
    $self->{conn}->send($self->{pkg} . ".setPos", $id, @data);
}

sub getTilePos{
        my ($self, $id) = @_;
        my $response = $self->{conn}->send_and_receive($self->{pkg}.".getTile", $id);
        my $result = Vec3::->new(map(int, split(",", $response)));
        return $result;
}

sub setTilePos{
        my ($self, $id, @data)= @_;
        #Set entity tile position (entityId:int) => Vec3
        $self->{conn}->send($self->{pkg}.".setTile", $id, commonFuncs::intFloor(@data))
}

sub setting{
    my ($self, $setting, $status)= @_;
    #Set a player setting (setting, status). keys: autojump
    $status = commonFuncs::getNumFromStatusBool($status);
    $self->{conn}->send($self->{pkg}.".setting", $setting, $status);
}

package CmdEntity;
use parent -norequire, 'CmdPositioner';
    #Methods for entities

sub new{
    my $this = shift;
    my $class = ref($this) || $this;
    my $conn = $_[0];
    my $positioner = CmdPositioner::->new($conn, "entity");
    my $self = {conn => $conn,
                cmdpos => $positioner};

    bless $self, $class;
    return $self;
}


package CmdPlayer;
use parent -norequire, 'CmdPositioner';

   #Methods for the host (Raspberry Pi) player
sub new{
    my $this = shift;
    my $class = ref($this) || $this;
    my $conn = $_[0];
    my $positioner = CmdPositioner::->new($conn, "player");
    my $self = {conn => $conn,
                cmdpos => $positioner};

    bless $self, $class;
    return $self;
}
sub getPos{
        my $self = shift;
        return $self->{cmdpos}->getPos([]);
}
sub setPos{
    my $self = shift;
    return $self->{cmdpos}->setPos([], @_);
}
sub getTilePos{
    my $self = shift;
    return $self->{cmdpos}->getTilePos([]);
}

sub setTilePos{
    my $self = shift;
    return $self->{cmdpos}->setTilePos([], @_);
}

sub setting{
    my $self = shift;
    return $self->{cmdpos}->setting(@_);
}

package CmdCamera;
sub new{
    my $this = shift;
    my $class = ref($this) || $this;
    my $conn = shift;
    my $self = {conn => $conn};
    bless $self, $class;
    return $self;
}

sub setNormal{
    my $self = shift;
    # Set camera mode to normal Minecraft view ([entityId])
    $self->{conn}->send("camera.mode.setNormal", @_);
}

sub setFixed{
    my $self = shift;
    #  Set camera mode to fixed view
    $self->{conn}->send("camera.mode.setFixed");
}

sub setFollow{
    my $self = shift;
    # Set camera mode to follow an entity ([entityId])
    $self->{conn}->send("camera.mode.setFollow", @_);
}

sub setPos{
    my $self = shift;
    # Set camera entity position (x,y,z)
    $self->{conn}->send("camera.setPos", @_);
}

package CmdEvents;
   # Events
use Event;

sub new{
        my $this = shift;
        my $class = ref($this) || $this;
        my $conn = shift;
        my $self = {conn => $conn};
        bless $self, $class;
        return $self;
}

sub clearAll{
    my $self = shift;
    # Clear all old events
    $self->{conn}->send("events.clear");
}

sub pollBlockHits{
    my $self = shift;
    # Only triggered by sword => [BlockEvent]
    my $s = $self->{conn}->send_and_receive("events.block.hits");
    my @hitsArray = ();
    #double quotes convert \\ to \ and then split takes \| to mean the | character
    if (defined($s) and ($s ne "\n")){
        my @events = split("\\|", $s);
        foreach my $e(@events){
            my @entry = split(",", $e);
            @entry = map(int, @entry);
            push(@hitsArray, BlockEvent::->Hit(@entry));
           
        }
    }
    return @hitsArray;
}

package Minecraft;
#The main class to interact with a running instance of Minecraft Pi.
use Connection;
use Block;

sub getBlock{
    my $self = shift;
    #Get block (x,y,z) => id:int
    return int($self->{conn}->send_and_receive("world.getBlock", commonFuncs::intFloor(@_)));
}

sub getBlockWithData{
    my $self = shift;
    # Get block with data (x,y,z) => Block
    my $ans = $self->{conn}->send_and_receive("world.getBlockWithData", commonFuncs::intFloor(@_));
    return Block::->new(map(int, split(",", $ans)));
}

#    
#        TODO
#    
sub getBlocks{
    my $self = shift;
    # Get a cuboid of blocks (x0,y0,z0,x1,y1,z1) => [id:int]
    return int($self->{conn}->send_and_receive("world.getBlocks", commonFuncs::intFloor(@_)));
}

sub setBlock{
    my ($self, @data) = @_;
    if (ref($data[$#data]) eq "Block"){
        my $block = pop(@data);
        push(@data, $block->id);
        push(@data, $block->data);
    }
    #  Set block (x,y,z,id,[data])
    $self->{conn}->send("world.setBlock", commonFuncs::intFloor(@data));
}
sub setBlocks{
    my ($self, @data) = @_;
    if (ref($data[$#data]) eq "Block"){
        my $block = pop(@data);
        push(@data, $block->id);
        push(@data, $block->data);
    }
    #  Set a cuboid of blocks (x0,y0,z0,x1,y1,z1,id,[data])
    $self->{conn}->send("world.setBlocks", commonFuncs::intFloor(@data));
}

sub getHeight{
    my $self = shift;
    #  Get the height of the world (x,z) => int
    return int($self->{conn}->send_and_receive("world.getHeight", commonFuncs::intFloor(@_)));
}

sub getPlayerEntityIds{
    my $self = shift;
    #   Get the entity ids of the connected players => [id:int]
    my $ids = $self->{conn}->send_and_receive("world.getPlayerIds");
    my @idArray = split("\\|", $ids);
    return @idArray;
}

sub saveCheckpoint{
    my $self = shift;
    # Save a checkpoint that can be used for restoring the world
    $self->{conn}->send("world.checkpoint.save");
}

sub restoreCheckpoint{
    my $self = shift;
    # Restore the world state to the checkpoint
    $self->{conn}->send("world.checkpoint.restore");
}

sub postToChat{
   my ($self, $msg) = @_;
   #Post a message to the game chat
   $self->{conn}->send("chat.post", $msg);
}

sub setting{
    my ($self, $setting, $status)= @_;
    # Set a world setting (setting, status). keys: world_immutable, nametags_visible
    $status = commonFuncs::getNumFromStatusBool($status);
    $self->{conn}->send("world.setting", $setting, $status);
}

sub create{
        my ($self, @params) = @_;
        die "used as object method" if ref $self;
        my $address = $params[0] || "localhost";
        my $port = $params[1] || 4711;
        #print("$address, $port\n");
        return Minecraft->new(Connection->new($address, $port));
}

sub new{
     my $this = shift;
     my $class = ref($this) || $this;
     my($conn) = @_;
     my $self = {conn => $conn,
                 camera => CmdCamera::->new($conn),
                 entity => CmdEntity::->new($conn),
                 player => CmdPlayer::->new($conn),
                 events => CmdEvents::->new($conn)
                };

     bless $self, $class;
     return $self;
}

sub player { 
    my $self = shift;
    return $self->{player};
}

sub camera{
    my $self = shift;
    return $self->{camera};
}

sub entity{
    my $self = shift;
    return $self->{entity};
}

sub events{
    my $self = shift;
    return $self->{events};
}

sub close{
    my $self = shift;
    $self->{conn}->close();
}

END{}
1;
