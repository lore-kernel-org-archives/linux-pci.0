Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52434 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab3BFQvv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 11:51:51 -0500
Date: Wed, 6 Feb 2013 17:51:28 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130206175128.1b64196d@skate>
In-Reply-To: <20130131224459.GA11846@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<2776630.gp5gC9tvLk@wuerfel>
	<20130131180249.GA30869@obsidianresearch.com>
	<201301312046.22560.arnd@arndb.de>
	<20130131224459.GA11846@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Thu, 31 Jan 2013 15:44:59 -0700, Jason Gunthorpe wrote:

> > For the primary bus, yes, but there are still two options for the
> > second one: you can either start at 0 again or you can continue
> 
> No, for *all* links. You use a mmap scheme with 4k granularity, I
> explained in a past email, but to quickly review..
> 
> - Each link gets 64k of reserved physical address space for IO,
>   this is just set aside, no MBUS windows are permantently assigned.
> - Linux is told to use a 64k IO range with bus IO address 0->0xFFFF
> - When the IO base/limit register in the link PCI-PCI bridge is programmed
>   the driver gets a 4k aligned region somewhere from 0->0xFFFF and then:
>     - Allocates a 64k MBUS window that translates physical address
>       0xZZZZxxxx to IO bus address 0x0000xxxx (goes in the TLP) for
>       that link
>     - Uses pci_ioremap_io to map the fraction of the link's 64k MBUS window
>       allocated to that bridge to the correct offset in the 
>       PCI_IO_VIRT_BASE region

This, I think I now understand.

> So you'd end up with a MMU mapping something like:
>   PCI_IO_VIRT_BASE    MBUS_IO_PHYS_BASE
>     0->4k          => 0      -> 4k             // 4k assigned to link0
>     4k->8k         => 64k+4k -> 64k+8k         // 4k assigned to link1
>     8k->24k        => 128k+8k -> 128k+24k      // 8k assigned to link2

I am not sure to understand your example, starting at the second line.
Shouldn't the second line have been

      4k->8k         => 64k -> 64k+4k

 ?

If you do:

      4k->8k         => 64k+4k -> 64k+8k

as you suggested, then when the device driver will do an inl(0x4) on
this device, the device will receive the equivalent of an inl(0x1004),
no?

I understand that I have two choices here:

 * First one is to make the I/O regions of all PCIe links fit below the
   default IO_SPACE_LIMIT (0xffff) by doing the mapping trick you
   described above.

 * Second one is to have one 64 KB block for each PCIe link, which
   would require raising the IO_SPACE_LIMIT on this platform.

Is this correct?

If so, then what I don't understand is that Kirkwood does the second
thing (from arch/arm/mach-kirkwood/pcie.c) :

        switch (index) {
        case 0:
		[...]
		/* Here the code is mapping 0 -> 64k */
                pci_ioremap_io(SZ_64K * sys->busnr, KIRKWOOD_PCIE_IO_PHYS_BASE);
                break;
        case 1:
		[...]
		/* And here 64k -> 128k */
                pci_ioremap_io(SZ_64K * sys->busnr,
                               KIRKWOOD_PCIE1_IO_PHYS_BASE);
                break;

So it has PCI I/O space from 0 to 128k, but still it seems to use the
default IO_SPACE_LIMIT of 0xffff. How can this work? Maybe nobody every
used a device on the second PCIe link that required I/O accesses.

> Where the physical mbus window for each link starts on each 64k block.
> 
> Thomas: This solves the need to have alignment of the IO regions, and
> gets rid of any trouble with 32 bit IO addreses, however you'll need
> to allocate the remap capable mbus windows separately for use by IO
> mappings..
> 
> Though, there is still a problem with the MMIO mbus window
> alignment. mbus windows are aligned to a multiple of their size, PCI
> MMIO bridge windows are always aligned to 1M...

Can't this be solved using the window_alignement() hook we've been
discussing separately? Just like we teach the Linux PCI core about our
alignment requirements of 64K for the I/O regions, we could teach it
about our alignment requirement on memory regions as well. No?

> Though, it is my hope that Thomas's driver will work on Kirkwood as
> well...

Yes, my plan is to have it working on Kirkwood. This WE, I was given a
Kirkwood based machine that has a usable PCIe device.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
