package Dist::Zilla::Chef;

# ABSTRACT: Cook your distributions with Dist::Zilla

use strict;
use warnings;

#-------------------------------------------------------------------------------

our $VERSION = '0.001'; # VERSION

#-------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems cpan testmatrix url
annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata
placeholders

=head1 NAME

Dist::Zilla::Chef - Cook your distributions with Dist::Zilla

=head1 VERSION

version 0.001

=head1 DESCRIPTION

Dist::Zilla::Chef is a suite of L<Dist::Zilla> commands that help you
build & test your dist AND all of its dependencies.  The idea is to
use Dist::Zilla to establish a workflow for managing and testing
dependencies in isolation while your dist grows and evolves.

Dist::Zilla::Chef relies on L<Pinto> to create and manage a local
CPAN-like repository containing a snapshot of all the prerequisites
that are required by your dist.  As your code evolves, you can use the
Dist::Zilla::Chef commands to periodically load the repository with any
additional prerequisites that your dist needs.  At any time, you can
build your dist and all of its dependencies in isolation, thus giving
you a full test of your entire code stack.

This is alpha code.  It is just a proof of concept.  It could even be
a disproof of concept.  You have been warned.

=head1 WHY IT IS CALLED CHEF

In some ways, creating a dist is like cooking food, and you are the
chef!  Your dist has many ingredients (dependencies).  We store
these ingredients in a pantry (Pinto repository).  When we are
hungry for some code, we cook (build) our dist by combining it with
all of the necessary ingredients.

I know, the cooking metaphor isn't perfect.  But I needed a coherent
set of names for these command plugins.  The cooking metaphor seemed
reasonable.  Who knows, maybe it will get some traction.  Suggestions
are welcome.

=head1 HOW TO COOK

Here's the general workflow for using the Dist::Zilla::Chef commands.
For this example, suppose you are going to make a new distribution called
C<Frobulator>.  So you use L<dzil> to create the basic distribution
structure for you...

  $> dzil new Frobulator

Now we write some code.  Suppose you've decided that the C<Frobulator>
is going to use L<Dancer>.  We also add an C<ABSTRACT>, which is
required by Dist::Zilla...

  # in lib/Frobulator.pm
  package Frobulator;

  # ABSTRACT: Does stuff

  use Dancer;

And after a few minutes of coding, you have a few subroutines and
maybe a couple test scripts to accompany C<Frobulator>.  Now it is
time to cook!

First, you need to gather the "ingredients" for your distribution and
"stock" them in the "pantry"...

  dzil stock

L<Dancer> (and all of its dependencies) will now be "stocked" in
a CPAN-like repository in the F<pan> directory.  Now you can "cook"
your distribution and all of its dependencies together...

  dzil cook

This builds, tests, and installs your distribution into the F<dlib>
directory, along with all the dependencies.  The result is stashed
in the F<dlib> directory.

Now suppose you add a new dependency on L<Test::More>.  Once again,
we run the C<stock> command to gather any ingredients that are missing
from our pantry...

  dzil stock

And finally, we cook our distribution again...

  dzil cook

But this time, only the new dependencies need to be built, since the
C<dlib> directory still has all the dependencies from the last baking.

Over time, the C<dlib> directory may get crufty, or you just might
want to cook from scratch again.  In that case, you "scrub" your
work space to remove the C<dlib> directory...

  dzil scrub

Now the next time you cook, Dist::Zilla::Chef will assemble your
distribution and all of its dependencies again.

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Dist::Zilla::Chef

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/Dist-Zilla-Chef>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/Dist-Zilla-Chef>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/D/Dist-Zilla-Chef>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual way to determine what Perls/platforms PASSed for a distribution.

L<http://matrix.cpantesters.org/?dist=Dist-Zilla-Chef>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Dist::Zilla::Chef>

=back

=head2 Bugs / Feature Requests

L<https://github.com/thaljef/Dist-Zilla-Chef/issues>

=head2 Source Code


L<https://github.com/thaljef/Dist-Zilla-Chef>

  git clone git://github.com/thaljef/Dist-Zilla-Chef.git

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

