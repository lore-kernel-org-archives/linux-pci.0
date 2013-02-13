Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64430 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab3BMKhP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 05:37:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Wed, 13 Feb 2013 10:37:02 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302130929.21326.arnd@arndb.de> <20130213104051.07bcffe0@skate>
In-Reply-To: <20130213104051.07bcffe0@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302131037.02464.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 13 February 2013, Thomas Petazzoni wrote:
> > > Indeed. So maybe I should mark this resource as being IORESOURCE_MEM
> > > in the DT.
> > 
> > The DT seems fine here, just the code that interprets it is a little
> > unusual. Maybe you can change the calling convention of that function
> > to pass the type of resource you want as an argument?
> 
> Erm? The type of the resource is encoded into the DT:
> 
> +                                 0x81000000 0 0          0xc0000000 0 0x00010000   /* downstream I/O */
> +                                 0x82000000 0 0          0xc1000000 0 0x08000000>; /* non-prefetchable memory */
> 
> From http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge:
> 
>      phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
>     phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
>     phys.low cell: llllllll llllllll llllllll llllllll 
> 
>  ss: space code
> 
>     00: configuration space
>     01: I/O space
>     10: 32 bit memory space
>     11: 64 bit memory space 
> 
> So the 0x81 at the beginning of the first line means I/O space, the
> 0x82 at the beginning of the second line means 32 bits memory space.
> The of_pci_process_ranges() function simply decodes those informations
> and fills the struct resource it returns with the appropriate resource
> type.

Yes, of course. And the ranges property tells you how to turn the first
address space into the second address space. So the above property
defines that the PCI bus I/O space range from 0 to 0x10000 gets converted
into the host MMIO range 0xc0000000 to 0xc0010000 on the host, and
the PCI bus memory space range from 0 to 0x08000000 gets converted to
the host MMIO range 0xc1000000 to 0xc9000000.

The output of your of_pci_process_ranges() function is the host MMIO
range, not the range in the bus address space, so it has to be
IORESOURCE_MEM.

Note that the memory range you have given in the example is a little
unconventional. Usually we try to have an identity mapping between
PCI bus memory space addresses and host MMIO space, which would
result in a zero sys->mem_offset value in addition to the sys->io_offset
value that is already zero.

Is there a limitation with the way that your address translation
windows are set up? What I would hope you could do is a memory window
like 

          <0x82000000 0 0xc1000000   0xc1000000 0 0x08000000>; /* non-prefetchable memory */

that translates the host MMIO range 0xc1000000-0xc9000000 into  bus
address 0xc1000000-0xc9000000 instead of bus address 0x00000000-0x08000000.
Would it help if you switch the addresses around, so that the physical
location of the memory space window is naturally aligned at
0xc0000000-0xc8000000 and the I/O space window is at 0xc8000000-0xc8100000?

	Arnd
