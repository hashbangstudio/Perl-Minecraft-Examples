package Block;
use strict;
use warnings;
use overload
            "<=>" => \&compare,
            '""' => \&print_info;

BEGIN {
    require Exporter;

    our $VERSION = 0.01;
    our @ISA = qw(Exporter);
    our @Export = qw();
    our @EXPORT_OK = qw(AIR STONE GRASS DIRT COBBLESTONE 
                        WOOD_PLANKS SAPLING BEDROCK
                        WATER_FLOWING WATER WATER_STATIONARY 
                        LAVA_FLOWING LAVA LAVA_STATIONARY SAND GRAVEL 
                        GOLD_ORE IRON_ORE COAL_ORE WOOD LEAVES GLASS 
                        LAPIS_LAZULI_ORE LAPIS_LAZULI_BLOCK 
                        SANDSTONE BED COBWEB GRASS_TALL WOOL 
                        FLOWER_YELLOW FLOWER_CYAN MUSHROOM_BROWN MUSHROOM_RED
                        GOLD_BLOCK IRON_BLOCK STONE_SLAB_DOUBLE STONE_SLAB 
                        BRICK_BLOCK TNT BOOKSHELF MOSS_STONE
                        OBSIDIAN TORCH FIRE STAIRS_WOOD CHEST 
                        DIAMOND_ORE DIAMOND_BLOCK CRAFTING_TABLE FARMLAND 
                        FURNACE_INACTIVE FURNACE_ACTIVE DOOR_WOOD
                        LADDER STAIRS_COBBLESTONE DOOR_IRON 
                        REDSTONE_ORE SNOW ICE SNOW_BLOCK
                        CACTUS CLAY SUGAR_CANE FENCE 
                        GLOWSTONE_BLOCK BEDROCK_INVISIBLE STONE_BRICK
                        GLASS_PANE MELON FENCE_GATE 
                        GLOWING_OBSIDIAN NETHER_REACTOR_CORE);
                        
    our %EXPORT_TAGS = ('ALL_BLOCKS' => [qw(AIR STONE GRASS DIRT COBBLESTONE 
                        WOOD_PLANKS SAPLING BEDROCK
                        WATER_FLOWING WATER WATER_STATIONARY 
                        LAVA_FLOWING LAVA LAVA_STATIONARY SAND GRAVEL 
                        GOLD_ORE IRON_ORE COAL_ORE WOOD LEAVES GLASS 
                        LAPIS_LAZULI_ORE LAPIS_LAZULI_BLOCK 
                        SANDSTONE BED COBWEB GRASS_TALL WOOL 
                        FLOWER_YELLOW FLOWER_CYAN MUSHROOM_BROWN MUSHROOM_RED
                        GOLD_BLOCK IRON_BLOCK STONE_SLAB_DOUBLE STONE_SLAB 
                        BRICK_BLOCK TNT BOOKSHELF MOSS_STONE
                        OBSIDIAN TORCH FIRE STAIRS_WOOD CHEST 
                        DIAMOND_ORE DIAMOND_BLOCK CRAFTING_TABLE FARMLAND 
                        FURNACE_INACTIVE FURNACE_ACTIVE DOOR_WOOD
                        LADDER STAIRS_COBBLESTONE DOOR_IRON 
                        REDSTONE_ORE SNOW ICE SNOW_BLOCK
                        CACTUS CLAY SUGAR_CANE FENCE 
                        GLOWSTONE_BLOCK BEDROCK_INVISIBLE STONE_BRICK
                        GLASS_PANE MELON FENCE_GATE 
                        GLOWING_OBSIDIAN NETHER_REACTOR_CORE)]);
}

sub new {
        my $this = shift;
        my $class = ref($this) || $this;
        my ($id, $data) = @_;
        my $self = {id => ($id || 0), data => ($data || 0)};
        bless $self, $class;
        return $self;
}

sub withData{
    my $self = shift;
    my $data = $_[0];
    return Block::->new($self->{id}, $data);
}

#Accessors
sub id {
    my $self = shift;
    return $self->{id};
}

sub data {
    my $self = shift;
    return $self->{data};
}

#Print overload
sub print_info {
    my $self = shift;
    my $string = "id=".$self->{id}.",data=".$self->{data};
    print $string;
    return "\n";
}

