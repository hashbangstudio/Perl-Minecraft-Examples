package BlockData;
use strict;
use Block;
use warnings;

BEGIN {
    require Exporter;

    our $VERSION = 0.01;
    our @ISA = qw(Exporter);
    our @Export = qw();

    our @EXPORT_OK = qw(blockIdToName getBlockNameFromId
                        tntTypeNameTodId colourNameToId
                        slabTypeNameToId doubleSlabTypeNameToId
                        sandstoneTypeNameToId leavesTypeNameToId
                        woodPlanksTypeNameToId stairsTypeNameToId
                        blueFlowerTypeNameToId yellowFlowerTypeNameToId
                        grassTypeNameToId bedTypeNameToId);

    our %EXPORT_TAGS = ('ALL' => [qw(blockIdToName getBlockNameFromId
                                     tntTypeNameTodId colourNameToId
                                     slabTypeNameToId doubleSlabTypeNameToId
                                     sandstoneTypeNameToId leavesTypeNameToId
                                     woodPlanksTypeNameToId stairsTypeNameToId
                                     blueFlowerTypeNameToId yellowFlowerTypeNameToId
                                     grassTypeNameToId bedTypeNameToId)]);
}

our %blockIdToName = (
Block->AIR->{id} => 'AIR',
Block->STONE->{id} =>'STONE',
Block->GRASS->{id} =>'GRASS',
Block->DIRT->{id} =>'DIRT',
Block->COBBLESTONE->{id} =>'COBBLESTONE',
Block->WOOD_PLANKS->{id} =>'WOOD_PLANKS',
Block->SAPLING->{id} =>'SAPLING',
Block->BEDROCK->{id} =>'BEDROCK',
Block->WATER_FLOWING->{id} =>'WATER_FLOWING',
Block->WATER_STATIONARY->{id} =>'WATER_STATIONARY',
Block->LAVA_FLOWING->{id} =>'LAVA_FLOWING',
Block->LAVA_STATIONARY->{id} =>'LAVA_STATIONARY',
Block->SAND->{id} =>'SAND',
Block->GRAVEL->{id} =>'GRAVEL',
Block->GOLD_ORE->{id} =>'GOLD_ORE',
Block->IRON_ORE->{id} =>'IRON_ORE',
Block->COAL_ORE->{id} =>'COAL_ORE',
Block->WOOD->{id} =>'WOOD',
Block->LEAVES->{id} =>'LEAVES',
Block->GLASS->{id} =>'GLASS',
Block->LAPIS_LAZULI_ORE->{id} =>'LAPIS_LAZULI_ORE',
Block->LAPIS_LAZULI_BLOCK->{id} =>'LAPIS_LAZULI_BLOCK',
Block->SANDSTONE->{id} =>'SANDSTONE',
Block->BED->{id} =>'BED',
Block->COBWEB->{id} =>'COBWEB',
Block->GRASS_TALL->{id} =>'GRASS_TALL',
Block->WOOL->{id} =>'WOOL',
Block->FLOWER_YELLOW->{id} =>'FLOWER_YELLOW',
Block->FLOWER_CYAN->{id} =>'FLOWER_CYAN',
Block->MUSHROOM_BROWN->{id} =>'MUSHROOM_BROWN',
Block->MUSHROOM_RED->{id} =>'MUSHROOM_RED',
Block->GOLD_BLOCK->{id} =>'GOLD_BLOCK',
Block->IRON_BLOCK->{id} =>'IRON_BLOCK',
Block->STONE_SLAB_DOUBLE->{id} =>'STONE_SLAB_DOUBLE',
Block->STONE_SLAB->{id} =>'STONE_SLAB',
Block->BRICK_BLOCK->{id} =>'BRICK_BLOCK',
Block->TNT->{id} =>'TNT',
Block->BOOKSHELF->{id} =>'BOOKSHELF',
Block->MOSS_STONE->{id} =>'MOSS_STONE',
Block->OBSIDIAN->{id} =>'OBSIDIAN',
Block->TORCH->{id} =>'TORCH',
Block->FIRE->{id} =>'FIRE',
Block->STAIRS_WOOD->{id} =>'STAIRS_WOOD',
Block->CHEST->{id} =>'CHEST',
Block->DIAMOND_ORE->{id} =>'DIAMOND_ORE',
Block->DIAMOND_BLOCK->{id} =>'DIAMOND_BLOCK',
Block->CRAFTING_TABLE->{id} =>'CRAFTING_TABLE',
Block->FARMLAND->{id} =>'FARMLAND',
Block->FURNACE_INACTIVE->{id} =>'FURNACE_INACTIVE',
Block->FURNACE_ACTIVE->{id} =>'FURNACE_ACTIVE',
Block->DOOR_WOOD->{id} =>'DOOR_WOOD',
Block->LADDER->{id} =>'LADDER',
Block->STAIRS_COBBLESTONE->{id} =>'STAIRS_COBBLESTONE',
Block->DOOR_IRON->{id} =>'DOOR_IRON',
Block->REDSTONE_ORE->{id} =>'REDSTONE_ORE',
Block->SNOW->{id} =>'SNOW',
Block->ICE->{id} =>'ICE',
Block->SNOW_BLOCK->{id} =>'SNOW_BLOCK',
Block->CACTUS->{id} =>'CACTUS',
Block->CLAY->{id} =>'CLAY',
Block->SUGAR_CANE->{id} =>'SUGAR_CANE',
Block->FENCE->{id} =>'FENCE',
Block->GLOWSTONE_BLOCK->{id} =>'GLOWSTONE_BLOCK',
Block->BEDROCK_INVISIBLE->{id} =>'BEDROCK_INVISIBLE',
Block->STONE_BRICK->{id} =>'STONE_BRICK',
Block->GLASS_PANE->{id} =>'GLASS_PANE',
Block->MELON->{id} =>'MELON',
Block->FENCE_GATE->{id} =>'FENCE_GATE',
Block->GLOWING_OBSIDIAN->{id} =>'GLOWING_OBSIDIAN',
Block->NETHER_REACTOR_CORE->{id} =>'NETHER_REACTOR_CORE'
);

