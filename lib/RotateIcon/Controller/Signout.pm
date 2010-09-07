package RotateIcon::Controller::Signout;
use Ark 'Controller';

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    $c->logout;
    $c->redirect_and_detach('/');
}

1;
