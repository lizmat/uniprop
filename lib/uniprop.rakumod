# Hooks for export
my &int;
my &bool;
my &str;

#-------------------------------------------------------------------------------
my constant MoarVM = Q:to/CODE/;
use nqp;
&int = proto sub uniprop-int(|) {*}
multi sub uniprop-int(Str:D $str, Stringy:D $propname) {
    $str ?? uniprop-int($str.ord, $propname) !! Nil }
multi sub uniprop-int(Int:D $code, Stringy:D $propname) {
    nqp::getuniprop_int($code,nqp::unipropcode($propname));
}

&bool = proto sub uniprop-bool(|) {*}
multi sub uniprop-bool(Str:D $str, Stringy:D $propname) {
    $str ?? uniprop-bool($str.ord, $propname) !! Nil
}
multi sub uniprop-bool(Int:D $code, Stringy:D $propname) {
    nqp::hllbool(nqp::getuniprop_bool($code,nqp::unipropcode($propname)));
}

&str = proto sub uniprop-str(|) {*}
multi sub uniprop-str(Str:D $str, Stringy:D $propname) {
    $str ?? uniprop-str($str.ord, $propname) !! Nil
}
multi sub uniprop-str(Int:D $code, Stringy:D $propname) {
    nqp::getuniprop_str($code,nqp::unipropcode($propname));
}
CODE

#-------------------------------------------------------------------------------
my constant JVM = Q:to/CODE/;
&int  = sub uniprop-int(|)  { die 'uniprop-int NYI on jvm backend' }
&bool = sub uniprop-bool(|) { die 'uniprop-bool NYI on jvm backend' }
&str  = sub uniprop-str(|)  { die 'uniprop-str NYI on jvm backend' }
CODE

#-------------------------------------------------------------------------------
my constant JS = Q:to/CODE/;
&int  = sub uniprop-int(|)  { die 'uniprop-int NYI on js backend' }
&bool = sub uniprop-bool(|) { die 'uniprop-bool NYI on js backend' }

use nqp;
&str = proto sub uniprop-str(|) {*}
multi sub uniprop-str(Str:D $str, Stringy:D $propname) {
    $str ?? uniprop-str($str.ord, $propname) !! Nil
}
multi sub uniprop-str(Int:D $code, Stringy:D $propname) {
    nqp::getuniprop_str($code,nqp::unipropcode($propname));
}
CODE

#-------------------------------------------------------------------------------
BEGIN {
    unless ::("&uniprop-int") {
        given $*VM.name {
            when "moar" { MoarVM.EVAL }
            when "jvm"  { JVM.EVAL    }
            when "js"   { JS.EVAL     }
            default {
                die "Unexpected backend name: $_"
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub EXPORT() {
    ::("&uniprop-int")
      ?? Map.new()
      !! Map.new:
           '&uniprop-int'  => &int<>,
           '&uniprop-bool' => &bool<>,
           '&uniprop-str'  => &str<>,
}

=begin pod

=head1 NAME

uniprop - Provide uniprop- subs

=head1 SYNOPSIS

=begin code :lang<raku>

use uniprop;  # provide uniprop-int, uniprop-bool, unitprop-str

=end code

=head1 DESCRIPTION

The C<uniprop> distribution provides 3 subroutines that used to live in
the Rakudo core, but were in fact implementation detail / used for testing
by core developers only.  These have since then been removed from Rakudo.

This distribution has captured the code of these subroutines and will export
them in any version of Rakudo that has them removed.

No further documentation is provided, as originally no additional documentation
was provided and it was never the intention to expose this functionality this
way.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/uniprop . Comments and
Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2022, 2024 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
