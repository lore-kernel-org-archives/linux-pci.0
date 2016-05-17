Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38879 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbcEQO1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 10:27:22 -0400
Date: Tue, 17 May 2016 09:27:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: Martin Mansfield <mrmansfield@ntlworld.com>,
	Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Re: Reason for hang after running lspci -vv as root
Message-ID: <20160517142711.GA19170@localhost>
References: <05A7667AE5A84EFC87D025E140351A4C@pc1>
 <mj+md-20160514.100302.61929.camelot@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20160514.100302.61929.camelot@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 14, 2016 at 12:07:44PM +0200, Martin Mares wrote:
> Hello!
> 
> > I have been using lspci (v3.2.1) on Centos 7.2 to find out why a LSI 9420-4i
> > raid controller did not work with the linux driver but when I used lspci
> > with the -vv option as root the machine locked up completely and even the
> > reset button did not work. lspci v3.4.1 does the same.
> > As I was curious as to the reason why this could happen I compiled and ran
> > it under gdb and found that the cap_vpd() function caused the problem. The
> > raid card said that it supported vpd but the first call of read_vpd()
> > returned a value of FFh for the variable "tag" and the next call of
> > read_vpd() would hang the pc.
> > I added code to return from the function after the first read_vpd but when
> > the subsequent capability structures were read the values were different
> > from those previously dumped using the -xxx option and lspci would crash as
> > it followed the modified linked list off into oblivion.
> > I commented out the call to cap_vpd() and it worked correctly and I could
> > then see all the capability details.
> > 
> > I would like to make a request that the call to cap_vpd be disabled by
> > default and enabled by a command line parameter if necessary as it is very
> > likely that it is the cause of problems with the -vv and -vvv options. As
> > this incident has shown, the consequences of reading the vpd can be very
> > dangerous.
> 
> It smells of faulty hardware. Reading the VPD should not have any side
> effects.
> 
> It seems to be a rather singular problem (your report was the first one
> I received since we added dumping of VPD in 2009) and it is not limited
> to lspci anyway -- other programs could crash your system by accessing
> the particular file in sysfs.
> 
> I would recommend blacklisting your device in the kernel, so that VPD
> will not be provided by sysfs at all.

We do have some devices blacklisted in the kernel, including several
LSI devices.  This commit appeared in v4.6:

  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7c20078a8197

Based on the v4.6-rc6 dmesg log you (martinman3) attached at
https://bugs.centos.org/view.php?id=10818, I think your LSI 9420-4i
device is "pci 0000:05:00.0: [1000:0073]".  v4.6-rc6 includes
7c20078a8197, and [1000:0073] is included in that blacklist.

Did you still see the system hang with v4.6-rc6?  If so, we still have
work to do.  The blacklist should make it safe to dump the VPD via
sysfs, e.g.,

  # xxd /sys/devices/pci0000:00/0000:00:05:00.0/vpd

You shouldn't see any VPD data, and the machine should not hang.

I don't know whether lspci reads VPD using sysfs or a different way.
If it reads it differently, it's possible it could still cause a hang,
even with the kernel blacklist.

But at the hardware level, reading VPD requires access to two
registers on the device, and I don't think that can be done safely
without kernel support, so I hope lspci is using sysfs.

Bjorn
