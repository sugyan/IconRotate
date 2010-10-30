use Plack::Builder;
use Plack::Middleware::Static;

use lib 'lib';
use RotateIcon;

my $app = RotateIcon->new;
$app->setup;
$app->handler;
