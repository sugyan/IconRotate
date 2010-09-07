package RotateIcon::Controller::Root;
use Ark 'Controller';

has '+namespace' => default => '';

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}

# view renderer
sub end :Private {
    my ($self, $c) = @_;

    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        # $c->res->content_type('text/html');
        $c->forward($c->view('MT'));
    }
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    $c->detach('/change_icon') if ($c->req->method eq 'POST');

    if ($c->user) {
        unless ($c->stash->{icon} = $c->session->get('icon')) {
            # プロフィール画像を得るためログイン情報を取得
            my $twitter = $c->model('twitter');
            $twitter->access_token       ($c->user->obj->{access_token}       );
            $twitter->access_token_secret($c->user->obj->{access_token_secret});
            my $icon = $twitter->verify_credentials->{profile_image_url};
            # 画像を指定のディレクトリに保存
            my ($path1, $path2) = $c->user->obj->{user_id} =~ /^(\d*?(\d{2}))$/;
            my $dir = $c->model('home')->subdir('root', 'images', $path2, $path1);
            $dir->mkpath;
            my $image = $c->model('lwp')->get($icon);
            my $file  = $image->filename;
            $file =~ s/^.*(\..*?)$/original$1/;
            my $fh = $dir->file($file)->openw;
            print $fh $image->content;
            # 一度保存したものはそのままsessionに入れて次回以降は読まない
            $c->stash->{icon} = $c->session->set('icon', $icon);
        }
    }
}

sub change_icon :Private {
    my ($self, $c) = @_;

    $c->detach('/default') unless $c->user;

    my $param = $c->req->param('icon');
    $c->redirect('/') unless $param;

    my ($path1, $path2) = $c->user->obj->{user_id} =~ /^(\d*?(\d{2}))$/;
    my $dir  = $c->model('home')->subdir('root', 'images', $path2, $path1);
    my $file = $dir->file("$param.gif");

    my $twitter = $c->model('twitter');
    $twitter->access_token       ($c->user->obj->{access_token}       );
    $twitter->access_token_secret($c->user->obj->{access_token_secret});
    $twitter->update_profile_image([ $file->stringify ]);

    $c->redirect('/');
}

1;
