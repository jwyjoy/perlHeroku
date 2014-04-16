use strict;
use warnings;
use utf8;
use File::Spec;
use File::Basename;
use lib File::Spec->catdir(dirname(__FILE__), 'extlib', 'lib', 'perl5');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use Amon2::Lite;
use DBIx::Sunny;
use Digest::MurmurHash qw(murmur_hash);
use HTTP::Status qw(:constants :is status_message);
use Plack::Request;

sub db {
    my $self = shift;
    return $self->{db} ||= $self->_db_connect;
}

sub _db_connect {
    my $self = shift;

    my $config = $self->config;


    #my $dbh = DBIx::Sunny->connect();

    return $dbh;
}

__PACKAGE__->load_plugins(qw/Web::JSON/);

our $VERSION = '0.12';

# put your configuration here
sub load_config {
    my $c = shift;

    my $mode = $c->mode_name || 'development';

    +{
        'DBI' => [
            "dbi:SQLite:dbname=$mode.db",
            '',
            '',
        ],
    }
}

get '/' => sub {
    my $c = shift;

    my $db = $c->db;
    my $row = $db->select_row(
             q{SELECT * FROM books where id=100}
         );

         #   return $c->render_json($row);

    #return $c->render_json(+{foo => 'bar'});
     return $c->render('index.tt');
};
post '/user/register' => sub {
    my $c = shift;
    my $username= $c->req->param('username');
    my $password= $c->req->param('password');

    my $db = $c->db;
    my $txn = $db->txn_scope;
    $db->query(
               q{INSERT INTO userdata (username,password,api_key) VALUES ( ? , ?,'a')},
               $username, $password,
            );
    my $last_id = $db->last_insert_id;
    $txn->commit;
    
    $c->create_response(409,[] ,[] );
    return $c->redirect('/');
};
post '/admin/reset' => sub {
    my $c = shift;

    my $db = $c->db;
    my $txn = $db->txn_scope;

    $db->query(
         q{Delete FROM userdata},
        );

        my $last_id = $db->last_insert_id;
         $txn->commit;

    $c->create_response(204,[] ,[] );
    ## 204
    #my $req = Plack::Request->new($c);
    # my $path_info = $req->path_info;
    # my $query     = $req->param('query');

    # my $res = $req->new_response(204);
    #return $c->redirect('/');
};

# load plugins
# __PACKAGE__->load_plugin('DBI');
# __PACKAGE__->load_plugin('Web::FillInFormLite');
# __PACKAGE__->load_plugin('Web::JSON');
    
__PACKAGE__->enable_session();

__PACKAGE__->to_app(handle_static => 1);

__DATA__

@@ index.tt
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>HLite</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="[% uri_for('/static/js/main.js') %]"></script>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="[% uri_for('/static/css/main.css') %]">
</head>
<body>
    <div class="container">
        <header><h1>HLite</h1></header>
        <section class="row">
            This is a HLite
        </section>
        <footer>Powered by <a href="http://amon.64p.org/">Amon2::Lite</a></footer>
    </div>
</body>
</html>

@@ /static/js/main.js

@@ /static/css/main.css
footer {
    text-align: right;
}
