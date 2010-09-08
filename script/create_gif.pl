#!/usr/bin/env perl
use strict;
use warnings;

use Path::Class;
use Imager;

my $src   = shift or die;
my $type  = shift || 1;
my %type_map = (
    rotate1 => 1,
    rotate2 => 3,
    rotate3 => 5,
    rotate4 => undef,
);

my $image = Imager->new(
    file     => $src,
    channels => 4,
)->scale(xpixels => 48, ypixels => 48);
my @images = ();

push @images, $image;
for (1 .. 59) {
    push @images, $image->rotate(
        degrees => defined $type_map{$type} ? $_ * 6 * $type_map{$type} : rand 360,
        back    => 'white',
    )->crop(width => 48, height => 48);
}
my $file = file($src)->dir->file("$type.gif");
Imager->write_multi({
    file => $file,
    type => 'gif',
    gif_loop => 0,
}, @images);
