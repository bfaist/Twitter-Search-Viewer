package TwitterSearchViewer::Page;

use strict;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub display {
  my $self = shift;

  my $app_config = $self->app->config();

  $self->stash(title => $app_config->{title});
  $self->stash(all_search_properties => $app_config->{search_properties});

  $self->render();
}

sub ajax_search {
  my $self = shift;

  my $search_term = $self->param('searchterm');
  my $search_term_type = $self->param('searchtermtype');

  my $twitter_model = $self->app->twitter();

  my $search_result = $twitter_model->search($search_term, $search_term_type);  

  $self->stash(search_results => $search_result);

  $self->render();
}

1;