sub compare{
    my ($self, $rhs, $swap) = @_;
    my $dId = $self->{id} - $rhs->{id};
    if ($dId != 0){return $dId};
    my $dData = $self->{data} - $rhs->{data};
    if ($dData != 0) {return $dData};
    return 0;
}


sub AIR                { return Block->new(0);}
sub STONE              { return Block->new(1);}
sub GRASS              { return Block->new(2);}
sub DIRT               { return Block->new(3);}
sub COBBLESTONE        { return Block->new(4);}
sub WOOD_PLANKS        { return Block->new(5);}
sub SAPLING            { return Block->new(6);}
sub BEDROCK            { return Block->new(7);}
sub WATER_FLOWING      { return Block->new(8);}
sub WATER              { return WATER_FLOWING();}
sub WATER_STATIONARY   { return Block->new(9);}
sub LAVA_FLOWING       { return Block->new(10);}
sub LAVA               { return LAVA_FLOWING();}
sub LAVA_STATIONARY    { return Block->new(11);}
sub SAND               { return Block->new(12);}
sub GRAVEL             { return Block->new(13);}
sub GOLD_ORE           { return Block->new(14);}
sub IRON_ORE           { return Block->new(15);}
sub COAL_ORE           { return Block->new(16);}
sub WOOD               { return Block->new(17);}
sub LEAVES             { return Block->new(18);}
sub GLASS              { return Block->new(20);}
sub LAPIS_LAZULI_ORE   { return Block->new(21);}
sub LAPIS_LAZULI_BLOCK { return Block->new(22);}
sub SANDSTONE          { return Block->new(24);}
sub BED                { return Block->new(26);}
sub COBWEB             { return Block->new(30);}
sub GRASS_TALL         { return Block->new(31);}
sub WOOL               { return Block->new(35);}
sub FLOWER_YELLOW      { return Block->new(37);}
sub FLOWER_CYAN        { return Block->new(38);}
sub MUSHROOM_BROWN     { return Block->new(39);}
sub MUSHROOM_RED       { return Block->new(40);}
sub GOLD_BLOCK         { return Block->new(41);}
sub IRON_BLOCK         { return Block->new(42);}
sub STONE_SLAB_DOUBLE  { return Block->new(43);}
sub STONE_SLAB         { return Block->new(44);}
sub BRICK_BLOCK        { return Block->new(45);}
sub TNT                { return Block->new(46);}
sub BOOKSHELF          { return Block->new(47);}
sub MOSS_STONE         { return Block->new(48);}
sub OBSIDIAN           { return Block->new(49);}
sub TORCH              { return Block->new(50);}
sub FIRE               { return Block->new(51);}
sub STAIRS_WOOD        { return Block->new(53);}
sub CHEST              { return Block->new(54);}
sub DIAMOND_ORE        { return Block->new(56);}
sub DIAMOND_BLOCK      { return Block->new(57);}
sub CRAFTING_TABLE     { return Block->new(58);}
sub FARMLAND           { return Block->new(60);}
sub FURNACE_INACTIVE   { return Block->new(61);}
sub FURNACE_ACTIVE     { return Block->new(62);}
sub DOOR_WOOD          { return Block->new(64);}
sub LADDER             { return Block->new(65);}
sub STAIRS_COBBLESTONE { return Block->new(67);}
sub DOOR_IRON          { return Block->new(71);}
sub REDSTONE_ORE       { return Block->new(73);}
sub SNOW               { return Block->new(78);}
sub ICE                { return Block->new(79);}
sub SNOW_BLOCK         { return Block->new(80);}
sub CACTUS             { return Block->new(81);}
sub CLAY               { return Block->new(82);}
sub SUGAR_CANE         { return Block->new(83);}
sub FENCE              { return Block->new(85);}
sub GLOWSTONE_BLOCK    { return Block->new(89);}
sub BEDROCK_INVISIBLE  { return Block->new(95);}
sub STONE_BRICK        { return Block->new(98);}
sub GLASS_PANE         { return Block->new(102);}
sub MELON              { return Block->new(103);}
sub FENCE_GATE         { return Block->new(107);}
sub GLOWING_OBSIDIAN   { return Block->new(246);}
sub NETHER_REACTOR_CORE{ return Block->new(247);}

END{};
1;
