use strict;
use warnings;

use Test::More;
use MetaCPAN::Server::Test;

my $model = model();
my $idx   = $model->index('cpan');

my %modules = (
    'Versions::PkgVar'              => '1.23',
    'Versions::Our'                 => '1.45',
    'Versions::PkgNameVersion'      => '1.67',
    'Versions::PkgNameVersionBlock' => '1.89',
);

while ( my ( $module, $version ) = each %modules ) {

    ok( my $file = $idx->type('file')->find($module), "find $module" )
        or next;

    ( my $path = "lib/$module.pm" ) =~ s/::/\//;
    is( $file->path, $path, 'expected path' );

    # Check module version (different than dist version).
    is( $file->module->[0]->version, $version, 'version parsed from file' );

}

done_testing;
