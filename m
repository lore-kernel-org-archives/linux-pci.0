Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:48023 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773AbaDJQ6L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 12:58:11 -0400
Date: Thu, 10 Apr 2014 10:57:33 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>, Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410165733.GB23104@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410181953.50ccfcc3@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 10, 2014 at 06:19:53PM +0200, Thomas Petazzoni wrote:

> This is an e-mail that attempts to summarize the situation in terms of
> Armada XP PCIe issues.
> 
> At
> https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.14/pci-debug,
> I've pushed a branch based on top of v3.14 that contains:

mvebu_pcie_del_windows / mvebu_pcie_add_windows I wonder if these
functions should be dropped into the mbus driver.. They are pretty
generic.

'bus: mvebu-mbus: Avoid setting an undefined window size' and
'pci: mvebu: fix off-by-one in the computed size of the mbus windows'
need to be swapped in order to maintain bisect-ability.

> Can you test this stack of patches on your system and configuration, and
> let me know if that works for you? 

Continues to work as expected here, and I see the new error message:

mvebu_mbus: cannot add window '4:e8', conflicts with another window
mvebu-pcie pex.1: Could not create MBus window at 0xe0000000, size 0x100000: -22

(this is due to the PEX window being in the DT mbus ranges already)

Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

> 
>  * The link up problem. Unfortunately, I tried to reproduce it today,
>    and didn't manage to. It's weird, because I'm sure I was able to
>    produce it in the past, but I'm no longer able to, I don't know.
>    Therefore, it's not easy for me to work on this topic. Neil, Jason,
>    do you think this is a topic you could potentially handle?

You said you had a system that sometimes required the udelay? Can you
run Neil's patch and see if your system behaves the same? Specifically
that the link eventually goes down after mvebu_pcie_set_local_dev_nr ?

I couldn't find any case where the BDF leaks below the TLP layer, and
the spec is very clear that the assigned BDF can change at run time,
so I don't have an explanation for why the link reset is happening.
Do you have a contact at Marvell that might shed some light on that
behavior?

>  * On my Armada XP DB board, if I plug 5 PCIe cards, the IGB card for
>    some reason isn't able to read data from its non-volatile memory. So
>    the window points to something, but it doesn't seem to patch what
>    the igb driver expects. I've double checked the MBus windows, and
>    they look correct. I haven't tested this PCIe configuration with the
>    Marvell LSP though, so maybe I'm hitting an unrelated hardware
>    problem or something.

Certainly troubling.. And the IGB works if it is the only card in the
system?

That does sound like more mbus troubles.

Regrads,
Jason
