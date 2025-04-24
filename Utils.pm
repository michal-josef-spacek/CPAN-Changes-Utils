package CPAN::Changes::Utils;

use base qw(Exporter);
use strict;
use warnings;

use List::Util qw(max min);
use Readonly;

# Constants.
Readonly::Array our @EXPORT => qw(construct_copyright_years);

our $VERSION = 0.01;

sub construct_copyright_years {
	my $changes = shift;

	my $copyright_years;
	my @years = map { $_->date =~ m/^(\d{4})/ms; defined $1 ? $1 : () }
		grep { defined $_ && defined $_->date }
		$changes->releases;
	my $year_from = min(@years);
	my $year_to = max(@years);
	if (defined $year_from) {
		$copyright_years = $year_from;
		if ($year_from != $year_to) {
			$copyright_years .= '-'.$year_to;
		}
	}

	return $copyright_years;
}

1;

__END__
