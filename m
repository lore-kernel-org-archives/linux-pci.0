Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751630AbdLFSnU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 13:43:20 -0500
Date: Wed, 6 Dec 2017 12:43:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rudolf Marek <r.marek@assembler.cz>
Cc: linux-pci@vger.kernel.org, RayeR <rayer@seznam.cz>, mj@ucw.cz
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
Message-ID: <20171206184314.GK23510@bhelgaas-glaptop.roam.corp.google.com>
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
 <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
 <0a488e5b-d954-b2bc-0089-6c0542b8c571@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a488e5b-d954-b2bc-0089-6c0542b8c571@assembler.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 05, 2017 at 09:35:22PM +0100, Rudolf Marek wrote:
> Dne 5.12.2017 v 20:07 Bjorn Helgaas napsal(a):
> > So if I understand correctly, you have
> > 
> >   - A bridge with PCI_BRIDGE_CTL_VGA set but VGA_16BIT_EN is clear
> 
> Yes
> 
> >   - A peer of the bridge with an I/O BAR set to some alias of
> >     0x3c0-0x3df
> 
> It is not a peer bridge, but some other bridge on bus 0. The non-working device is
> a Audigy PCI card (05:00.0)

00:01.0 and 00:1c.3 are peers in the sense that they're both on the
same bus.  00:1c.3 doesn't have a *BAR* that contains 0x3c0, but I
think it does have an I/O *window* set to an alias of 0x3c0, like
this (we don't actually print the implicit VGA bridge windows, but
maybe we should):

  00:01.0 PCI bridge to [bus 01]
  00:01.0   implicit bridge window [io 0x03c0-0x03df] + ISA aliases
  01:xx.0 VGA device legacy resource [io 0x03c0-0x03df]
  00:1c.3 PCI bridge to [bus 04-05]
  00:1c.3   bridge window [io 0xc000-0xcfff]
  04:00.0 PCI bridge to [bus 05]
  04:00.0   bridge window [io 0xc000-0xcfff]
  05:00.0 Audigy reg 0x10: [io 0xcfc0-0xcfdf]

0xcfc0 is a 10-bit alias of 0x03c0, so both bridges (00:01.0 and
00:1c.3) will claim it.

> The path is 00:1c.3 (Intel PCIe bridge) -> 4:00.0 (ITE PCIe-PCI bridge) -> 5:00.0 (audigy)
> The other bridge is 00:01.0 which connects to some VGA on bus 1.
> 
> The Audigy has only one resource:
> 
> Region 0: I/O ports at cfc0 [size=32]
> 
> Which collides with the 0x3b0. We used "isadump -f" to verify we indeed see an alias.
> Rayer booted to DOS, edited the BAR and loadlin back to Linux and the device works,
> so it was that. Later he reported that setting the bit4 also fixed that.
> >
> > In this case I think both the bridge and the peer device will claim
> > accesses to 0x3c0-0x3df, which is a bad thing.
> 
> Yes, the isadump -f confirmed that.

> > And your proposal is that Linux should either
> > 
> >   - Turn on VGA_16BIT_EN (if supported by the bridge), or
> > 
> >   - If VGA_16BIT_EN is not supported by the bridge, try to reassign
> >     the peer I/O BAR so it doesn't conflict with the 0x3c0-0x3df
> >     aliases
> 
> The Aliases are:
> 
> 0x3B0 - 0x3BB  and 0x3C0 - 0x3DF and it seems that also VGA palette snoops 
> and VGA palette snoops: 0x3C6, 0x3C8, 0x3C9 
> 
> It seems that the VGA_16BIT_EN could also control the palette snoops alias,
> so in the end it should remove all aliases.
> I hope someone access to more recent PCI bridge specs can confirm.

The PCI-to-PCI Bridge spec, r1.2, sec 3.2.5.18, says VGA_16BIT_EN
controls the bridge decoding for "all VGA I/O register accesses that
are forwarded from primary to secondary."  I would say that would
include VGA palette snoops.

> > If I'm understanding correctly, this sounds very reasonable.
> 
> Yes exactly. Question is why the insanity alias exists in the first place. 
> What Mr. PCI tried to fix or break with that alias design?
> Besides making logic simpler, I have no idea.

I think this 10-bit aliasing is a compatibility feature for ISA.

> >> I suspect it will fix couple of problems people were seeing with old
> >> PCI cards as they tend to have the I/O regions (I stumbled upon
> >> various reports when was suspecting the PCIe to PCI ITE chip and
> >> interrupt routing problems)
> > 
> > To help understand and document this better, it would be nice to see a
> > complete dmesg log and "lspci -vv" output (as root) showing the
> > problem.  A kernel.org bugzilla would be a good place to store this.
> 
> Yes sure, in what category
> 
> drivers/pci or platform/hardware?

drivers/pci

> > It would also be great to collect up the other reports you've found
> > and see if we can definitively tie them to this issue and potentially
> > test a fix.
> 
> Oh, hm, those were random searches using a search engine. I was talking about [1], 
> but reading it again, all issues were interrupt related.
> 
> I'll try to reproduce my searches.
> 
> Btw, latest pciutils-3.5.6 also lack of decoding of the bit4. I added to Martin Mares to CC.
> 
> I can prepare a patch for PCIutils if needed. Martin, please tell.

Yes, a pciutils patch would be great.  It would be ideal if you could
prepare the patch and send it to Martin and cc linux-pci.

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=43238
