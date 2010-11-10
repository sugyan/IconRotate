package RotateIcon::Controller::Api::Rotate;
use Ark 'Controller';

sub auto :Private {
    my ($self, $c) = @_;

    $c->detach('/default') unless $c->user;
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    my ($path1, $path2) = $c->user->obj->{user_id} =~ /^(\d*?(\d{2}))$/;
    my $type = $c->req->param('type');

    my $dir      = $c->model('home')->subdir('root', 'images', $path2, $path1);
    my $original = (sort { $b->stat->mtime <=> $a->stat->mtime } grep { $_->basename =~ /^original/ } $dir->children)[0];
    my $file     = $dir->file("$type.gif");
    # 比較的新しいファイルが既に存在していたらそのまま返す
    unless (-e $file && time - $file->stat->mtime < 300) {
        $c->log(debug => "create");
        system($c->model('home')->subdir('script')->file('create_gif.pl'), $original, $type) == 0
            or $c->detach('/default');
    }

    $c->res->body($file->relative($c->model('home')->subdir('root')));
}

1;
