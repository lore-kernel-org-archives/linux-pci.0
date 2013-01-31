Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60186 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab3AaOu0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 09:50:26 -0500
Date: Thu, 31 Jan 2013 14:50:02 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
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
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
	systems
Message-ID: <20130131145002.GZ23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <20130130113245.GH23505@n2100.arm.linux.org.uk> <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <20130130150856.GJ23505@n2100.arm.linux.org.uk> <20130130151934.GK23505@n2100.arm.linux.org.uk> <20130130163659.75360dba@skate> <20130130154602.GL23505@n2100.arm.linux.org.uk> <20130131153041.35fa3b60@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130131153041.35fa3b60@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 31, 2013 at 03:30:41PM +0100, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Wed, 30 Jan 2013 15:46:02 +0000, Russell King - ARM Linux wrote:
> 
> > +resource_size_t pcibios_window_alignment(struct pci_bus *bus,
> > +					 unsigned long type)
> > +{
> > +	struct pci_sys_data *sys = bus->sysdata;
> > +
> > +	/* Ignore downstream buses */
> > +	if (!bus->parent) {
> > +		if (type & IORESOURCE_MEM)
> > +			return sys->win_align_mem;
> > +		if (type & IORESOURCE_IO)
> > +			return sys->win_align_io;
> > +	}
> > +	return 1;
> > +}
> > +
> 
> Unfortunately, this doesn't work as is for me: the if (!bus->parent)
> prevents the thing from being effective. Here my lspci output:
> 
> # /usr/sbin/lspci 
> 00:00.0 Host bridge: Marvell Technology Group Ltd. Device 102d
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
> 03:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
> 05:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
> 
> And the function pcibios_window_alignment() only gets called for bus 1,
> 2, 3, 4, 5, 6 and never for bus 0.

That's the exact reverse of what I'd expect: the child buses should
have a non-NULL parent pointer.  Hmm.  Try changing that for !bus->self -
that should make it effective only on the host bridge.

But... hang on...

/*
 * Returns true if the pci bus is root (behind host-pci bridge),
 * false otherwise
 */
static inline bool pci_is_root_bus(struct pci_bus *pbus)
{
        return !(pbus->parent);
}

So the original test _is_ correct, and should only be triggered for
the _root_ bus, that being bus 0 in the above case.

But... wait a moment, what are you saying?  Which bridges need this
fixup?  The Marvell PCI-to-PCI bridges or the host bridge?
