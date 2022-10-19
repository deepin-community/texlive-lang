#
# ptex-fontmaps-tlpost.pl:
#   Post action for ptex-fontmaps to link or copy files for TeX Live tlgs
# https://gist.github.com/trueroad/d5468b8d0f93e8082c20c59964792a90
#
# Copyright (C) 2020 Masamichi Hosoda.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

use strict;
use warnings;
use utf8;
use feature 'state';
use Encode;

my $verbose = 0;

if (win32 ()) {
    # These packages are not necessarily available on non-Windows, so
    # read them at runtime instead of compile time.
    require Encode::Locale;
    Encode::Locale->import ();

    # ':encoding(console_{in|out})' requires Encode::Locale package.
    binmode (STDIN, ':encoding(console_in)');
    binmode (STDOUT, ':encoding(console_out)');
    binmode (STDERR, ':encoding(console_out)');

    require Win32::API;
    Win32::API->import ();
    require File::Compare;
    File::Compare->import ();
} else {
    # for non-Windows, silently do nothing, to avoid tl-update-tlnet failure.
    exit 0;
}

# CMap list for install
my @cmap_list_install = ('2004-H', '2004-V');

my $mode = lc (decode ('locale', $ARGV[0]));
my $texdir = decode ('locale', $ARGV[1]);

unshift (@INC, "$texdir/tlpkg");
require TeXLive::TLUtils;

my_log ("ptex-fontmaps-tlpost\n");

my $resourcedir = "$texdir/tlpkg/tlgs/Resource";
my $cmapdir = "$resourcedir/CMap";

if ($mode eq 'install') {
    do_install();
} elsif ($mode eq 'remove') {
    do_remove();
} else {
    die ("unknown mode: $mode\n");
}

my_log ("\ndone.\n");

exit 0;

# Install
sub do_install {
    my_log ("\ndo_install\n");

    tlgs_check ();

    install_cmap ();
}

# Remove
sub do_remove {
    my_log ("\ndo_remove\n");

    tlgs_check ();

    remove_cmap ();
}

# tlgs directories existence check
sub tlgs_check {
    wrapper_isdir ($resourcedir) or
        die ("Not found: tlgs Resource directory: ${resourcedir}\n");

    wrapper_isdir ($cmapdir) or
        die ("Not found: tlgs CMap directory: ${cmapdir}\n");
}

# Link or copy CMap
sub install_cmap {
    my_log ("\ninstall_cmap\n");

    foreach my $cmapname (@cmap_list_install) {
        my_log ("\nFor $cmapname ...\n");

        my $cmappath_in_texmf = search_cmappath ($cmapname);
        if (! $cmappath_in_texmf) {
            my_log ("Not found: CMap in TEXMF: $cmapname\n");
            next;
        }

        my $cmappath_in_cmapdir = "$cmapdir/$cmapname";
        if (wrapper_isfile ($cmappath_in_cmapdir)) {
            my_log ("Already exists: ${cmappath_in_cmapdir}\n");
            if (file_compare ($cmappath_in_texmf, $cmappath_in_cmapdir)) {
                my_log ("Different from the file in TEXMF. Deleting.\n");
                wrapper_unlink ($cmappath_in_cmapdir);
            } else {
                my_log ("Same as the file in TEXMF. Skipping.\n");
                next;
            }
        }

        link_or_copy ($cmappath_in_texmf, $cmappath_in_cmapdir);
    }
}

# Remove CMap
sub remove_cmap {
    my_log ("\nremove_cmap\n");

    for my $cmapname (@cmap_list_install) {
        my_log ("\nFor $cmapname ...\n");

        my $cmappath_in_cmapdir = "$cmapdir/$cmapname";
        if (wrapper_isfile ($cmappath_in_cmapdir)) {
            wrapper_unlink ($cmappath_in_cmapdir);
            my_log ("Removed: ${cmappath_in_cmapdir}\n");
        } else {
            my_log ("Not exist: ${cmappath_in_cmapdir}\n");
        }
    }
}

# Check Windows environment
sub win32 { return ($^O=~/^MSWin(32|64)$/i); }

# Log
sub my_log {
    my ($msg) = @_;

    print $msg if ($verbose);
    TeXLive::TLUtils::log ($msg);
}

# Warn
sub my_warn {
    my ($msg) = @_;

    TeXLive::TLUtils::tlwarn ($msg);
}

# Search TEXMF CMap path
sub search_cmappath {
    my ($cmapname) = @_;

    my $foo = kpsewhich ("-format=cmap $cmapname");

    if ($foo eq "") {
        my_log ("Not found CMap path: ${cmapname}\n");
        return;
    }

    my_log ("CMap path is ${foo}.\n");
    return $foo;
}

# Invoke kpsewhich
sub kpsewhich {
    my ($name) = @_;

    # We use perl's active code page for invoking kpsewhich
    # because perl passes the command line string to the invoking API.
    my $cmdline = encode ('locale', "kpsewhich $name");
    chomp (my $result = `$cmdline`);

    # !!!FIXME!!!
    # We can not know the character code output by kpsewhich.
    # So we assume that it is the same as perl's active code page.
    # The active code pages for perl and kpsewhich may be different,
    # in which case non-US-ASCII characters are garbled.
    # There is no problem when the path name contains only US-ASCII.
    $result = decode ('locale', $result);

    return $result;
}

