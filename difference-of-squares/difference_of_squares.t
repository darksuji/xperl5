use strict;
use warnings;
use 5.10.0;

use Test::More;

my $module = $ENV{EXERCISM} ? 'Example' : 'Squares';
sanity_check($module, qw/new sum_of_squares square_of_sums difference/);

my @cases = (
    { num => 5, square => 225, sum => 55, diff => 170 },
    { num => 10, square => 3025, sum => 385, diff => 2640 },
    { num => 100, square => 25_502_500, sum => 338_350, diff => 25_164_150 },
);

for my $c (@cases) {
    is $module->new($c->{num})->square_of_sums, $c->{square},
        "square_of_sums($c->{num})";
    is $module->new($c->{num})->sum_of_squares, $c->{sum},
        "sum_of_squares($c->{num})";
    is $module->new($c->{num})->difference, $c->{diff},
        "difference($c->{num})";
}

done_testing();

sub sanity_check {
    my ($module, @subs) = @_;

    ok -e "$module.pm", "$module.pm exists"
        or die "Cannot find $module.pm.  Does it exist?";

    use_ok $module, "can load module"
        or die "Cannot load $module.  Does it compile?  Does it end with `1;`?";

    can_ok $module, @subs
        or die "Missing package $module or missing sub(s)";
}
