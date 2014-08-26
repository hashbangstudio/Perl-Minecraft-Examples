package BlockEvent;
use strict;
use lib '.';
use Vec3;
use warnings;
use overload '""' => \&print_info;

BEGIN {
    require Exporter;

    our $VERSION = 0.01;
    our @ISA = qw(Exporter);
    our @EXPORT = qw();
    our @EXPORT_OK = qw();
}


my $HIT = 0;
#An Event related to blocks (e.g. placed, removed, hit)
sub new{
        my $this = shift;
        my $class = ref($this) || $this;
        my($type, $x, $y, $z, $face, $entityId) = @_;
        my $self = { type => $type, 
                     posn => Vec3::->new($x, $y, $z), 
                     face => $face, entityId => $entityId,
                     HIT => $HIT};
        bless $self, $class;
        return $self;
}

sub print_info {
    my $self = shift;
    my %sTypeHash = ( $HIT => "BlockEvent.HIT");
    my $typeText = "???";
    my $key = $self->{type};
    #TODO remember to be aware of autovivification
    if (exists( $sTypeHash{$key})){
        $typeText = $sTypeHash{$key};
    }
    my $output = sprintf("BlockEvent(%s, %d, %d, %d, %d, %d)",  
                         $typeText, 
                         $self->{posn}->x, $self->{posn}->y, $self->{posn}->z, 
                         $self->{face}, $self->{entityId}
                         );
    print $output;
    return "";
}

sub Hit{
    my ($self, $x, $y, $z, $face, $entityId) = @_;
    return BlockEvent::->new($HIT, $x, $y, $z, $face, $entityId);
}

END{}      
1;
