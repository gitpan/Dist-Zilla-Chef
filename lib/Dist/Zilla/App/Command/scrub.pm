package Dist::Zilla::App::Command::scrub;

# ABSTRACT: thoroughly clean your kitchen

use strict;
use warnings;

use File::Path;
use Dist::Zilla::App -command;

#-------------------------------------------------------------------------------

our $VERSION = '0.001'; # VERSION

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opt, $arg) = @_;

    $self->zilla->clean;
    my $dlib = $self->zilla->root->subdir('dlib');
    File::Path::rmtree($dlib->stringify()) if -e $dlib;

    return;
}

#-------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Dist::Zilla::App::Command::scrub - thoroughly clean your kitchen

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  dzil scrub

=head1 DESCRIPTION

This L<Dist::Zilla> command "scrubs" your work space to a clean state
by removing any dependencies that have been installed F<dlib>
directory, thus forcing the next cooking to be done from scratch.

You should periodically C<scrub> your work space to remove any
dependencies that are no longer needed.  But you don't need to do it
every time you cook, or your code/build/test cycles will be unbearably
long.

=head1 ARGUMENTS

None.

=head1 OPTIONS

None

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

