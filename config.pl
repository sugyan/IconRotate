use RotateIcon::Models;

my $home = RotateIcon::Models->get('home');

return {
    cache => {
        class => 'Cache::FastMmap',
        deref => 1,
        args  => {
            share_file     => $home->subdir('tmp')->file('cache')->stringify,
            unlink_on_exit => 0,
        },
    },
    'Plugin::Authentication::Credential::Twitter' => {
        consumer_key    => '****',
        consumer_secret => '********',
    },
    'Plugin::Session::Store::Model' => {
        model => 'cache',
    },
};
