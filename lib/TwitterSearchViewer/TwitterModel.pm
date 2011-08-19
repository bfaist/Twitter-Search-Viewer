package TwitterSearchViewer::TwitterModel;

use strict;
use base 'Mojo::Base';
use Net::Twitter;

sub init {
   my $self = shift;
   my %params = @_;

   $self->{twitter} = Net::Twitter->new(traits => [qw/API::REST API::Search WrapError/]);

   return;
}

sub twitter { my $self = shift; return $self->{twitter}; }

sub search {
   my $self = shift;
   my $search_term = shift;
   my $search_term_type = shift;

   my $t = $self->twitter();

   my $query;

   $query .= '#' if $search_term_type eq 'hashtag';
   $query .= $search_term;

   my $result = $t->search($query);

   return $result;
}

1;
