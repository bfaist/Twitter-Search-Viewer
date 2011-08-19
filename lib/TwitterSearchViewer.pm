package TwitterSearchViewer;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc" (this plugin requires Perl 5.10)
  $self->plugin('pod_renderer');

  $self->secret('perlrocks');

  my $config = $self->plugin( 'json_config' => { file=>'config.json' } );

  # Routes
  my $r = $self->routes;

  # Normal route to controller
  $r->route('/')->to(controller => 'page', action => 'display');
  $r->route('/ajax/:searchtermtype/:searchterm')->to(controller => 'page', action => 'ajax_search');

  Mojo::Loader->load('TwitterSearchViewer::TwitterModel');

  my $twitter_model = TwitterSearchViewer::TwitterModel->new();
  die "Twitter model invocation failure" unless $twitter_model;
  $twitter_model->init();

  $self->attr(twitter => sub { return $twitter_model; }); 
  $self->attr(config => sub { return $config; });
}

1;
