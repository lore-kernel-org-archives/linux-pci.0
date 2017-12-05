Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752911AbdLETH5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Dec 2017 14:07:57 -0500
Date: Tue, 5 Dec 2017 13:07:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rudolf Marek <r.marek@assembler.cz>
Cc: linux-pci@vger.kernel.org, RayeR <rayer@seznam.cz>
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
Message-ID: <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 05, 2017 at 05:43:00PM +0100, Rudolf Marek wrote:
> It turned out that silly BIOS assigned the I/O BAR to an address
> which is positively decoded by some other PCIe bridge. The unlucky
> region collides with the legacy VGA mirror region which is decoded
> by other PCI/PCIe bridge because bit 3 (PCI_BRIDGE_CTL_VGA) is set.
> 
> Here is a quote from random datasheet of PCI/PCIe bridge:
> 
> VGA_EN:
> 
> *  Memory accesses in the range 0x000A_0000 to 000B_FFFF *  I/O
> addresses in the first 64 Kbytes of the I/O address space
> (Address[31:16] for PCIe are 0x0000) and where Address[9:0] is in
> the range of 0x3B0 to 0x3BB or 0x3C0 to 0x3DF (inclusive of ISA
> address aliases - Address[15:10] may possess any value and is not
> used in the decoding)
> 
> So, as you can see, it effectively forces the VGA I/O region to be
> mirrored all over the 64K I/O space.
> 
> What is interesting  is that the PCI bridge specs version 1.2?,
> added a new bit 4 (which is previously RO 0) which allows to decode
> only the full address for the 0x3b0/0x3c0 :
> 
> VGA_16BIT_EN:
> 
> This bit enables the bridge to provide 16-bit decoding of VGA I/O
> address precluding the decoding of alias addresses every 1 KB. This
> bit has meaning only if VGA Enable bit is set
> 
> There is not even a define in the Linux which would describe this
> bit. The "fix" for the problem is to simply turn off the aliasing.
> 
> I would like to ask:
> 
> 1) If there is some code already which would check this PCI
> resources collisions (at least issue an warning)

We do check for PCI resource collisions, e.g., in
pci_claim_resource(), but this does not account for aliasing.

> 2) Do you think that Linux should try to fix this? (Yes the BIOS
> messed it up, but hey, the Windoze figured it out)

So if I understand correctly, you have

  - A bridge with PCI_BRIDGE_CTL_VGA set but VGA_16BIT_EN is clear

  - A peer of the bridge with an I/O BAR set to some alias of
    0x3c0-0x3df

In this case I think both the bridge and the peer device will claim
accesses to 0x3c0-0x3df, which is a bad thing.

And your proposal is that Linux should either

  - Turn on VGA_16BIT_EN (if supported by the bridge), or

  - If VGA_16BIT_EN is not supported by the bridge, try to reassign
    the peer I/O BAR so it doesn't conflict with the 0x3c0-0x3df
    aliases

If I'm understanding correctly, this sounds very reasonable.

> I suspect it will fix couple of problems people were seeing with old
> PCI cards as they tend to have the I/O regions (I stumbled upon
> various reports when was suspecting the PCIe to PCI ITE chip and
> interrupt routing problems)

To help understand and document this better, it would be nice to see a
complete dmesg log and "lspci -vv" output (as root) showing the
problem.  A kernel.org bugzilla would be a good place to store this.

It would also be great to collect up the other reports you've found
and see if we can definitively tie them to this issue and potentially
test a fix.

Bjorn
