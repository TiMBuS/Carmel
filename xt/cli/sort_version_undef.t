use strict;
use Test::More;
use xt::CLI;

subtest 'dependency on subdep with version 0' => sub {
    my $app = cli();

    $app->run('install', 'Module::CPANfile');
    $app->run('install', 'Module::CPANfile@1.0002'); 

    $app->write_cpanfile(<<EOF);
requires 'Module::CPANfile::Environment';
EOF

    $app->run("install");
    $app->run("show", "Module::CPANfile");

    unlike $app->stdout, qr!Module::CPANfile \(1\.0002! or diag $app->stderr;
};

done_testing;
