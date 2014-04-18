Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:32993 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750857AbaDRMT4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:19:56 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>
Subject: [PATCH 0/7] Fixes for Armada 370/XP PCIe
Date: Fri, 18 Apr 2014 14:19:46 +0200
Message-Id: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This set of commits fixes a number of problems in the PCIe support of
the Armada 370 and Armada XP SoCs, allowing to use PCIe devices that
were not properly supported until now.

Due to the interaction of PCIe with other subsystems, the fixes are
not limited to drivers/pci, but also touch drivers/bus and
drivers/irqchip.

Here are the details of the patches:

 * The first three patches are fixes in the MSI handling. They fix
   problems with PCIe device drivers trying to use MSI-X (which we
   don't support), and incorrect freeing of MSIs causing kernel panics
   when PCIe device drivers try to allocate/free MSIs several times.

   They touch drivers/irqchip/ only, and they are independent from the
   rest of the series, both from a build and a runtime point of view.

   These bugs exist since the MSI support was added, in v3.13. The
   commits carry the necessary Fixes and Cc to stable informations.

 * The fourth patch fixes an off-by-one in the computed size of MBus
   windows. This only worked because the mvebu-mbus driver was
   silently accepting invalid sizes. I've marked it for stable because
   it really is bug, but even though it's not visible by itself, it is
   needed for other patches in the series.

   This patch touches drivers/pci/host, and should probably be taken
   by the mvebu maintainers, with the Ack of the PCI maintainer, as it
   is a runtime dependency for the next patch.

   This patch is marked for stable all the way to when the PCI driver
   was introduced.

 * The fifth patch make the mvebu-mbus driver check (and loudly
   complain) if it is asked to create invalid regions (whose base
   address or size are not compatible with the documented MBus
   requirements).

   This patch touches drivers/bus, and should probably be taken by the
   mvebu maintainers. As explained above, it is mandatory to have
   PATCH 4 applied before PATCH 5: there is a runtime dependency
   between the two (but no build time dependency).

   This patch is not marked for stable, as it only adds some
   additional debugging information, which while very useful, is not
   technically stable material.

 * The sixth patch relaxes a check in mvebu-mbus driver about
   conflicting windows, which is necessary

   This patch touches drivers/bus, and should probably be taken by the
   mvebu maintainers. It is not a fix by itself, but it is required
   for the last patch, which is a fix. Therefore, it is marked for
   stable, all the way to when the mvebu-mbus driver was introduced.

 * The seventh patch improves the pci-mvebu driver to allow the
   creation of multiple MBus windows when the PCI BAR calculated by
   the Linux PCI core has a non power-of-two size. This is needed
   because MBus windows can only have power-of-two sizes. Until now,
   we were configuring invalid MBus windows, which with certain PCIe
   devices, was either causing kernel panics at boot time or
   misfunction of the device.

These patches have been tested by Neil Greatorex
<neil@fatboyfat.co.uk> who initially reported the issues, have also
been tested by Willy Tarreau and Matthew Winter (even though they
didn't give their formal Tested-by [1] [2]), and have been heavily
discussed with Jason Gunthorpe.

Note that there are still two known issues in the mvebu PCIe handling:

 1/ When earlyprintk is disabled, we have a timing / PHY reset issue
    which leads to the PCIe device connected on the first interface to
    not be detected. We already have patches floating around, but
    nothing that we are all happy with yet.

 2/ When a PCI IGB card is plugged with many other PCI devices in a
    system, the IGB card initialization doesn't work ('igb
    0000:01:00.0: The NVM Checksum Is Not Valid'). We are still
    working on this issue.

These two issues will be handled separately.

Thanks,

Thomas

[1] http://www.spinics.net/lists/linux-pci/msg30406.html
[2] http://www.spinics.net/lists/linux-pci/msg30444.html

Jason Gunthorpe (1):
  bus: mvebu-mbus: Avoid setting an undefined window size

Neil Greatorex (1):
  irqchip: armada-370-xp: Fix releasing of MSIs

Thomas Petazzoni (4):
  irqchip: armada-370-xp: fix invalid cast of signed value into unsigned
    variable
  irqchip: armada-370-xp: implement the ->check_device() msi_chip
    operation
  bus: mvebu-mbus: allow several windows with the same target/attribute
  pci: pci-mvebu: split PCIe BARs into multiple MBus windows when needed

Willy Tarreau (1):
  pci: mvebu: fix off-by-one in the computed size of the mbus windows

 drivers/bus/mvebu-mbus.c            | 22 ++++++---
 drivers/irqchip/irq-armada-370-xp.c | 17 +++++--
 drivers/pci/host/pci-mvebu.c        | 92 ++++++++++++++++++++++++++++++-------
 3 files changed, 106 insertions(+), 25 deletions(-)

-- 
1.9.2

