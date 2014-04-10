Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40549 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030285AbaDJSB5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 14:01:57 -0400
Date: Thu, 10 Apr 2014 20:01:53 +0200
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
Message-ID: <20140410200153.46669e0c@skate>
In-Reply-To: <20140410165733.GB23104@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
	<20140410165733.GB23104@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Thu, 10 Apr 2014 10:57:33 -0600, Jason Gunthorpe wrote:

> > At
> > https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.14/pci-debug,
> > I've pushed a branch based on top of v3.14 that contains:
> 
> mvebu_pcie_del_windows / mvebu_pcie_add_windows I wonder if these
> functions should be dropped into the mbus driver.. They are pretty
> generic.

Yes. I must say I hesitated quite a bit of time between having them in
pci-mvebu or in mvebu-mbus. I settled on pci-mvebu because PCI is so
far the only user of this functionality. But this is not a strong
opinion.

> 'bus: mvebu-mbus: Avoid setting an undefined window size' and
> 'pci: mvebu: fix off-by-one in the computed size of the mbus windows'
> need to be swapped in order to maintain bisect-ability.

They could, indeed, but on the other hand, PCI and bus are handled by
different maintainers, so they will flow through distinct branches, so
I'm not sure it's going to be easy to guarantee the bisectability here.

Unless we get the Acks from both maintainers, so that Jason Cooper can
carry the patches and maintain the right order.

I'll reorder them when posting the patch series anyway.

> > Can you test this stack of patches on your system and configuration, and
> > let me know if that works for you? 
> 
> Continues to work as expected here, and I see the new error message:
> 
> mvebu_mbus: cannot add window '4:e8', conflicts with another window
> mvebu-pcie pex.1: Could not create MBus window at 0xe0000000, size 0x100000: -22
> 
> (this is due to the PEX window being in the DT mbus ranges already)

I'm not sure to understand here: you have hardcoded in your DT the
necessary PEX window? If so, then yes, it's expected.

> Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Thanks!

> >  * The link up problem. Unfortunately, I tried to reproduce it today,
> >    and didn't manage to. It's weird, because I'm sure I was able to
> >    produce it in the past, but I'm no longer able to, I don't know.
> >    Therefore, it's not easy for me to work on this topic. Neil, Jason,
> >    do you think this is a topic you could potentially handle?
> 
> You said you had a system that sometimes required the udelay?

Yes, and I tried to reproduce it today, and I didn't manage to
reproduce the problem, even on this platform, in the same conditions.
I'll try again tomorrow.

> Can you
> run Neil's patch and see if your system behaves the same? Specifically
> that the link eventually goes down after mvebu_pcie_set_local_dev_nr ?
> 
> I couldn't find any case where the BDF leaks below the TLP layer, and
> the spec is very clear that the assigned BDF can change at run time,
> so I don't have an explanation for why the link reset is happening.
> Do you have a contact at Marvell that might shed some light on that
> behavior?

There was a potential explanation about the mvebu-soc-id driver that
enables the clock and then disables it, before the pci-mvebu driver.
This is different that what was happening before, where the pci-mvebu
driver was the only one to enable the clock, which was already enabled
by the bootloader. So if the clock takes some time to stabilize, the
introduction of mvebu-soc-id may lead to problems.

But I'm not entirely convinced by this, because in my testing, I saw:

 * Enable the clock
 * Values in the PCI configuration space are correct (like
   vendor/product ID)
 * mvebu_pcie_set_local_dev_nr()
 * Values in the PCI configuration space are no longer correct, unless
   you wait a little bit.

> >  * On my Armada XP DB board, if I plug 5 PCIe cards, the IGB card for
> >    some reason isn't able to read data from its non-volatile memory. So
> >    the window points to something, but it doesn't seem to patch what
> >    the igb driver expects. I've double checked the MBus windows, and
> >    they look correct. I haven't tested this PCIe configuration with the
> >    Marvell LSP though, so maybe I'm hitting an unrelated hardware
> >    problem or something.
> 
> Certainly troubling.. And the IGB works if it is the only card in the
> system?

Yes, the IGB card works fine when plugged as the only card. It also
works when plugged with 3 other PCIe cards. But when I plug the five
PCIe cards I have, the IGB stops working.

However, note that some interfaces are x1, some other x4, and maybe
there was a mismatch/incompatibility with the PCIe cards I was plugging
in the board.

> That does sound like more mbus troubles.

Interestingly, the problem occurred when I was plugging a SATA PCIe
card. And regardless of whether the SATA PCIe card is present or not,
the MBus mappings for the IGB are exactly the same.

Here is a dump of the MBus windows with 4 PCIe cards (including the IGB
one) :

[00] 00000000ffe30000 - 00000000ffe40000 : 0004:00f0 (remap 0000000000030000)
[01] disabled
[02] disabled
[03] disabled
[04] disabled
[05] disabled
[06] disabled
[07] disabled
[08] 00000000fff00000 - 0000000100000000 : 0001:001d -> bootrom
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f -> NOR flash
[10] 00000000f8000000 - 00000000f8100000 : 0004:00e8 -> some other PCIe card
[11] 00000000f8800000 - 00000000f9000000 : 0004:00f8 -> this is the IGB
[12] 00000000f9000000 - 00000000f9100000 : 0004:00f8 -> this is the IGB
[13] disabled
[14] disabled
[15] disabled
[16] disabled
[17] disabled
[18] disabled
[19] disabled

And now, with the SATA card plugged in:

[00] 00000000ffe40000 - 00000000ffe50000 : 0008:00f0 (remap 0000000000040000)
[01] 00000000ffe30000 - 00000000ffe40000 : 0004:00f0 (remap 0000000000030000)
[02] disabled
[03] disabled
[04] disabled
[05] disabled
[06] disabled
[07] disabled
[08] 00000000fff00000 - 0000000100000000 : 0001:001d	=> bootrom
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f	=> NOR flash
[10] 00000000f8000000 - 00000000f8100000 : 0004:00e8	=> port 0.0 mem
[11] 00000000f8400000 - 00000000f8600000 : 0008:00f8	=> port 3.0 mem (SATA)
[12] 00000000f8800000 - 00000000f9000000 : 0004:00f8	=> port 2.0 mem (igb)
[13] 00000000f9000000 - 00000000f9100000 : 0004:00f8	=> port 2.0 mem (igb)
[14] disabled
[15] disabled
[16] disabled
[17] disabled
[18] disabled
[19] disabled

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
