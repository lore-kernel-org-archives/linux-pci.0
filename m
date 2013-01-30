Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42350 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab3A3W2y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 17:28:54 -0500
Date: Wed, 30 Jan 2013 23:28:36 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130130232836.1b1fd89b@skate>
In-Reply-To: <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
	<20130129055508.GA3339@obsidianresearch.com>
	<CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
	<20130129184157.GA29274@obsidianresearch.com>
	<CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
	<20130129191853.GB29274@obsidianresearch.com>
	<CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
	<CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
	<20130130103501.1873d39c@skate>
	<CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Wed, 30 Jan 2013 11:52:15 -0700, Bjorn Helgaas wrote:

> I'm most concerned about the stuff in drivers/pci.  I hesitate to
> merge drivers/pci/sw-pci-pci-bridge.c as-is because it's a model
> that's not connected to hardware and only works in a completely static
> situation, and the rest of the PCI core can't really deal with that.
> 
> But I don't think supporting hotplug should be a show-stopper at this
> point, either.  It sounds like we might be heading towards hooking
> this up more directly to the Marvell hardware, which will make it more
> arch-dependent.  Something like that could either go in arch/arm, or
> in some not-quite-so-generic spot under drivers/pci.

If you really don't want sw-pci-pci-bridge.c in drivers/pci, then I can
make it a part of the drivers/pci/host/pci-mvebu.c driver itself. I
initially followed the idea started by Thierry Redding for the emulated
host bridge, but if you feel that this emulated PCI-to-PCI bridge is
too specific to this driver, then I'm fine with keeping it inside the
driver itself.

> >> I also forgot about the bus number munging in mvebu_pcie_rd_conf().
> >> The PCI core can update the bridge secondary/subordinate registers.
> >> It looks like you don't support writing to them, and the read path
> >> (pci_sw_pci_bridge_read()) looks like it doesn't do any translation
> >> between the hardware and Linux bus numbers.  I don't understand the
> >> system well enough to know if this is an issue.
> >
> > Right. Could you explain a little bit for what reasons the PCI core
> > could update the secondary/subordinate registers, and to what
> > values it sets them?
> 
> The secondary/subordinate registers effectively define a bus number
> aperture that tells the bridge which transactions to claim and forward
> downstream.  When enumerating devices, we may update the subordinate
> bus number to widen the aperture so we can enumerate an arbitrary tree
> behind the bridge.  When we're finished, we'll probably narrow it by
> updating the subordinate again, so the unused bus number space can be
> used for other bridges.  I don't know the exact details of the
> algorithm, and they're likely to change anyway, but pci_scan_bridge()
> is where most of it happens.
> 
> It looks like your current system doesn't support trees below the
> bridges, but hopefully we can make it so the generic enumeration
> algorithms still work.

In practice, in our situation, there isn't a tree below the bridge.
There is one single device. I'd prefer to not implement features that I
cannot effectively test, and let the implementation of those additional
features to whoever will need them, and therefore be able to test them.

I guess that if I integrate the PCI-to-PCI bridge emulation code within
the Marvell driver, then I can keep it fairly limited to whatever the
Marvell PCI driver requires, no?

> > For now, I statically assign the secondary bus register value to be
> > X+1, where X is the number of the PCIe interface, since X=0 is
> > reserved for the root bus (which has the host bridge and the
> > PCI-to-PCI bridges).
> 
> That makes sense but limits you to a single bus (and really, a single
> device since this is PCIe) below the bridge.

Which is exactly what is happening here.

> > Also, could you detail what kind of translation I should be doing
> > when reading the hardware and Linux bus numbers?
> 
> I'm hoping that the register Jason mentioned is enough to avoid the
> need for translation.  If it's not, we can explore this a bit more.

Ok.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
