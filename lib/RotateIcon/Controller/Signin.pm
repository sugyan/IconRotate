package RotateIcon::Controller::Signin;
use Ark 'Controller';
use Try::Tiny;

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    my $auth;
    if ($c->req->param('oauth_verifier')) {
        my $error;
        try {
            $auth = $c->auth->authenticate_twitter;
        } catch {
            $error = $_;
        };

        if ($error) {
            $c->log(error => $error);
            $c->redirect_and_detach('/login/failed');
        }
    }
    else {
        $auth = $c->auth->authenticate_twitter(
            callback => $c->uri_for($c->req->path),
        );
    }

    use YAML;
    $c->log(debug => Dump $c->user->obj);
    $c->redirect_and_detach('/') if $auth;
}

sub failed :Local :Args(0) {
    my ($self, $c) = @_;

    $c->redirect_and_detach('/') if $c->user;
}

1;
