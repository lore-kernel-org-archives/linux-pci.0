Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59061 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab3A3PJI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 10:09:08 -0500
Date: Wed, 30 Jan 2013 15:08:56 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
	systems
Message-ID: <20130130150856.GJ23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <20130130113245.GH23505@n2100.arm.linux.org.uk> <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 30, 2013 at 01:03:44PM +0100, Thierry Reding wrote:
> On Wed, Jan 30, 2013 at 11:32:46AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 28, 2013 at 07:56:28PM +0100, Thomas Petazzoni wrote:
> > > +static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
> > > +						 const struct resource *res,
> > > +						 resource_size_t start,
> > > +						 resource_size_t size,
> > > +						 resource_size_t align)
> > > +{
> > > +	if (!(res->flags & IORESOURCE_IO))
> > > +		return start;
> > > +
> > > +	/*
> > > +	 * The I/O regions must be 64K aligned, because the
> > > +	 * granularity of PCIe I/O address decoding windows is 64 K
> > > +	 */
> > > +	return round_up(start, SZ_64K);
> > > +}
> > 
> > You do realise that this will result in all PCI I/O BARs being rounded
> > up to 64K.
> > 
> > I've just been digging through the PCI code and have come across a
> > function - pcibios_window_alignment() - which the PCI code allows to be
> > overriden which allows you to increase the alignment requirement of
> > bridge windows.  It takes the PCI bus and window type as arguments.
> > 
> > I'd suggest using that, and checking whether the bus which is passed
> > corresponds with a bus which gives you problems, so that you don't
> > impose the 64K requirement on downstream bridges.
> 
> That approach isn't going to work very well with multi-platform, though,
> since the function can only be overridden on a per-architecture basis.

The same can be said of all the various other functions which the PCI
stuff expects the arch to provide, yet we seem to cope just fine...
