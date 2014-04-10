Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42132 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753612AbaDJVE6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 17:04:58 -0400
Date: Thu, 10 Apr 2014 23:04:54 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>, Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410230454.3f761715@skate>
In-Reply-To: <20140410201201.GA12661@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
	<20140410165733.GB23104@obsidianresearch.com>
	<20140410200153.46669e0c@skate>
	<20140410201201.GA12661@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Thu, 10 Apr 2014 14:12:01 -0600, Jason Gunthorpe wrote:

> > But I'm not entirely convinced by this, because in my testing, I saw:
> > 
> >  * Enable the clock
> >  * Values in the PCI configuration space are correct (like
> >    vendor/product ID)
> >  * mvebu_pcie_set_local_dev_nr()
> >  * Values in the PCI configuration space are no longer correct, unless
> >    you wait a little bit.
> 
> Were you reading the configuation space through the MMIO mapping or
> through the configuration indirection?

I was simply calling the mvebu_pcie_hw_rd_conf() function, so I guess
it goes through what you call the "configuration indirection".

> In any event, turning on the clock should almost certainly be
> accompanied by a phy reset sequence to get both link ends on the same
> page.
> 
> Attached is a rough, untested patch along those lines.

I'll try tomorrow, if I manage to reproduce the initial bug to start
with.

> > > That does sound like more mbus troubles.
> > 
> > Interestingly, the problem occurred when I was plugging a SATA PCIe
> > card. And regardless of whether the SATA PCIe card is present or not,
> > the MBus mappings for the IGB are exactly the same.
> 
> Maybe something wrong with mbus window index 13?
> 
> Any change if you use other windows?

Don't know, will try tomorrow and report back :-)

Thanks for the suggestions!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
