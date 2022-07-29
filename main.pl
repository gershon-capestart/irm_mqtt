use Net::MQTT::Simple;
use LWP::UserAgent;
 
my $MQTT_URL = $ENV{MQTT_URL};
my $TOPIC = $ENV{TOPIC};
my $BASE_URL = $ENV{BASE_URL};

my $mqtt = Net::MQTT::Simple->new($MQTT_URL);

$mqtt->run(
    $TOPIC => sub {
        my ($topic, $message) = @_;
		flipStatus($message);
    }
);

sub flipStatus{
	my $vehicle = $_[0];
	print "updated Vehicle $vehicle \n";
	my $url = "$BASE_URL/vehicle/$vehicle/status";
	my $ua = LWP::UserAgent->new;
	$ua->put( $url );
	return;
}
