Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:37979 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbaDJXkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 19:40:23 -0400
Date: Thu, 10 Apr 2014 17:40:00 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410234000.GA18443@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410171000.GF25890@1wt.eu>
 <20140410200222.27cab16e@skate>
 <20140410231336.GC30855@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410231336.GC30855@1wt.eu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 11, 2014 at 01:13:36AM +0200, Willy Tarreau wrote:

> So the areas are well covered, though #11 seems larger than needed
> but I seem to remember that they're all rounded up by 1 MB anyway,
> then if so, that's OK.

Right, PCI bridge windows are 1MB aligned

> root@xpgp:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices
> [00] 00000000e8010000 - 00000000e8020000 : 0004:00f0 (remap 0000000000010000)
> [08] 00000000fff00000 - 0000000100000000 : 0001:001d
> [09] 00000000f0000000 - 00000000f1000000 : 0001:002f
> [10] 00000000e1800000 - 00000000e1a00000 : 0004:00f8
> [11] 00000000e1a00000 - 00000000e1b00000 : 0004:00f8
> [12] 00000000e0000000 - 00000000e1000000 : 0008:00f8
> [13] 00000000e1000000 - 00000000e1800000 : 0008:00f8
> 
> I noticed above that both igb ports share the same window #11. So I
> tried to rmmod igb, remove both PCI devices, check mbus again (which
> did not change), rescan PCI and modprobe igb again, and everything is
> still operational with the same windows. I don't know if it is normal
> that they're not unregistered when the device goes away (maybe there's
> no refcount) ?

The windows are tied to the PCI core, not to the using driver
module. So they will only changed based on rescan an dynamic resource
assignment in the PCI core. PCI rescan has a 'memory' of the last
bridge windows and won't make dramtic changes, so expect the windows
to fairly sticky.

> If we have to keep them forever, then maybe a further improvement
> will consist in merging adjacent windows which sum up as a power of
> two (eg: #10 and #11 may be merged).

0x1b00000 - 0x1800000 = 0x300000 which is not a power of two..

> I tried to add a 3rd NIC in the mix (broadcom tg3), which caused the
> myri10ge to fail to load for an obscure reason after loading igb
> properly :

Oh, this looks a lot like what Thomas reported with his 5 NICs.

I really wonder what could be going on here.....

> Ah, interestingly if I load the NICs in the opposite order, they all load
> properly (myri10ge, igb, r8169) :

Load the NICs means insmod the driver ?

That is repeatable?

Certainly spooky, and suggests a kernel bug.....

It would be interesting to see what register values the driver is
getting back, is it all 0xF? 

I wonder if something is going wrong with the config write to enable
the memory decoder. That is triggered by the driver...

> So overall, it's a big Ack from my side considering the huge
> improvements, let's retry tomorrow with the link up workaround/fix
> to see if the detection issue is related. Great work!

Seems very likely to me, if the modified patch from Neil fixes it for
you too then we need to get that into mergable shape too!

Regards,
Jason
