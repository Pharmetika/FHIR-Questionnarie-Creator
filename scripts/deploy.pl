#!/usr/bin/perl
use v5.28;

use strict;
use strict;
use warnings;
use File::Find;

my $deploy_option = $ARGV[0];
my $cli_message='';
my $deployment_path;

if ($deploy_option eq "base") {
$deployment_path = 'fhir_questionnaire';
}
else {
    print("$deploy_option is not a valid deployment option. Please choose from base\n");
    exit;
}
# Compress built directory

my @files;
my $start_directory = 'dist';  # top level dir to search
find( 
    sub { push @files, $File::Find::name unless -d; }, 
    $start_directory
);
for my $file (@files) {
    next unless $file =~ m/\.(css|html|gif|json|js|txt|svg)$/;
    say "compressing $file";
    `brotli -kZ $file`;
    `zstd -z -12 $file`;
}
#`./scripts/compress_dist.sh`;

`tar --zstd -cf dist.tar.zst dist/;`;
`scp dist.tar.zst base4:/www/dist.tar.zst;`;
`scp dist.tar.zst base6:/www/dist.tar.zst;`;
`scp dist.tar.zst base8:/www/dist.tar.zst;`;
`rm -rdf dist;`;
`rm dist.tar.zst;`;
`ssh base4 'cd /www && tar --zstd -xf dist.tar.zst';`;
`ssh base4 'cd /www && rm -rdf $deployment_path.last && mv $deployment_path $deployment_path.last';`;
`ssh base4 'cd /www &&  mv dist $deployment_path;'`;
`ssh base4 'cd /www && unlink $deployment_path/old; ln -s /www/$deployment_path.last /www/$deployment_path/old;'`;
`ssh base4 'cd /www && rm dist.tar.zst;'`;

`ssh base6 'cd /www && tar --zstd -xf dist.tar.zst';`;
`ssh base6 'cd /www && rm -rdf $deployment_path.last && mv $deployment_path $deployment_path.last';`;
`ssh base6 'cd /www && mv dist $deployment_path;'`;
`ssh base6 'cd /www && unlink $deployment_path/old; ln -s /www/$deployment_path.last /www/$deployment_path/old;'`;
`ssh base6 'cd /www && rm dist.tar.zst;'`;

`ssh base8 'cd /www && tar --zstd -xf dist.tar.zst';`;
`ssh base8 'cd /www && rm -rdf $deployment_path.last && mv $deployment_path $deployment_path.last';`;
`ssh base8 'cd /www &&  mv dist $deployment_path;'`;
`ssh base8 'cd /www && unlink $deployment_path/old; ln -s /www/$deployment_path.last /www/$deployment_path/old;'`;
`ssh base8 'cd /www && rm dist.tar.zst;'`;


