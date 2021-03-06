#!/usr/bin/env perl

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

use utf8;
use warnings;
use FindBin qw($RealBin);
use strict;
use Time::HiRes;

if  (eval {require Thread;1;}) {
  #module loaded
  Thread->import();
}

my $mydir = "$RealBin/";

my $HELP = 0;
my $NUM_THREADS = 1;
my $NUM_SENTENCES_PER_THREAD = 100000;


while (@ARGV)
{
	$_ = shift;
	/^-b$/ && ($| = 1, next);
	/^-h$/ && ($HELP = 1, next);
  # Option to add list of regexps to be protected
  	/^-threads$/ && ($NUM_THREADS = int(shift), next);
	/^-lines$/ && ($NUM_SENTENCES_PER_THREAD = int(shift), next);
}

# print help message
if ($HELP)
{
	print "Usage ./deescape-and-remove-nonprint.pl (-threads 4) < textfile > charfile\n";
        print "Options:\n";
	exit;
}

my @batch_sentences = ();
my @thread_list = ();
my $count_sentences = 0;

if ($NUM_THREADS > 1)
{# multi-threading tokenization
    while(<STDIN>)
    {
        $count_sentences = $count_sentences + 1;
        push(@batch_sentences, $_);
        if (scalar(@batch_sentences)>=($NUM_SENTENCES_PER_THREAD*$NUM_THREADS))
        {
            # assign each thread work
            for (my $i=0; $i<$NUM_THREADS; $i++)
            {
                my $start_index = $i*$NUM_SENTENCES_PER_THREAD;
                my $end_index = $start_index+$NUM_SENTENCES_PER_THREAD-1;
                my @subbatch_sentences = @batch_sentences[$start_index..$end_index];
                my $new_thread = new Thread \&tokenize_batch, @subbatch_sentences;
                push(@thread_list, $new_thread);
            }
            foreach (@thread_list)
            {
                my $tokenized_list = $_->join;
                foreach (@$tokenized_list)
                {
                    print $_;
                }
            }
            # reset for the new run
            @thread_list = ();
            @batch_sentences = ();
        }
    }
    # the last batch
    if (scalar(@batch_sentences)>0)
    {
        # assign each thread work
        for (my $i=0; $i<$NUM_THREADS; $i++)
        {
            my $start_index = $i*$NUM_SENTENCES_PER_THREAD;
            if ($start_index >= scalar(@batch_sentences))
            {
                last;
            }
            my $end_index = $start_index+$NUM_SENTENCES_PER_THREAD-1;
            if ($end_index >= scalar(@batch_sentences))
            {
                $end_index = scalar(@batch_sentences)-1;
            }
            my @subbatch_sentences = @batch_sentences[$start_index..$end_index];
            my $new_thread = new Thread \&tokenize_batch, @subbatch_sentences;
            push(@thread_list, $new_thread);
        }
        foreach (@thread_list)
        {
            my $tokenized_list = $_->join;
            foreach (@$tokenized_list)
            {
                print $_;
            }
        }
    }
}
else
{# single thread only
    while(<STDIN>)
    {
        print &tokenize($_);
    }
}

#####################################################################################
# subroutines afterward

# tokenize a batch of texts saved in an array
# input: an array containing a batch of texts
# return: another array containing a batch of tokenized texts for the input array
sub tokenize_batch
{
    my(@text_list) = @_;
    my(@tokenized_list) = ();
    foreach (@text_list)
    {
        push(@tokenized_list, &tokenize($_));
    }
    return \@tokenized_list;
}

