use strict;
use warnings;
use 5.10.0;

use Test::More;
use JSON qw(from_json);

my $module = $ENV{EXERCISM} ? 'Example' : 'Anagram';

my $cases_file = 'cases.json';
my $cases;
if (open my $fh, '<', $cases_file) {
    local $/ = undef;
    $cases = from_json scalar <$fh>;
} else {
    die "Could not open '$cases_file' $!";
}

note explain $cases;

ok -e "$module.pm", "$module.pm exists"
    or die "You need to create a class called $module.pm with an function called match() that gets the original word as the first parameter and a reference to a list of word to check. It should return a referene to a list of words.";

use_ok $module, "load $module.pm"
    or die "Does $module.pm compile?  Does it end with 1; ?";

can_ok($module, 'match')
    or die "Missing package $module; or missing sub match()";

my $sub = $module->can('match');

foreach my $c (@$cases) {
    is_deeply scalar $sub->($c->{word}, @{ $c->{words} }), $c->{expected}, $c->{name};
}

done_testing();
