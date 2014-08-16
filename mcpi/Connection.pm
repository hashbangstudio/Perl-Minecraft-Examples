package Connection;
use strict;
use IO::Socket::INET;
use IO::Select;
use warnings;

BEGIN {
    require Exporter;

    our $VERSION = 0.01;
    our @ISA = qw(Exporter);
    our @EXPORT = qw();
    our @EXPORT_OK = qw(flattenToString);
}

sub DESTROY{
    my $self = shift;
    $self->close();
}
sub new {
        my $this = shift;
        my $class = ref($this) || $this;
        my ($address, $port, $protocol) = @_;
        #print $address, " ", $port, " " , $protocol, "\n";
        my $sock = IO::Socket::INET->new(
                                        PeerAddr => ($address || 'localhost'),
                                        PeerPort => ($port || 4711),
                                        Proto    => ($protocol || 'tcp')
                                        );
        $sock or die "Couldn't connect socket", "\n" ;
        my $sel = IO::Select->new();
        $sel->add($sock);
        my $self = {sock => $sock, sel => $sel, lastSent => ""};
        bless $self, $class;
        return $self;
}

#TODO replace this hack/bodge with a better function
#need to check for all types of iterable and flatten those correctly
sub flattenToString{
    
    my $text = "";
    my $arrSize = @_;
    my @data = @_;
    if ($arrSize == 0){
        $text = "";
    }else{
        my @indexesToDelete = [];
        my $index = 0;
        foreach(@data){
            my $refText = ref($_);
            if($refText eq "ARRAY"){
                $_ = flattenToString(@$_);
            }
            $index++;
        }
        undef $index;
        $text = join (",", @data);
    }
    #replace trailing and starting commas if they exist
    $text =~ s/^,//;
    $text =~ s/,$//;
    return $text;
}


sub drain{
    my $self = shift;
    my $char = "";
    my $response = "";
    my ($readable, $writeable, $errors)= IO::Select->select($self->{sel}, undef, undef, 0.1);
    if (defined($readable)){
        until($char eq "\n"){
        #$self->{sock}->recv($char, 1);#alternative read method
        sysread($self->{sock}, $char, 1);
        $response .= $char;
       }
    }
    return $response;
}

sub send{
    my ($self, $stem, @data) = @_;
    #flatten incoming arguments into a string if is an array
    my $msg = "";
    $msg .= flattenToString(@data);
    
    $self->drain();
    my $command = "$stem($msg)\n";
    $self->{lastSent} = $command;
    $self->{sock}->send($command);
}

sub receive{
    my $self = shift;
    my $response = $self->drain();
    return $response;
}

sub send_and_receive{
    my $self = shift;
    $self->send(@_);
    return $self->receive();
}

sub close{
    my $self = shift;
    $self->{sock}->shutdown(1);
    close $self->{sock};
}

END{ }
1;
