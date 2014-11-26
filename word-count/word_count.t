use strict;
use warnings;
use 5.10.0;

use open ':std', ':encoding(utf8)';
use utf8;

use Test::More;

my $module = $ENV{EXERCISM} ? 'Example' : 'Phrase';

my @cases = (
    # input                                       expected output                  title
    ['word',                                      {word =>  1},                     'one word'],
    ['one of each',                               {one => 1, of => 1, each => 1},   'one of each'],
    ['one fish two fish red fish blue fish',
            {one => 1, fish => 4, two => 1, red => 1, blue => 1},                   'multiple occurences'],
    ['car : carpet as java : javascript!!&@$%^&',
            {car => 1, carpet => 1, as => 1, java => 1, javascript => 1},           'ignore punctuation'],
    ['testing, 1, 2 testing',                     {testing => 2, 1 => 1, 2 => 1},   'include numbers'],
    ['go Go GO',                                  {go => 3},                        'normalize case'],
);

ok -e "$module.pm", "$module.pm exists"
    or die "You need to create a module called $module.pm with a function called word_count() that gets one parameter: the text in which to count the words.";

use_ok $module, "can load $module.pm"
    or die "Does $module.pm compile?  Does it end with 1; ?";

can_ok $module, 'word_count'
    or die "Missing package Phrase; or missing sub word_count()";

my $sub = $module->can('word_count');

foreach my $c (@cases) {
    is_deeply scalar $sub->($c->[0]), $c->[1], $c->[2];
}

done_testing();
