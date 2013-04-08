Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60487 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759954Ab3DHWOV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 18:14:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Tue, 9 Apr 2013 00:14:06 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com> <201304082334.13186.arnd@arndb.de> <20130408235341.7012b791@skate>
In-Reply-To: <20130408235341.7012b791@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201304090014.06959.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 April 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Mon, 8 Apr 2013 23:34:12 +0200, Arnd Bergmann wrote:
> 
> > > No, I'm assuming PCIBIOS_MIN_IO is always 0. So presumarly, this should
> > > be something like:
> > > 
> > >         pcie->realio.end = min(PCIBIOS_MIN_IO +
> > >                                 resource_size(&pcie->io),
> > >                                 IO_SPACE_LIMIT);
> > > 
> > 
> > Normally PCIBIOS_MIN_IO is 0x1000, since the first 4096 ports are reserved
> > for ISA and PCMCIA compatible drivers and should not be assigned to
> > PCI devices. So the first port should get ports 0x1000 to 0xffff, later
> > ones can used the entire 65536 ports e.g. 0x10000 to 0x1ffff.
> 
> Then I guess it should work with the code I'm proposing here, no?
> 
> Note: this pcie->realio region is global: it will be shared by all PCIe
> interfaces.

I think it's still wrong, unless you guarantee that
resource_start(&pcie->io) is the same as PCIBIOS_MIN_IO.

Why don't you just read the start and end values from the ranges
property? I assume you want to run with io_offset=0, so you really
need

	pcie->realio.type = IORESOURCE_IO;
	pcie->realio.start = max(PCIBIOS_MIN_IO, range->pci_addr);
	pcie->realio.end = max(IO_SPACE_LIMIT, range->pci_addr + range->size);

	Arnd
