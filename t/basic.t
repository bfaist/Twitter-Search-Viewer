#!/usr/bin/env perl
use Mojo::Base -strict;

use Test::More tests => 5;
use Test::Mojo;

use_ok 'TwitterSearchViewer';

# Test
my $t = Test::Mojo->new('TwitterSearchViewer');
$t->get_ok('/welcome')->status_is(200)
  ->content_type_is('text/html;charset=UTF-8')
  ->content_like(qr/Mojolicious Web Framework/i);
