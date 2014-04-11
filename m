Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:3994 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbaDKGYY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Apr 2014 02:24:24 -0400
Date: Fri, 11 Apr 2014 08:23:42 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
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
Message-ID: <20140411062342.GG30855@1wt.eu>
References: <20140410181953.50ccfcc3@skate> <20140410171000.GF25890@1wt.eu> <20140410200222.27cab16e@skate> <20140410231336.GC30855@1wt.eu> <20140410234000.GA18443@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410234000.GA18443@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jason,

On Thu, Apr 10, 2014 at 05:40:00PM -0600, Jason Gunthorpe wrote:
> The windows are tied to the PCI core, not to the using driver
> module. So they will only changed based on rescan an dynamic resource
> assignment in the PCI core. PCI rescan has a 'memory' of the last
> bridge windows and won't make dramtic changes, so expect the windows
> to fairly sticky.

OK.

> > If we have to keep them forever, then maybe a further improvement
> > will consist in merging adjacent windows which sum up as a power of
> > two (eg: #10 and #11 may be merged).
> 
> 0x1b00000 - 0x1800000 = 0x300000 which is not a power of two..

Of course you're right. It was late last night, and I was having
a hard time thinking the addresses were not inclusive so in my
mind it was 0x18..0x1b inclusive, thus 4MB... Never mind.

> > I tried to add a 3rd NIC in the mix (broadcom tg3), which caused the
> > myri10ge to fail to load for an obscure reason after loading igb
> > properly :
> 
> Oh, this looks a lot like what Thomas reported with his 5 NICs.
> 
> I really wonder what could be going on here.....

I don't know but I have the hardware to easily reproduce it, if we want
to add printks again.

> > Ah, interestingly if I load the NICs in the opposite order, they all load
> > properly (myri10ge, igb, r8169) :
> 
> Load the NICs means insmod the driver ?

Yes.

> That is repeatable?

Yes, 100% it seems.

> Certainly spooky, and suggests a kernel bug.....
> 
> It would be interesting to see what register values the driver is
> getting back, is it all 0xF? 

That's what I suspected from the -1, but since the driver says "or 16MB"
and one of the windows is 16MB, I'm still confused, I need to add some
printk there.

> I wonder if something is going wrong with the config write to enable
> the memory decoder. That is triggered by the driver...

Thomas told me that the mbus driver is able to suggest a different
start address for the PCI windows. Maybe we fall in this case and the
driver doesn't expect this and uses a different register for the start
address.

> > So overall, it's a big Ack from my side considering the huge
> > improvements, let's retry tomorrow with the link up workaround/fix
> > to see if the detection issue is related. Great work!
> 
> Seems very likely to me, if the modified patch from Neil fixes it for
> you too then we need to get that into mergable shape too!

I can confirm that simply commenting out clk_disable_unprepare(clk)
fixes this problem, so yes it's the same issue. Just tried Neil's
modified patch and it works fine as well. So yes, we're making a lot
of progress.

Just in case anyone is interested, this is the NIC I'm using, both
on the mirabox and on the XP-GP ; it was worth an acquisition
considering how many corner cases it triggers in the kernel code :

  http://www.jetway.com.tw/jw/ipcboard_view.asp?productid=873&proname=ADMPEIDLA

Cheers,
Willy

