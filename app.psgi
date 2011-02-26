use Plack::Builder;

use lib 'lib';
use RotateIcon;

my $app = RotateIcon->new;
$app->setup;

builder {
    enable_if { $_[0]->{REMOTE_ADDR} eq '127.0.0.1' }
        'Plack::Middleware::ReverseProxy';
    $app->handler;
};