# Try symbolic link, hard link, copy
sub link_or_copy {
    my ($existingfilename, $newfilename) = @_;

    if (wrapper_symlink ($existingfilename, $newfilename)) {
        my_log ("Symbolic link succeeded: ${newfilename}\n");
        return;
    }

    if (wrapper_hardlink ($existingfilename, $newfilename)) {
        my_log ("Hard link succeeded: ${newfilename}\n");
        return;
    }

    if (wrapper_copy ($existingfilename, $newfilename)) {
        my_log ("Copy succeeded: ${newfilename}\n");
        return;
    }

    my_warn ("Link/copy failed: ${newfilename}\n");
}

# File compare
sub file_compare {
    my ($filename1, $filename2) = @_;

    # TODO: Compare file by -W API on Windows
    my $result = compare (encode ('locale_fs', $filename1),
                          encode ('locale_fs', $filename2));
    if ($result == -1) {
        die ("File compare failed: ${filename1}, ${filename2}\n");
    }

    return $result;
}

# Directory existence check
sub wrapper_isdir {
    my ($dirname) = @_;

    # TODO: Directory existence check by -W API on Windows
    if ( -d encode ('locale_fs', $dirname) ) {
        return 1;
    }

    return;
}

# File existence check
sub wrapper_isfile {
    my ($filename) = @_;

    # TODO: File existence check by -W API on Windows
    if ( -f encode ('locale_fs', $filename) ) {
        return 1;
    }

    return;
}

# Remove file
sub wrapper_unlink {
    my ($filename) = @_;

    # TODO: Remove file by -W API on Windows
    return unlink (encode ('locale_fs', $filename));
}

# Create symbolic link
sub wrapper_symlink {
    my ($existingfilename, $newfilename) = @_;

    # We use CreateSymbolicLinkW API directly for creating symbolic link
    # because perl's symlink function may not work in Windows.
    state $createsymboliclinkw = load_createsymboliclinkw ();

    $existingfilename =~ s|/|\\|g;
    $newfilename =~ s|/|\\|g;

    my $r = $createsymboliclinkw->Call (
        encode ('UTF-16LE', $newfilename),
        encode ('UTF-16LE', $existingfilename),
        0
        );
    if (ord($r) != 0) {
        return 1;
    }
    my $msg = decode ('locale',
                      Win32::FormatMessage (Win32::GetLastError ()));
    $msg =~ s/[\r\n]+\z//;
    my_log ("CreateSymbolicLinkW failed: ${msg}\n");

    return 0;
}

# Create hard link
sub wrapper_hardlink {
    my ($existingfilename, $newfilename) = @_;

    # We use CreateHardLinkW API directly for creating hard link
    # because -W API is not affected by the perl's active code page.
    state $createhardlinkw = load_createhardlinkw ();

    $existingfilename =~ s|/|\\|g;
    $newfilename =~ s|/|\\|g;

    my $r = $createhardlinkw->Call (
        encode ('UTF-16LE', $newfilename),
        encode ('UTF-16LE', $existingfilename),
        0
        );
    if ($r) {
        return 1;
    }
    my $msg = decode ('locale',
                      Win32::FormatMessage (Win32::GetLastError ()));
    $msg =~ s/[\r\n]+\z//;
    my_log ("CreateHardLinkW failed: ${msg}\n");

    return 0;
}

# Copy file
sub wrapper_copy {
    my ($existingfilename, $newfilename) = @_;

    # We use CopyFileW API directly for copying file
    # because -W API is not affected by the perl's active code page.
    state $copyfilew = load_copyfilew ();

    $existingfilename =~ s|/|\\|g;
    $newfilename =~ s|/|\\|g;

    my $r = $copyfilew->Call (
        encode ('UTF-16LE', $existingfilename),
        encode ('UTF-16LE', $newfilename),
        1
        );
    if ($r) {
        return 1;
    }
    my $msg = decode ('locale',
                      Win32::FormatMessage (Win32::GetLastError ()));
    $msg =~ s/[\r\n]+\z//;
    my_log ("CopyFileW failed: ${msg}\n");

    return 0;
}

# Load CreateSymbolicLinkW API
sub load_createsymboliclinkw {
    my $createsymboliclinkw = Win32::API::More->new (
        'kernel32.dll',
        'BOOLEAN CreateSymbolicLinkW(
           LPCWSTR lpSymlinkFileName,
           LPCWSTR lpTargetFileName,
           DWORD   dwFlags
         )'
        ) or die ('Failed: Win32::API::More->new CreateSymbolicLinkW');

    return $createsymboliclinkw;
}
# Load CreateHardLinkW API
sub load_createhardlinkw {
    my $createhardlinkw = Win32::API::More->new (
        'kernel32.dll',
        'BOOL CreateHardLinkW(
           LPCWSTR  lpFileName,
           LPCWSTR  lpExistingFileName,
           UINT_PTR lpSecurityAttributes
          )'
        ) or die ('Failed: Win32::API::More->new CreateHardLinkW');

    return $createhardlinkw;
}

# Load CopyFileW API
sub load_copyfilew {
    my $copyfilew = Win32::API::More->new (
        'kernel32.dll',
        'BOOL CopyFileW(
           LPCWSTR lpExistingFileName,
           LPCWSTR lpNewFileName,
           BOOL    bFailIfExists
         )'
        ) or die ('Failed: Win32::API::More->new CopyFileW');

    return $copyfilew;
}
