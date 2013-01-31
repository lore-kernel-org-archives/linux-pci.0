Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:46502 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab3AaQEI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 11:04:08 -0500
Date: Thu, 31 Jan 2013 17:04:01 +0100
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
Message-ID: <20130131170401.4b3bfbbf@skate>
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

The PCI-to-PCI bridge specification says that the Primary Bus Number
Register, Secondary Bus Number Register and Subordinate Bus Number
Register of the PCI configuration space of a PCI-to-PCI bridge should
all be set to 0 after reset.

Until now, I was forcing a specific value of the Secondary Bus Number
and Subordinate Bus Number (1 for my first bridge, 2 for my second
bridge, etc.).

Following you're recommendation, I've changed this, and left those
values initialized to 0 by default, in order to let Linux set correct
values. Yes, Linux does assign appropriate values in the Secondary Bus
Number Register. But before that Linux also complains loudly that the
bridge configuration is invalid:

pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:06.0: bridge configuration invalid ([bus 00-00]), reconfiguring

Looking at the code, we have:

        /* Check if setup is sensible at all */
        if (!pass &&
            (primary != bus->number || secondary <= bus->number ||
             secondary > subordinate)) {
                dev_info(&dev->dev, "bridge configuration invalid ([bus %02x-%02x]), reconfiguring\n",
                         secondary, subordinate);
                broken = 1;
        }

Due to the default values of the Primary Bus Number Register, Secondary
Bus Number Register and Subordinate Bus Number Register, we have:

 primary = 0
 secondary = 0
 subordinate = 0

We are enumerating the root bus, so bus->number = 0. Therefore:

 * The test primary != bus->number is false, so it's not the problem.

 * secondary <= bus->number is true, because secondary = 0, and
   bus->number = 0. It is the problem.

 * secondary > subordinate is false.

So I'm not sure what to do with this...

Thoas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
