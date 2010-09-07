package RotateIcon::Models;
use Ark::Models '-base';

register cache => sub {
    my ($self) = @_;

    my $conf = $self->get('conf')->{cache};
    return $self->adaptor($conf);
};

register lwp => sub {
    my ($self) = @_;

    $self->ensure_class_loaded('LWP::UserAgent');
    return LWP::UserAgent->new;
};

register twitter => sub {
    my ($self) = @_;

    my $conf = $self->get('conf')->{'Plugin::Authentication::Credential::Twitter'};
    $self->ensure_class_loaded('Net::Twitter');
    return Net::Twitter->new(
        traits => [qw/API::REST OAuth/],
        %$conf,
    );
};

1;
