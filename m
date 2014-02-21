Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35430 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753973AbaBUJMd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 04:12:33 -0500
Date: Fri, 21 Feb 2014 10:12:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221101218.45766e8a@skate>
In-Reply-To: <5307152D.3020804@keymile.com>
References: <53039894.10905@keymile.com>
	<20140218212751.07c2aeb5@skate>
	<53046D98.6020801@keymile.com>
	<20140219102658.76eec91e@skate>
	<53047BBB.6040108@keymile.com>
	<20140219143749.65ff3155@skate>
	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
	<20140220095518.7ca36f0a@skate>
	<20140220173518.GA19893@obsidianresearch.com>
	<20140220212914.29ddc031@skate>
	<20140221003227.GF19893@obsidianresearch.com>
	<20140221093444.35870a73@skate>
	<5307152D.3020804@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Gerlando Falauto,

On Fri, 21 Feb 2014 09:58:21 +0100, Gerlando Falauto wrote:

> > Can you give more details about this mechanism, and how it could be
> > used to alter the size of resources on a bridge?
> 
> I'm not sure I understand all the details... but I guess some sort of 
> rounding mechanism is indeed already in place somewhere:
> 
> pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
> pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
> pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
> pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
> pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> 
> If you look at the numbers, the total size required by BAR0-5 is 
> 0x8805000, so around 136MB, that is 128MB+8MB+2K+1K+1K.
> This gets rounded up (on this 'virtual' BAR 8) to 192MB (I don't know 
> where or why), which is 1.5x a power of two (i.e. two consecutive bits 
> followed by all zeroes).

Would indeed be interesting to know who does this rounding, and why,
and according to what rules.

> If that's not just a coincidence, finding a coverage subset becomes a 
> trivial matter (128MB+64MB).
> 
> In any case, even if we have an odd number like the above (0x8805000), I 
> believe we could easily find a suboptimal coverage by just taking the 
> most significant one and the second most significant one (possibly left 
> shifted by 1 if there's a third one somewhere else).
> In the above case, that would be 0x8000000 + 0x1000000. That's 
> 128MB+16MB, which is even smaller than the rounding above (192MB).
> 
> What do you think?

Sure, but whichever choice we make, the Linux PCI core must know by how
much we've enlarge the bridge window BAR, otherwise the Linux PCI core
may allocate for the next bridge window BAR a range of addresses that
doesn't overlap with what it has allocate for the previous bridge
window BAR, but that ends up overlapping due to us "extending" the
previous bridge window BAR to match the MBus requirements.

Gerlando, would you be able to test a quick hack that creates 2 windows
to cover exactly 128 MB + 64 MB ? This would at least allow us to
confirm that the strategy of splitting in multiple windows is usable.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
