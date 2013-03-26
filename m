Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54137 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3CZQw3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:29 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFCv1 00/11] MSI support for Marvell EBU PCIe driver
Date: Tue, 26 Mar 2013 17:52:15 +0100
Message-Id: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This set of patches introduces Message Signaled Interrupt support in
the Marvell EBU PCIe driver. It has been successfully tested on the
Armada XP GP platform and the Armada 370 DB platform with an Intel
e1000e PCIe network card that supports MSI.

This is based on work done by Lior Amsalem <alior@marvell.com>.

The patches do the following:

 * Patches 1, 2 and 3 move the IRQ controller driver of Armada 370/XP
   platforms from arch/arm/mach-mvebu/ into drivers/irqchip/ and use
   the proper irqchip infrastructure. Those changes are not strictly
   needed to add MSI interrupts support, but since we will be touching
   the IRQ controller driver anyway, it sounded like the right time to
   do this move.

 * Patches 4 and 5 do some minor cleanups that will help for the
   remainer of the changes.

 * Patch 6 makes the MPIC node a subnode of the interrupt controller
   node, since the MSI interrupt controller will be added as a second
   subnode. The details on why this is needed are given in the commit
   log. It is important to read those details to understand why such a
   Device Tree representation was used.

 * Patch 7 modifies the IRQ controller driver to support MSI.

 * Patch 8 is a patch from Thierry Reding that introduces a small
   infrastructure based on 'struct msi_chip' which makes the MSI
   support usable on multiplatform kernel.

 * Patch 9 adds the MSI support to the Marvell EBU PCIe driver.

 * Patch 10 and 11 respectively update the Device Tree and the
   defconfig of Armada 370/XP platforms to enable MSI.

It is for now sent as a RFC in order to define whether the Device Tree
representation is correct or not. Again, patch 6 gives the rationale
for this choice.

This patch set is meant to be applied on top of the Marvell PCIe
driver. I keep it distinct from the PCIe driver patch set because the
PCIe driver itself is mostly reading for merging (it has gone through
multiple iterations over the last 3 months), while this patch set is
brand new and will most likely need a bunch of iterations as well.

Thanks,

Thomas

Thierry Reding (1):
  PCI: Introduce new MSI chip infrastructure

Thomas Petazzoni (10):
  arm: mvebu: move L2 cache initialization in init_early()
  irqchip: move IRQ driver for Armada 370/XP
  irqchip: armada-370-xp: move IRQ handler to avoid forward declaration
  irqchip: armada-370-xp: slightly cleanup irq controller driver
  arm: mvebu: do not duplicate the mpic alias
  irqchip: armada-370-xp: use a separate mpic node
  irqchip: armada-370-xp: add MSI support to interrupt controller
    driver
  pci: mvebu: add MSI support
  arm: mvebu: enable MSI support in DT
  arm: mvebu: enable PCI MSI support in defconfig

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   39 +++-
 .../devicetree/bindings/pci/mvebu-pci.txt          |    5 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |   15 +-
 arch/arm/boot/dts/armada-370.dtsi                  |    3 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |    1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |    1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |    1 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    2 +-
 arch/arm/configs/mvebu_defconfig                   |    1 +
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    9 +-
 drivers/irqchip/Makefile                           |    1 +
 .../irqchip}/irq-armada-370-xp.c                   |  202 ++++++++++++++------
 drivers/pci/host/pci-mvebu.c                       |  128 +++++++++++++
 drivers/pci/msi.c                                  |   35 +++-
 drivers/pci/probe.c                                |    1 +
 include/linux/msi.h                                |   10 +
 include/linux/pci.h                                |    1 +
 19 files changed, 384 insertions(+), 74 deletions(-)
 rename {arch/arm/mach-mvebu => drivers/irqchip}/irq-armada-370-xp.c (68%)

-- 
1.7.9.5

