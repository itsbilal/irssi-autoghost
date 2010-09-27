## Script by Bilal Akhtar <bilalakhtar@ubuntu.com>
use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
    authors     => 'Bilal Akhtar',
    contact     => 'bilalakhtar@ubuntu.com',
    name        => 'autoghost.pl',
    description => 'Automatically ghost previously existing nick of the same account',
    license     => 'GNU General Public License version 3',
    url         => 'http://lewk.org/log/code/irssi-notify',
);

sub check_nick_changed{
	my($server) = @_;
	my $alternate_nick = Irssi::settings_get_str('alternate_nick');
	my $oldnick = Irssi::settings_get_str('nick');
	if ($alternate_nick eq $server->{nick})
	{
		$server->command('/msg NickServ ghost ' . $oldnick);
		$server->command('/wait 2000');
		$server->command('/nick ' . $oldnick);
	}
}

Irssi::signal_add('user mode changed', 'check_nick_changed');