# the actual tokenize function which tokenizes one input string
# input: one string
# return: the tokenized string for the input string
sub tokenize
{
    my($text) = @_;

    chomp($text);

    my $final = $text;
    $final =~ s/\&bar;/\|/g;   # factor separator (legacy)
    $final =~ s/\&#124;/\|/g;  # factor separator
    $final =~ s/\&lt;/\</g;    # xml
    $final =~ s/\&gt;/\>/g;    # xml
    $final =~ s/\&bra;/\[/g;   # syntax non-terminal (legacy)
    $final =~ s/\&ket;/\]/g;   # syntax non-terminal (legacy)
    $final =~ s/\&quot;/\"/g;  # xml
    $final =~ s/\&apos;/\'/g;  # xml
    $final =~ s/\&#39;/\'/g;  # xml
    $final =~ s/\&#91;/\[/g;   # syntax non-terminal
    $final =~ s/\&#93;/\]/g;   # syntax non-terminal
    $final =~ s/\&amp;/\&/g;   # escape escape
    $final =~ s/\p{C}/ /g;

    $final =~ s/\&#224;/\??/g;
    $final =~ s/\&#225;/\??/g;
    $final =~ s/\&#226;/\??/g;
    $final =~ s/\&#227;/\??/g;
    $final =~ s/\&#228;/\??/g;
    $final =~ s/\&#229;/\??/g;
    $final =~ s/\&#230;/\??/g;
    $final =~ s/\&#231;/\??/g;
    $final =~ s/\&#232;/\??/g;
    $final =~ s/\&#233;/\??/g;
    $final =~ s/\&#234;/\??/g;
    $final =~ s/\&#235;/\??/g;
    $final =~ s/\&#236;/\??/g;
    $final =~ s/\&#237;/\??/g;
    $final =~ s/\&#238;/\??/g;
    $final =~ s/\&#239;/\??/g;
    $final =~ s/\&#240;/\??/g;
    $final =~ s/\&#241;/\??/g;
    $final =~ s/\&#242;/\??/g;
    $final =~ s/\&#243;/\??/g;
    $final =~ s/\&#244;/\??/g;
    $final =~ s/\&#245;/\??/g;
    $final =~ s/\&#246;/\??/g;
    $final =~ s/\&#247;/\??/g;
    $final =~ s/\&#248;/\??/g;
    $final =~ s/\&#249;/\??/g;
    $final =~ s/\&#250;/\??/g;
    $final =~ s/\&#251;/\??/g;
    $final =~ s/\&#252;/\??/g;
    $final =~ s/\&#253;/\??/g;
    $final =~ s/\&#254;/\??/g;
    $final =~ s/\&#255;/\??/g;

    # twice
    $final =~ s/\&bar;/\|/g;   # factor separator (legacy)
    $final =~ s/\&#124;/\|/g;  # factor separator
    $final =~ s/\&lt;/\</g;    # xml
    $final =~ s/\&gt;/\>/g;    # xml
    $final =~ s/\&bra;/\[/g;   # syntax non-terminal (legacy)
    $final =~ s/\&ket;/\]/g;   # syntax non-terminal (legacy)
    $final =~ s/\&quot;/\"/g;  # xml
    $final =~ s/\&apos;/\'/g;  # xml
    $final =~ s/\&#39;/\'/g;  # xml
    $final =~ s/\&#91;/\[/g;   # syntax non-terminal
    $final =~ s/\&#93;/\]/g;   # syntax non-terminal
    $final =~ s/\&amp;/\&/g;   # escape escape
    $final =~ s/\p{C}/ /g;

    $final =~ s/\&#224;/\??/g;
    $final =~ s/\&#225;/\??/g;
    $final =~ s/\&#226;/\??/g;
    $final =~ s/\&#227;/\??/g;
    $final =~ s/\&#228;/\??/g;
    $final =~ s/\&#229;/\??/g;
    $final =~ s/\&#230;/\??/g;
    $final =~ s/\&#231;/\??/g;
    $final =~ s/\&#232;/\??/g;
    $final =~ s/\&#233;/\??/g;
    $final =~ s/\&#234;/\??/g;
    $final =~ s/\&#235;/\??/g;
    $final =~ s/\&#236;/\??/g;
    $final =~ s/\&#237;/\??/g;
    $final =~ s/\&#238;/\??/g;
    $final =~ s/\&#239;/\??/g;
    $final =~ s/\&#240;/\??/g;
    $final =~ s/\&#241;/\??/g;
    $final =~ s/\&#242;/\??/g;
    $final =~ s/\&#243;/\??/g;
    $final =~ s/\&#244;/\??/g;
    $final =~ s/\&#245;/\??/g;
    $final =~ s/\&#246;/\??/g;
    $final =~ s/\&#247;/\??/g;
    $final =~ s/\&#248;/\??/g;
    $final =~ s/\&#249;/\??/g;
    $final =~ s/\&#250;/\??/g;
    $final =~ s/\&#251;/\??/g;
    $final =~ s/\&#252;/\??/g;
    $final =~ s/\&#253;/\??/g;
    $final =~ s/\&#254;/\??/g;
    $final =~ s/\&#255;/\??/g;

    # third
    $final =~ s/\&bar;/\|/g;   # factor separator (legacy)
    $final =~ s/\&#124;/\|/g;  # factor separator
    $final =~ s/\&lt;/\</g;    # xml
    $final =~ s/\&gt;/\>/g;    # xml
    $final =~ s/\&bra;/\[/g;   # syntax non-terminal (legacy)
    $final =~ s/\&ket;/\]/g;   # syntax non-terminal (legacy)
    $final =~ s/\&quot;/\"/g;  # xml
    $final =~ s/\&apos;/\'/g;  # xml
    $final =~ s/\&#39;/\'/g;  # xml
    $final =~ s/\&#91;/\[/g;   # syntax non-terminal
    $final =~ s/\&#93;/\]/g;   # syntax non-terminal
    $final =~ s/\&amp;/\&/g;   # escape escape
    $final =~ s/\p{C}/ /g;

    $final =~ s/\&#224;/\??/g;
    $final =~ s/\&#225;/\??/g;
    $final =~ s/\&#226;/\??/g;
    $final =~ s/\&#227;/\??/g;
    $final =~ s/\&#228;/\??/g;
    $final =~ s/\&#229;/\??/g;
    $final =~ s/\&#230;/\??/g;
    $final =~ s/\&#231;/\??/g;
    $final =~ s/\&#232;/\??/g;
    $final =~ s/\&#233;/\??/g;
    $final =~ s/\&#234;/\??/g;
    $final =~ s/\&#235;/\??/g;
    $final =~ s/\&#236;/\??/g;
    $final =~ s/\&#237;/\??/g;
    $final =~ s/\&#238;/\??/g;
    $final =~ s/\&#239;/\??/g;
    $final =~ s/\&#240;/\??/g;
    $final =~ s/\&#241;/\??/g;
    $final =~ s/\&#242;/\??/g;
    $final =~ s/\&#243;/\??/g;
    $final =~ s/\&#244;/\??/g;
    $final =~ s/\&#245;/\??/g;
    $final =~ s/\&#246;/\??/g;
    $final =~ s/\&#247;/\??/g;
    $final =~ s/\&#248;/\??/g;
    $final =~ s/\&#249;/\??/g;
    $final =~ s/\&#250;/\??/g;
    $final =~ s/\&#251;/\??/g;
    $final =~ s/\&#252;/\??/g;
    $final =~ s/\&#253;/\??/g;
    $final =~ s/\&#254;/\??/g;
    $final =~ s/\&#255;/\??/g;

    return $final."\n";

}


