package Dist::Zilla::App::Command::stock;

# ABSTRACT: stock the pantry with ingredients for your dist

use strict;
use warnings;

use Pinto 0.030;    # better Git support
use Pinto::Creator;
use Moose::Autobox;
use Dist::Zilla::App -command;
use Version::Requirements;

#-------------------------------------------------------------------------------

our $VERSION = '0.003'; # VERSION

#-------------------------------------------------------------------------------

sub opt_spec {

    return (

        [ author =>  'include author dependencies' ],

    );
}

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opt, $arg) = @_;

    my @phases = qw(build test configure runtime);
    push @phases, 'author' if $opt->{author};
    my @deps = $self->_extract_dependencies($self->zilla, \@phases);
    $self->_stock_pantry(@deps);

    return 1;
}

#-------------------------------------------------------------------------------

sub _extract_dependencies {
    my ($self, $zilla, $phases) = @_;

    $_->before_build for $zilla->plugins_with(-BeforeBuild)->flatten;
    $_->gather_files for $zilla->plugins_with(-FileGatherer)->flatten;
    $_->prune_files  for $zilla->plugins_with(-FilePruner)->flatten;
    $_->munge_files  for $zilla->plugins_with(-FileMunger)->flatten;
    $_->register_prereqs for $zilla->plugins_with(-PrereqSource)->flatten;

    my $req = Version::Requirements->new;
    my $prereqs = $zilla->prereqs;

    for my $phase (@$phases) {
        $req->add_requirements( $prereqs->requirements_for($phase, 'requires') );
        $req->add_requirements( $prereqs->requirements_for($phase, 'recommends') );
    }

    my @required = grep { $_ ne 'perl' } $req->required_modules;

    my @sorted = sort { lc $a cmp lc $b } @required;

    return @sorted;
}

#-------------------------------------------------------------------------------

sub _stock_pantry {
    my ($self, @deps) = @_;

    my $pan   = $self->_create_or_find_pantry();
    my $pinto = Pinto->new(root => $pan);
    $pinto->new_batch(noinit => 1, nocommit => 1);
    $pinto->add_action('Import', package_name => $_) for @deps;
    $pinto->run_actions();

    return;
}

#-------------------------------------------------------------------------------

sub _create_or_find_pantry {
    my ($self) = @_;

    my $pan = $self->zilla->root->subdir('pan');
    return $pan if -e $pan;

    my $store = -e $self->zilla->root->subdir('.svn') ? 'Pinto::Store::VCS::Svn'
              : -e $self->zilla->root->subdir('.git') ? 'Pinto::Store::VCS::Git'
              : 'Pinto::Store::File';

    my $creator = Pinto::Creator->new(root => $pan);
    $creator->create(noinit => 1, store => $store);

    return $pan;
}

#-------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Dist::Zilla::App::Command::stock - stock the pantry with ingredients for your dist

=head1 VERSION

version 0.003

=head1 SYNOPSIS

  dzil stock

=head1 DESCRIPTION

This L<Dist::Zilla> command "stocks" the "pantry" with all the
ingredients for your distribution.  More specifically, the C<stock>
command extracts the dependencies from your distribution and uses
L<Pinto> to import all of them into a local CPAN-like repository in
the F<pan> directory.  As your distribution evolves and accumulates
more dependencies, you can run the C<stock> command again to "stock"
the additional ingredients.

=head1 ARGUMENTS

None.

=head1 OPTIONS

=over 4

=item --author

Also stock author-time dependencies in the pantry.

=back

=head1 NOTES

The easiest way to declare your dependencies is to use the
L<Dist::Zilla::Plugin::AutoPrereqs> plugin, which automatically
discovers dependencies by examining your code.  To use the plugin,
add this to your F<dist.ini> file, like so...

  [AutoPrereqs]

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

