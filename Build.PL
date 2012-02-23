
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Cook your distributions with Dist::Zilla",
  "dist_author" => [
    "Jeffrey Ryan Thalhammer <jeff\@imaginative-software.com>"
  ],
  "dist_name" => "Dist-Zilla-Chef",
  "dist_version" => "0.003",
  "license" => "perl",
  "module_name" => "Dist::Zilla::Chef",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "App::cpanminus" => "1.5",
    "Dist::Zilla::App" => 0,
    "File::Path" => 0,
    "Moose::Autobox" => 0,
    "Pinto" => "0.030",
    "Pinto::Creator" => 0,
    "Version::Requirements" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
