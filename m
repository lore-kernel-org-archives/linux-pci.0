Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62613 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab3BARpk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 12:45:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Fri, 1 Feb 2013 17:45:29 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201302011607.49205.arnd@arndb.de> <20130201162638.GT23505@n2100.arm.linux.org.uk>
In-Reply-To: <20130201162638.GT23505@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302011745.29223.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 01 February 2013, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 04:07:49PM +0000, Arnd Bergmann wrote:
> > On Friday 01 February 2013, Thomas Petazzoni wrote:
> > > So there is really a range of I/O addresses associated to it, even
> > > though the device will apparently not use it. Would it be possible to
> > > detect that the I/O range is not used by the device, and therefore
> > > avoid the allocation of an address decoding window for this I/O range?
> > 
> > I suspect it just gets disabled because the port number 0xc0010000 is
> > larger than IO_PORT_LIMIT and we cannot access that offset inside
> > of the virtual memory window we use for PIO.
> 
> You're running into that trap again which you fall into on other
> architectures.
> 
> If you arrange for your PCI IO space to start at 0 rather than the
> physical address that it appears on your CPU, then you shouldn't
> end up with it extending up to something at 0xcXXXXXXX.
> 
> Remember that we should be ensuring that inb(0) hits the first address
> of the cross-subarch PCI IO area - this alway requires that any sub-arch
> taking part in a multiplatform kernel must start its IO space addresses
> at 0 and not the physical address on the local CPU.

Yes, that was my point. I think in this case, the bug is in the new
of_pci_process_ranges functions, which returns a 'struct resource'
translated into IORESOURCE_MEM space, but with the type set
to IORESOURCE_IO. This resource then gets passed to 
pci_add_resource_offset().

	Arnd
