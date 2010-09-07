package RotateIcon;
use Ark;

our $VERSION = '0.01';

use_model 'RotateIcon::Models';

use_plugins qw/
    Authentication
    Authentication::Credential::Twitter
    Authentication::Store::Null
    Session
    Session::State::Cookie
    Session::Store::Model
/;

1;
