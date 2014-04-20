Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41321 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaDTTM3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Apr 2014 15:12:29 -0400
Date: Sun, 20 Apr 2014 15:11:50 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Lior Amsalem <alior@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Nadav Haklai <nadavh@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Willy Tarreau <w@1wt.eu>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Fixes for Armada 370/XP PCIe
Message-ID: <20140420191150.GH28159@titan.lakedaemon.net>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Fri, Apr 18, 2014 at 02:19:46PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of commits fixes a number of problems in the PCIe support of
> the Armada 370 and Armada XP SoCs, allowing to use PCIe devices that
> were not properly supported until now.
> 
> Due to the interaction of PCIe with other subsystems, the fixes are
> not limited to drivers/pci, but also touch drivers/bus and
> drivers/irqchip.

There is no official maintainer for drivers/bus, so we usually take
those throught the arm-soc tree.  Thomas (tglx) takes pull requests of
branches mvebu sets up for him, so the irqchip stuff is handled.

Would you mind Acking #4 and #7, particularly #7 for us?  It would sure
simplify getting this set of fixes into mainline.

> Here are the details of the patches:
> 
>  * The first three patches are fixes in the MSI handling. They fix
>    problems with PCIe device drivers trying to use MSI-X (which we
>    don't support), and incorrect freeing of MSIs causing kernel panics
>    when PCIe device drivers try to allocate/free MSIs several times.
> 
>    They touch drivers/irqchip/ only, and they are independent from the
>    rest of the series, both from a build and a runtime point of view.
> 
>    These bugs exist since the MSI support was added, in v3.13. The
>    commits carry the necessary Fixes and Cc to stable informations.
> 
>  * The fourth patch fixes an off-by-one in the computed size of MBus
>    windows. This only worked because the mvebu-mbus driver was
>    silently accepting invalid sizes. I've marked it for stable because
>    it really is bug, but even though it's not visible by itself, it is
>    needed for other patches in the series.
> 
>    This patch touches drivers/pci/host, and should probably be taken
>    by the mvebu maintainers, with the Ack of the PCI maintainer, as it
>    is a runtime dependency for the next patch.
> 
>    This patch is marked for stable all the way to when the PCI driver
>    was introduced.
> 
>  * The fifth patch make the mvebu-mbus driver check (and loudly
>    complain) if it is asked to create invalid regions (whose base
>    address or size are not compatible with the documented MBus
>    requirements).
> 
>    This patch touches drivers/bus, and should probably be taken by the
>    mvebu maintainers. As explained above, it is mandatory to have
>    PATCH 4 applied before PATCH 5: there is a runtime dependency
>    between the two (but no build time dependency).
> 
>    This patch is not marked for stable, as it only adds some
>    additional debugging information, which while very useful, is not
>    technically stable material.
> 
>  * The sixth patch relaxes a check in mvebu-mbus driver about
>    conflicting windows, which is necessary
> 
>    This patch touches drivers/bus, and should probably be taken by the
>    mvebu maintainers. It is not a fix by itself, but it is required
>    for the last patch, which is a fix. Therefore, it is marked for
>    stable, all the way to when the mvebu-mbus driver was introduced.
> 
>  * The seventh patch improves the pci-mvebu driver to allow the
>    creation of multiple MBus windows when the PCI BAR calculated by
>    the Linux PCI core has a non power-of-two size. This is needed
>    because MBus windows can only have power-of-two sizes. Until now,
>    we were configuring invalid MBus windows, which with certain PCIe
>    devices, was either causing kernel panics at boot time or
>    misfunction of the device.
...
> Jason Gunthorpe (1):
>   bus: mvebu-mbus: Avoid setting an undefined window size
> 
> Neil Greatorex (1):
>   irqchip: armada-370-xp: Fix releasing of MSIs
> 
> Thomas Petazzoni (4):
>   irqchip: armada-370-xp: fix invalid cast of signed value into unsigned
>     variable
>   irqchip: armada-370-xp: implement the ->check_device() msi_chip
>     operation
>   bus: mvebu-mbus: allow several windows with the same target/attribute
>   pci: pci-mvebu: split PCIe BARs into multiple MBus windows when needed
> 
> Willy Tarreau (1):
>   pci: mvebu: fix off-by-one in the computed size of the mbus windows
> 
>  drivers/bus/mvebu-mbus.c            | 22 ++++++---
>  drivers/irqchip/irq-armada-370-xp.c | 17 +++++--
>  drivers/pci/host/pci-mvebu.c        | 92 ++++++++++++++++++++++++++++++-------
>  3 files changed, 106 insertions(+), 25 deletions(-)

thx,

Jason.
