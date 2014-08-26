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

sub flatten{
    my @flatArray = ();
    foreach my $el(@_){
        my $refText = ref($el);
        if($refText eq "ARRAY"){ 
            push(@flatArray,  flatten(@{$el}));
        }elsif($refText eq "REF"){
            push(@flatArray, flatten($el));
        }elsif($refText eq "SCALAR"){
            push(@flatArray, $$el);
        }else{
            #Is a scalar or array so pass reference to function so know what type
            push(@flatArray, flatten(\$el));
        }
    }
    return @flatArray;
}
 
sub flattenToString{
    my $arrSz = @_;
    if($arrSz > 0){
        #Remove empty strings and join together
        return join(",", flatten(@_));
    }else{
        return "";
    }
}

sub drain{
    my $self = shift;
    my $char = "";
    my $response = "";
      
    while(1){
        my ($readable, $writeable, $errors)= IO::Select->select($self->{sel}, undef, undef, 0.05);
        if (!defined($readable) || @$readable < 1){
            last;
        }
        #$self->{sock}->recv($response, 1500);#alternative read method
        sysread($self->{sock}, $response, 1500);
        chomp($response);
        my $e =  "Drained Data: $response\n";
        $e .= "Last Message: $self->{lastSent}\n";
        print { *STDERR } $e;
    }
    
}

sub send{
    my ($self, $stem, @data) = @_;
    #flatten incoming arguments into a string if is an array
    my $msg = "";
    $msg .= flattenToString(@data);
    
    $self->drain();
    my $command = "$stem($msg)\n";
    #print "last sent = $command";
    $self->{lastSent} = "$command";
    $self->{sock}->send($command);
}

sub receive{
    my $self = shift;
    my $response = $self->{sock}->getline();
    chomp($response);
    if ($response eq "Fail"){
        print { *STDERR } "Failed = $self->{lastSent} \n";
        die("Failed on command : $self->{lastSent}\n");
    }
    
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