sub blockIdToName{
    return %blockIdToName;
}

sub getBlockNameFromId{
    my $id = shift;
    return $blockIdToName{$id};
}

#avaiable 0-1, affects whether striking blk sets off fuse
our %tntTypeNameToId = (
'safe'  => 0,
'armed' => 1
);

sub tntTypeNameToId{
    return %tntTypeNameToId;
}

#available range 0-15, affects colour of wool block
our %colourNameToId  = (
'white'      => 0,
'orange'     => 1,
'magenta'    => 2,
'light-blue' => 3,
'yellow'     => 4,
'lime'       => 5,
'pink'       => 6,
'grey'       => 7,
'gray'       => 7,
'light-grey' => 8,
'light-gray' => 8,
'cyan'       => 9,
'purple'     =>10,
'blue'       =>11,
'brown'      =>12,
'green'      =>13,
'red'        =>14,
'black'      =>15
);

sub colourNameToId{
    return %colourNameToId;
}

# only 0-2 seem to do anything for texture
# 0 to 3 is type, beyond that is decay counter
# avilablerange 0-15
our %leavesTypeNameToId = (
'oak'   => 0,
'pine'  => 1,
'spruce'=> 1,
'birch' => 2,
'jungle'=> 3
);

sub leavesTypeNameToId{
    return %leavesTypeNameToId;
}

