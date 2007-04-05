package Acme::POE::Acronym::Generator;

use strict;
use Math::Random;
use vars qw($VERSION);

$VERSION = '0.99';

sub new {
  my $package = shift;
  my %opts = @_;
  $opts{lc $_} = delete $opts{$_} for keys %opts;
  $opts{dict} = '/usr/share/dict/words' unless $opts{dict};
  my $self = bless \%opts, $package;
  if ( -e $opts{dict} ) {
	open my $fh, "<", $self->{dict} or die "$!\n";
	while (<$fh>) {
	   chomp;
	   next unless /^[poe]\w+$/;
	   push @{ $self->{words}->{ substr($_,0,1) } }, $_;
	}
	close $fh;
  }
  else {
	$self->{words} = 
	{
	   'p' => [ qw(pickle purple parallel pointed pikey) ],
	   'o' => [ qw(orange oval ostrich olive) ],
	   'e' => [ qw(event enema evening elephant) ],
	}
  }
  return $self;
}

sub generate {
  my $self = shift;
  my $words = $self->{words};
  my @poe;
  push @poe, 
	ucfirst( $words->{$_}->[ scalar random_uniform_integer(1,0,$#{ $words->{$_} } ) ] ) for qw(p o e);
  return wantarray ? @poe : join( ' ', @poe );
}

1;
__END__

=head1 NAME

Acme::POE::Acronym::Generator - Generate random POE acronyms.

=head1 SYNOPSIS

  use strict;
  use Acme::POE::Acronym::Generator;

  my $poegen = Acme::POE::Acronym::Generator->new();

  for ( 1 .. 10 ) {
    my $acronym = $poegen->generate(); 
    print $acronym, "\n";
  }

=head1 DESCRIPTION

What does POE stand for?" is a common question, and people have expanded the acronym in several ways.

Acme::POE::Acronym::Generator produces randomly generated expansions of the POE acronym.

=head1 CONSTRUCTOR

=over

=item new

Takes one optional parameter:

  'dict', the path to the words file to use, default is /usr/share/dict/words;

If the dict file doesn't exist it will use a very small subset of words to generate responses.

Returns a shiny Acme::POE::Acronym::Generator object.

=back

=head1 METHODS

=over

=item generate

Takes no parameters. 

In a scalar context, returns a string containing the acronym. 

In a list context, returns the individual words of the acronym as a list.

=back

=head1 AUTHOR

Chris C<BinGOs> Williams <chris@bingosnet.co.uk>

=head1 SEE ALSO

L<http://poe.perl.org/?What_POE_Is>

