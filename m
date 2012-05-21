Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51540 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757813Ab2EUUKT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2012 16:10:19 -0400
Date: Mon, 21 May 2012 22:08:30 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
To: Rob Allen <ra-kernel@hotmail.co.uk>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Yinghai Lu <yinghai@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
Message-ID: <20120521220830.3732cc8d@stein>
In-Reply-To: <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
References: <bug-43244-4803@https.bugzilla.kernel.org/>
	<20120513221357.7574ae79@stein>
	<4FB0A6F6.9050504@ladisch.de>
	<CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
	<BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
	<4FB3B159.2090401@ladisch.de>
	<BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On May 21 Rob Allen wrote:
> On 16/05/12 14:53, Clemens Ladisch wrote:
> > Rob Allen wrote:
> >> On 14/05/12 07:39, Yinghai Lu wrote:
> >>> can you post full log with pci debug enabled with lastest upsteam kernel?
> >>
> >> I'm happy to do that, although I need with some guidance on what I need to
> >> enable to get the required output.
> >
> > For Ubuntu, see<https://wiki.ubuntu.com/KernelTeam/GitKernelBuild>.
> >
> > To enable PCI debugging, enable the configuration options
> > CONFIG_DEBUG_KERNEL and CONFIG_PCI_DEBUG.
> 
> Thanks. I've built the kernel and I can replicate the failure.
> 
> However, I'm having trouble getting the log output. As soon as I see the 
> "firewire_ohci: Failed to set Link Power Status" message, the machine 
> locks up. After cycling the power, that log output isn't anywhere in 
> /var/log anywhere (even if I booted with 'rw').
> 
> After some searching, I guess a decent route is to output to a serial 
> console. The machine in question doesn't have a serial port, although I 
> have a PCI-e serial card somewhere. (Is that likely to work so early in 
> the boot process?)
> 
> Can you suggest the best way to get the log output?

If there is anything more than that on the text console when the PC locks
up and you have a digital camera at your disposal, just take a photograph,
attach it to bugzilla, and post the link.

If there is nothing interesting to photograph, then you could try
netconsole.  You need a second PC on which you configure syslogd to
receive log messages from the test PC.  On the test PC, you need to have
netconsole loaded before the lockup and need to specify the target.

Here is what works for me:

On the logging PC at 192.168.0.37:
----------------------------------
$ tail -3 /etc/syslog-ng/syslog-ng.conf 
# netconsole:
source net { udp(ip("192.168.0.37") port(6666)); };
log { source(net); destination(messages); };

On the test PC:
---------------
# alias netconsole
alias netconsole='modprobe netconsole netconsole="@/,@192.168.0.37/" && dmesg -n 7'

Since you crash at boot, I guess it's easiest to link netconsole
statically into the kernel and of course specify the parameter in the
bootloader's kernel command line.
-- 
Stefan Richter
-=====-===-- -=-= =-=-=
http://arcgraph.de/sr/
