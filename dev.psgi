use Plack::Builder;
use Plack::App::Directory;
use Path::Class;

my $root   = dir('.')->subdir('root');
my $static = Plack::App::Directory->new({
    root => $root->stringify,
})->to_app;

my $app = sub {
    my ($env) = @_;

    my $f = $root->file($env->{PATH_INFO});
    if (-f -r $f) {
        return $static->(@_);
    }
    else {
        eval q/use RotateIcon/;
        my $app = RotateIcon->new;
        $app->setup;
        $app->handler->(@_);
    }
};
