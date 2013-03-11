Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:47601 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045Ab3CKXZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 19:25:29 -0400
Date: Mon, 11 Mar 2013 17:25:16 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130311232516.GA13873@obsidianresearch.com>
References: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513E519B.6010503@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 11, 2013 at 11:50:19AM -1000, Mitch Bradley wrote:

> > However - the driver runs the core in a 'root port bridge mode' where
> > the config header register block you are looking at is inhibited. The
> > Marvell IP block requires software support to run in bridge mode. So
> > Marvell really has only (2), while Tegra has only (1).
> 
> Interesting.
> 
> For Marvell, if Marvell has only (2), does that imply that standard PCI
> discovery and enumeration code cannot find the root port bridges, and
> also there is no way to auto-configure the bridges with common pci-pci
> bridge code?

The driver is required to take care of all of this. From the common
code's perspective there is a bridge config header, and writing to it
controls the device, as the PCI spec intends. But the driver doesn't
copy those read/writes 1:1 to any HW register block, it distributes
them around the device's register space as necessary to create the
PCI bridge config header.

The DT is still modeling the HW, there really are root port bridge(s),
that are completely conformant at the TLP level, but the IP designers
choose to leave the detail of the bridge config space up to a SW
implementation.

> At this point I am confused again.  There was talk of the need to
> use standard PCI enumeration code to deal with the bridges, thus the
> need for 3/2 to describe the interface between root-complex and the
> child root-port nodes.

I think your confusion is coming from your expectation that the PCI-E
IP block would be an entirely self contained root port, rather than
'tools to build a root port, with the right driver SW'.

> > Further, review section 12 about how ranges should be treated - it
> > specifically says that the b,d,f bits in ranges should be 0, and the
> > child address should have those bits masked prior to searching the
> > ranges.
> > 
> > Section 12 would seem to forbid this:
> > 
> >       ranges = <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root port config header */
> >                 0x00001000 0 0          0xd4008000 0 0x00000800   /* Root port config header */
> > 
> > Are you reading that differently?
> 
> I wasn't reading it at all, until you pointed it out to me :-)  I was
> just reasoning based on my mental model.
> 
> Again, I agree with your reading of the spec, but I can't think of any
> reason why relaxing that restriction to permit config space mappings
> would be a problem.

Okay, just wanted to confirm that, I think I follow you now. :)

So you are basically proposing a small update to Section 12 that would
read something like:

'When matching a config space address, the b,d,f bits are valid in the
 ranges and left unmasked in the child. The r bits in the ranges
 should be 0, and the r bits from the child are copied in the last DW
 and masked off in the first DW.'

Which, as you note, would not conflict with any existing usage..

Though, I can already see that the above language is not good enough,
it doesn't elegantly represent standard ECAM, for instance.. How would
you even represent ECAM with ranges??

Another wrinkle is that tegra not only has the per-bridge memory
mapped config space, bit it also has 4 'all port' ECAM-like memory
mapped config spaces. The rules around them are sufficiently
specialized that I'm not sure a ranges mapping would ever be
practical.. So right out of the gate we'd fail to capture memory
mapped config access via ranges on at least one SOC.

So, to me, this seems like overkill. Only ECAM has a hope of having a
common implementation, everything else will be host driver specific,
so why go to the trouble to revise the OF PCI specification for config
space?

Particularly since there are patches waiting on this question being
resolved :)

Regards,
Jason
