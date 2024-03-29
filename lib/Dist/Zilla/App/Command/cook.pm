package Dist::Zilla::App::Command::cook;

# ABSTRACT: build and test your dist from scratch

use strict;
use warnings;

use Dist::Zilla::App -command;

#-------------------------------------------------------------------------------

our $VERSION = '0.003'; # VERSION

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opt, $arg) = @_;

    my $dlib = $self->zilla->root->subdir('dlib');
    my $pan  = 'file://' . $self->zilla->root->subdir('pan')->absolute();
    my $archive = $self->zilla->build_archive();

    system( qw(cpanm --mirror-only --mirror), $pan, '-L', $dlib, $archive );

    return;
}

#-------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Dist::Zilla::App::Command::cook - build and test your dist from scratch

=head1 VERSION

version 0.003

=head1 SYNOPSIS

  dzil cook

=head1 DESCRIPTION

This L<Dist::Zilla> command "cooks" your distribution from scratch.
It builds, tests, and installs, your distribution and all of its
dependencies in a sandbox using L<cpanm> and L<local::lib>.  The
dependencies are pulled from the local L<Pinto> repository in the
f<pan> directory, and the resulting build is placed in the F<dlib>
directory.

Baking a distribution is equivalent to installing your distribution
against a virgin Perl with the CPAN toolchain.  The resulting F<dlib>
will contain your distribution and its entire dependency stack.  In
theory, you could then deploy this directory as an isolated
application or component.

=head1 ARGUMENTS

None.

=head1 OPTIONS

None.

=head1 NOTES

Before you can cook a distribution, you need to stock up on the
necessary ingredients (i.e. dependencies).  To do that, use the
C<stock> command.

The F<dlib> directory is preserved after each baking.  But if the
F<dlib> directory gets crufty, use the C<scrub> command to erase it,
and the next baking will start from scratch.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

