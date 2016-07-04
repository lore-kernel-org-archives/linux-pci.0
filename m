Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:49871 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbcGDNnp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 09:43:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Date: Mon, 04 Jul 2016 15:46:44 +0200
Message-ID: <38942848.fvm5hraBhy@wuerfel>
In-Reply-To: <20160704095627.GG8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com> <3872522.jdXcQClxV5@wuerfel> <20160704095627.GG8609@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, July 4, 2016 10:56:27 AM CEST Liviu Dudau wrote:
> On Fri, Jul 01, 2016 at 06:30:24PM +0200, Arnd Bergmann wrote:
> > On Friday, July 1, 2016 5:09:23 PM CEST Liviu Dudau wrote:

> > > Don't get me wrong, clearly someone needs to create an instance of pci_host_bridge.
> > > What I want people to accept is that in the PCI(e) architecture there is nothing that
> > > stops a piece of HW that used to be the bridge between host and underlying bus into
> > > becoming the bridge between a higher PCI(e) bus and the bus underneath. If the writes
> > > to the configuration registers happens somehow, the Host Bridge doesn't even know if
> > > it is talking to the actual host. Can the driver in that case make sure it did not made
> > > assumptions that were tied to a specific SoC implementation?
> > 
> > Sorry, I'm not really following what you mean with that, or what the
> > consequence is for the Linux implementation. Can you try to rephrase this?
> 
> I'm thinking drivers expecting to drive the bridge between the host and the PCI bus.
> When that HW is used to bridge between another bus (PCI or PCIe) because the
> functionality was there all the time in terms of signals, the driver's assumptions
> break down. But maybe I'm being too theoretical and such beasts don't exist? (I remember
> seeing a network card that had native PCI chip plus an added PCIe-to-PCI bridge and
> the driver was tripping badly, but I can't remember the exact details.

I think we should expect all non-host PCI bridges to behave according to the
normal PCI spec and get handled by the PCI core.

There are some handlers for broken bridges in drivers/pci/quirks.c, which
is not nice but there is little alternative, and I don't think that
hooking into the PCI host bridge driver code would help here.

	Arnd
