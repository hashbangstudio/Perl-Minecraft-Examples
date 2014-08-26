package Vec3;
use strict;
use warnings;
use overload
            "+" => \&add,
            "+=" => \&iadd,
            "-" => \&minus,
            "-=" => \&iminus,
            "*" => \&mul,
            "*=" => \&imul,
            "<=>" => \&compare,
            "neg" => \&negate,
            '""' => \&stringify;

sub new{
        my $this = shift;
        my $class = ref($this) || $this;
        my($x, $y, $z) = @_;
        my $self = {xcoord => $x, ycoord => $y , zcoord => $z};
        bless $self, $class;
        return $self;
}

sub x{
    my $self = shift;
    return $self->{xcoord};
}

sub y{
    my $self = shift;
    return $self->{ycoord};
}

sub z{
    my $self = shift;
    return $self->{zcoord};
}
sub stringify{
    my $self = shift;
    return "[".$self->{xcoord}.",".$self->{ycoord}.",".$self->{zcoord}."]";
}

sub clone{
        my $self = shift;
        return Vec3::->new($self->{xcoord}, $self->{ycoord}, $self->{zcoord});
}

sub add {
        my ($self, $rhs, $swap) = @_;
        my $c = $self->clone();
        return $c += $rhs;
}

sub iadd{
        my ($self, $rhs, $swap) = @_;
        $self->{xcoord} = $self->{xcoord} + $rhs->{xcoord};
        $self->{ycoord} = $self->{ycoord} + $rhs->{ycoord};
        $self->{zcoord} = $self->{zcoord} + $rhs->{zcoord};
        return $self;
}

sub length{
        my $self = shift;
        return $self->lengthSqr ** 0.5;
}

sub lengthSqr{
    my $self = shift;
    return $self->{xcoord} * $self->{xcoord} + $self->{ycoord} * $self->{ycoord}  + $self->{zcoord} * $self->{zcoord};
}

sub mul{
        my ($self, $rhs, $swap) = @_;
        my $c = $self->clone();
        $c *= $rhs;
        return $c;
}

sub imul{
    my ($self, $rhs, $swap) = @_;
    $self->{xcoord} *= $rhs;
    $self->{ycoord} *= $rhs;
    $self->{zcoord} *= $rhs;
    return $self;
}

sub negate{
        my $self = shift;
        return Vec3::->new(-$self->{xcoord}, -$self->{ycoord}, -$self->{zcoord});
}

sub minus{
        my ($self, $rhs, $swap) = @_;
        return $self->add(-$rhs);
}
sub iminus{
        my ($self, $rhs, $swap) = @_;
        return $self->iadd(-$rhs);
}

sub compare{
        my ($self, $rhs, $swap) = @_;
        my $dx = $self->{xcoord} - $rhs->{xcoord};
        if ($dx != 0){return $dx;}
        my $dy = $self->{ycoord} - $rhs->{ycoord};
        if ($dy != 0) {return $dy;}
        my $dz = $self->{zcoord} - $rhs->{zcoord};
        if ($dz != 0){return $dz;}
        return 0;
}

END{ }

1;
