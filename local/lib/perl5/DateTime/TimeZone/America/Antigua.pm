# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/Qd5wmh7n8P/northamerica.  Olson data version 2014a
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Antigua;
$DateTime::TimeZone::America::Antigua::VERSION = '1.65';
use strict;

use Class::Singleton 1.03;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Antigua::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY, #    utc_start
60310584432, #      utc_end 1912-03-02 04:07:12 (Sat)
DateTime::TimeZone::NEG_INFINITY, #  local_start
60310569600, #    local_end 1912-03-02 00:00:00 (Sat)
-14832,
0,
'LMT',
    ],
    [
60310584432, #    utc_start 1912-03-02 04:07:12 (Sat)
61536085200, #      utc_end 1951-01-01 05:00:00 (Mon)
60310566432, #  local_start 1912-03-01 23:07:12 (Fri)
61536067200, #    local_end 1951-01-01 00:00:00 (Mon)
-18000,
0,
'EST',
    ],
    [
61536085200, #    utc_start 1951-01-01 05:00:00 (Mon)
DateTime::TimeZone::INFINITY, #      utc_end
61536070800, #  local_start 1951-01-01 01:00:00 (Mon)
DateTime::TimeZone::INFINITY, #    local_end
-14400,
0,
'AST',
    ],
];

sub olson_version { '2014a' }

sub has_dst_changes { 0 }

sub _max_year { 2024 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;

