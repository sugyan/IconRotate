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
            $c->res->body('Sign in failed!');
            $c->detach;
        }
    }
    else {
        $auth = $c->auth->authenticate_twitter(
            callback => $c->uri_for('/iconguruguru' . $c->req->path),
        );
    }

    $c->redirect_and_detach('/iconguruguru') if $auth;
}

sub failed :Local :Args(0) {
    my ($self, $c) = @_;

    $c->redirect_and_detach('/iconguruguru') if $c->user;
}

1;