# only 0-2 seem to o anything
# available values 0-15 affects texture and rotation
our %woodPlanksTypeNameToId = (
'oak-up'       => 0,
'spruce-up'    => 1,
'birch-up'     => 2,
'jungle-up'    => 3,
'oak-east'     => 4,
'spruce-east'  => 5,
'birch-east'   => 6,
'jungle-east'  => 7,
'oak-north'    => 8,
'spruce-north' => 9,
'birch-north'  =>10,
'jungle-north' =>11,
'oak-bark'     =>12,
'spruce-bark'  =>13,
'birch-bark'   =>14,
'jungle-bark'  =>15
);

sub woodPlanksTypeNameToId{
    return %woodPlanksTypeNameToId;
}

# available 0-15
# 6,7,14 and 15 don't work (uses default stone)
our %slabTypeNameToId = (
'stone'            => 0,
'sandstone'        => 1,
'wooden'           => 2,
'cobblestone'      => 3,
'brick'            => 4,
'stone-brick'      => 5,
#just is stone
'nether-brick'     => 6,
#just is stone
'quartz'           => 7,
'stone-top'        => 8,
'sandstone-top'    => 9,
'wooden-top'       =>10,
'cobblestone-top'  =>11,
'brick'            =>12,
'stone-brick'      =>13,
#just is stone
'nether-brick-top' =>14,
#just is stone
'quartz-top'       =>15
);

sub slabTypeNameToId{
    return %slabTypeNameToId;
}

#available 0-15
# only 1 to 5 does anything
# 6 and 7 wil use default stone
# above that just cycles back round
our %doubleSlabTypeNameToId = (
'stone'            => 0,
'sandstone'        => 1,
'wooden'           => 2,
'cobblestone'      => 3,
'brick'            => 4,
'stone-brick'      => 5,
#just is stone
'nether-brick'     => 6,

#just is stone
'quartz'           => 7
);

sub doubleSlabTypeNameToId{
    return %doubleSlabTypeNameToId;
}

#available 0 to 2
our %sandstoneTypeNameToId = (
'sandstone' => 0,
'chiseled'  => 1,
'smooth'    => 2
);

sub sandstoneTypeNameToId{
    return %sandstoneTypeNameToId;
}

# available 0 to 3
our %bedTypeNameToId = (
'south' => 0,
'west'  => 1,
'north' => 2,
'east'  => 3
);

sub bedTypeNameToId{
    return %bedTypeNameToId;
}

# available 0 to 3
# no effect seemingly
our %grassTypeNameToId = (
'shrub'        => 0,
'grass'       => 1,
'fern'        => 2,
'biome-shrub' => 3
);

sub grassTypeNameToId{
    return %grassTypeNameToId;
}

# there appears to be no difference for each value
our %yellowFlowerTypeNameToId = (
'yellow' => 0
);

sub yellowFlowerTypeNameToId{
    return %yellowFlowerTypeNameToId;
}

# there appears to be no difference for each value
our %blueFlowerTypeNameToId = (
'blue' => 0
);

sub blueFlowerTypeNameToId{
    return %blueFlowerTypeNameToId;
}

# direction of ascending 0 to 7 available
# 0 to 3 for normal stairs, 4-7 for inverted stairs
our %stairsTypeNameToId = (
'east' => 0,
'west' => 1,
'south'=> 2,
'north'=> 3,
'east-inverted' => 4,
'west-inverted' => 5,
'south-inverted'=> 6,
'north-inverted'=> 7
);

sub stairsTypeNameToId{
    return %stairsTypeNameToId;
}

our %doorTypeNameToId = (
'northwest'=> 0,
'northeast'=> 1,
'southeast'=> 2,
'southwest'=> 3,
'northwest-swung'=> 0,
'northeast-swung'=> 1,
'southeast-swung'=> 2,
'southwest-swung'=> 3,
'northwest-top'=> 8,
'northeast-top'=> 9,
'southeast-top'=>10,
'southwest-top'=>11,
'northwest-top-swung'=>12,
'northeast-top-swung'=>13,
'southeast-top-swung'=>14,
'southwest-top-swung'=>15
);

sub doorTypeNameToId{
    return %doorTypeNameToId;
}

END{}
1;
