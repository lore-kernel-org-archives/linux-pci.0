Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39516 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3A3JyX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 04:54:23 -0500
Date: Wed, 30 Jan 2013 10:54:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130130105418.7f53bc77@skate>
In-Reply-To: <201301300946.54040.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301291645.08040.arnd@arndb.de>
	<20130130045655.GE5734@obsidianresearch.com>
	<201301300946.54040.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Wed, 30 Jan 2013 09:46:53 +0000, Arnd Bergmann wrote:
> On Wednesday 30 January 2013, Jason Gunthorpe wrote:
> > > But we normally only assign a 64 KB I/O window to each PCI host bridge.
> > > Requiring PCI bridges to be space 64 KB apart would mean that we cannot
> > > actually support bridges at all.
> > 
> > The PCI resource code uses full 32 bit integers when it handles IO
> > addresses, so this actually does sort of work out.
> 
> However, we only reserve 1 MB (I think) virtual address window for all
> I/O spaces of all PCI domains combined, at a fixed location (0xfee00000).
> This means we can have at most 16 such windows at run-time. That can
> be changed if necessary, but it seems like overkill when in practice
> you only need a few bytes at most.

I am not sure where this 0xfee00000 address comes from, but in my case
(and I think in the Tegra PCI driver as well), we tell the Linux PCI
core from which addresses the I/O ranges should be allocated. In my DT,
I have:

                        ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
                                  0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
                                  0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
                                  0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
                                  0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
                                  0x00002800 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
                                  0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
                                  0x00003000 0 0xd0084000 0xd0084000 0 0x00002000   /* port 1.1 registers */
                                  0x00003800 0 0xd0088000 0xd0088000 0 0x00002000   /* port 1.2 registers */
                                  0x00004000 0 0xd008C000 0xd008C000 0 0x00002000   /* port 1.3 registers */
                                  0x81000000 0 0          0xc0000000 0 0x00100000   /* downstream I/O */
                                  0x82000000 0 0          0xc1000000 0 0x08000000>; /* non-prefetchable memory */

And then, the Marvell PCI driver gets the "downstream I/O" range,
parses it into a "struct resource", and then does (where &pcie->io is
the struct resource into which we parsed the "downstream I/O" range):

        pci_add_resource_offset(&sys->resources, &pcie->io, sys->io_offset);
	[...]
	pci_ioremap_io(nr * SZ_64K, pcie->io.start);

And it works just fine, I get my I/O ranges allocated at 0xc0000000 for
the first device, 0xc0010000 (i.e base address + 64KB) for the second
device, etc.

The Tegra PCI driver does exactly the same (I shamelessly copied what
Thierry has done).

I somehow have the feeling that we are looking for problems that simply
don't exist...

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
