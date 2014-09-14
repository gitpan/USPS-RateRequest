use strict;
use Test::More;
use lib '../lib';
use Box::Calc;
use Data::Printer;
use 5.010;

my $user_id  = $ENV{USPS_USERID};
my $password = $ENV{USPS_PASSWORD};

if (!$user_id || !$password) {
    plan skip_all => 'Missing USPS_USERID or USPS_PASSWORD';
}

use_ok 'USPS::RateRequest';

my $calc = Box::Calc->new();
$calc->add_box_type({
    x => 12,
    y => 12,
    z => 5.75,
    weight => 10,
    name => 'A',
});
$calc->add_item(2,
    x => 8,
    y => 8,
    z => 5.75,
    name => 'small pumpkin',
    weight => 66,
);
$calc->pack_items;

ok 1;
my $rate = USPS::RateRequest->new(
    user_id     => $user_id,
    password    => $password,
    from        => 53716,
    to          => 90210,
    debug       => 1,
);
my $rates = $rate->request_rates($calc->boxes)->recv;

my $rate = USPS::RateRequest->new(
    user_id     => $user_id,
    password    => $password,
    from        => 53716,
    to          => 60642,
    debug       => 1,
);
my $rates = $rate->request_rates($calc->boxes)->recv;

done_testing();

