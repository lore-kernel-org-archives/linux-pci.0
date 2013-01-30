Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64773 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab3A3KEB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 05:04:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Date: Wed, 30 Jan 2013 10:03:43 +0000
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201301300946.54040.arnd@arndb.de> <20130130105418.7f53bc77@skate>
In-Reply-To: <20130130105418.7f53bc77@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301301003.44272.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 January 2013, Thomas Petazzoni wrote:

> I am not sure where this 0xfee00000 address comes from, but in my case
> (and I think in the Tegra PCI driver as well), we tell the Linux PCI
> core from which addresses the I/O ranges should be allocated. In my DT,
> I have:
> 
>                         ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
>                                   0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
>                                   0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
>                                   0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
>                                   0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
>                                   0x00002800 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
>                                   0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
>                                   0x00003000 0 0xd0084000 0xd0084000 0 0x00002000   /* port 1.1 registers */
>                                   0x00003800 0 0xd0088000 0xd0088000 0 0x00002000   /* port 1.2 registers */
>                                   0x00004000 0 0xd008C000 0xd008C000 0 0x00002000   /* port 1.3 registers */
>                                   0x81000000 0 0          0xc0000000 0 0x00100000   /* downstream I/O */
>                                   0x82000000 0 0          0xc1000000 0 0x08000000>; /* non-prefetchable memory */
> 
> And then, the Marvell PCI driver gets the "downstream I/O" range,
> parses it into a "struct resource", and then does (where &pcie->io is
> the struct resource into which we parsed the "downstream I/O" range):
> 
>         pci_add_resource_offset(&sys->resources, &pcie->io, sys->io_offset);
> 	[...]
> 	pci_ioremap_io(nr * SZ_64K, pcie->io.start);

0xfee00000 is the platform independent virtual address that pci_ioremap_io
maps your platform specific physical address (from pcie->io.start) to. It's
defined (in the kernel I am looking at) in asm/io.h as

#define PCI_IO_VIRT_BASE        0xfee00000

and used by pci_ioremap_io as

        return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
                                  PCI_IO_VIRT_BASE + offset + SZ_64K,
                                  phys_addr,
                                  __pgprot(get_mem_type(MT_DEVICE)->prot_pte));


> And it works just fine, I get my I/O ranges allocated at 0xc0000000 for
> the first device, 0xc0010000 (i.e base address + 64KB) for the second
> device, etc.

(void*)0xc0000000 is the normal PAGE_OFFSET. If you map your I/O space there,
you are in big trouble because that is supposed to have the start of your
physical memory mapping.

	Arnd
