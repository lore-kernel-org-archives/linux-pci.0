Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59894 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab3CFKoR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 05:44:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Wed, 6 Mar 2013 10:43:44 +0000
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302131037.02464.arnd@arndb.de> <20130306105009.1ed18a87@skate>
In-Reply-To: <20130306105009.1ed18a87@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201303061043.44475.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 06 March 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Wed, 13 Feb 2013 10:37:02 +0000, Arnd Bergmann wrote:
> 
> > Yes, of course. And the ranges property tells you how to turn the
> > first address space into the second address space. So the above
> > property defines that the PCI bus I/O space range from 0 to 0x10000
> > gets converted into the host MMIO range 0xc0000000 to 0xc0010000 on
> > the host, and the PCI bus memory space range from 0 to 0x08000000
> > gets converted to the host MMIO range 0xc1000000 to 0xc9000000.
> > 
> > The output of your of_pci_process_ranges() function is the host MMIO
> > range, not the range in the bus address space, so it has to be
> > IORESOURCE_MEM.
> 
> I am sorry, but I don't get how this can work. My code currently relies
> on the DT encoding one I/O resource and one MEM resource to find which
> is one to use.
> 
> Right now, in the ranges property of my DT, I have:
> 
>           0x81000000 0 0          0xc0000000 0 0x00010000   /* downstream I/O */
>           0x82000000 0 0          0xc1000000 0 0x08000000>; /* non-prefetchable memory */

This looks correct, yes, although as I suggested earlier it would be more
conventional to use

          0x81000000 0 0          0xc0000000 0 0x00010000   /* downstream I/O */
          0x82000000 0 0xc1000000 0xc1000000 0 0x08000000>; /* non-prefetchable memory */


> And the code parsing this does:
> 
>         /* Get the I/O and memory ranges from DT */
>         while ((range = of_pci_process_ranges(np, &res, range)) != NULL) {
>                 if (resource_type(&res) == IORESOURCE_IO) {
>                         memcpy(&pcie->io, &res, sizeof(res));
>                         memcpy(&pcie->realio, &res, sizeof(res));
>                         pcie->io.name = "I/O";
>                         pcie->realio.start &= 0xFFFFF;
>                         pcie->realio.end   &= 0xFFFFF;
>                 }
>                 if (resource_type(&res) == IORESOURCE_MEM) {
>                         memcpy(&pcie->mem, &res, sizeof(res));
>                         pcie->mem.name = "MEM";
>                 }
>         }
> 
> As you can see, it relies on one of the two ranges being for I/O
> (address starts with 0x81), and another range being for MEM (address
> starts with 0x82).
> 
> If I make both ranges start with 0x82, how can my code differentiate
> between the range used for I/O and the range used for MEM?

No, I mean the parser is wrong ;-)

I think the proper solution would be to change the parser to return both
the host side resource, and another resource as the bus view. In the example
above, the resources you get should be:

io_host  = { .flags = IORESOURCE_MEM, .start = 0xc0000000, .end = 0xc000ffff };
io_bus   = { .flags = IORESOURCE_IO,  .start = 0,          .end =     0xffff };
mem_host = { .flags = IORESOURCE_MEM, .start = 0xc1000000, .end = 0xc9ffffff };
mem_bus  = { .flags = IORESOURCE_MEM, .start = 0,          .end =  0x7ffffff };

indicating that the PCI I/O space range 0-0xffff is mapped to the host physical
address space at 0xc0000000-0xc000ffff, and that the PCI memory space range 
0-0x7ffffff is mapped to host physical address space 0xc1000000-0xc9ffffff.

You really need all four resources to set up the mapping. For I/O space, you
should do

	pci_ioremap_io(io_bus->start, io_host->start);

and for the memory space, you need both to set up the correct mem_offset:

	pci_add_resource_offset(&sys->resources, mem_host, mem_host->start - mem_bus->start);

If you do as I suggested above and set the memory window to an identity
map at bus address 0xc1000000, the second argument to pci_add_resource_offset
becomes zero, indicating that any access to the window results in a bus
access at the same address.

	Arnd
