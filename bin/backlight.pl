#!/usr/bin/env perl
use Modern::Perl;

if ($#ARGV < 0) {
	die "You need to tell me what to do";
}

my $command = $ARGV[0];
my $step = 5;

my $xbacklight = "/usr/bin/xbacklight";
my $old_brightness = qx($xbacklight -get);
my $new_brightness;

for ($command) {
	if (/^up$/i) {
		for ($old_brightness) {
			if ($_ > (100-$step)) {
				$new_brightness = 100;
			} else {
				$new_brightness = $old_brightness+$step;
			}
		}
	} elsif (/^down$/i) {
		for ($old_brightness) {
			if ($_ < ($step+1)) {
				$new_brightness = 1;
			} else {
				$new_brightness = $old_brightness-$step;
			}
		}
	} elsif (/^toggle$/i) {
		for ($old_brightness) {
			if ($_ > 0) {
				$new_brightness = 1;
			} else {
				$new_brightness = 100;
			}
		}
	} else { die "invalid option"; }
}

my $result = qx($xbacklight -set $new_brightness);
