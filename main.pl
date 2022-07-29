use Net::MQTT::Simple;
use LWP::UserAgent;
 
my $mqtt = Net::MQTT::Simple->new("test.mosquitto.org");

$mqtt->run(
    "9604123" => sub {
        my ($topic, $message) = @_;
		flipStatus($message);
    }
);

sub flipStatus{
	my $vehicle = $_[0];
	print "updated Vehicle $vehicle \n";
	my $url = "http://localhost:8080/vehicle/$vehicle/status";
	my $ua = LWP::UserAgent->new;
	$ua->put( $url );
	return;
}
