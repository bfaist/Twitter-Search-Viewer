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

   my $filtered_result = $self->apply_filters($result);

   return $filtered_result;
}

sub apply_filters {
   my $self = shift;
   my $search_results = shift;

   foreach my $result (@{ $search_results->{results} }) {
       # http://daringfireball.net/2009/11/liberal_regex_for_matching_urls
       if($result->{text} =~ m!\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))!) {
            my $link_in_text = $1;
            my $link_to_replace = quotemeta($1);
            $result->{text} =~ s/$link_to_replace/<a target="_blank" href="$link_in_text">$link_in_text<\/a>/;
       } 
   }

   return $search_results;
}

1;
