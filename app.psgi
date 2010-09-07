use Plack::Builder;
use Plack::Middleware::Static;

use RotateIcon;

my $app = RotateIcon->new;
$app->setup;

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/(js/|css/|swf/|images?/|imgs?/|static/|[^/]+\.[^/]+$)},
        root => $app->path_to('root')->stringify;

    $app->handler;
};
