Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:44262 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab3FFQla (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 12:41:30 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
Date: Thu,  6 Jun 2013 18:41:20 +0200
Message-Id: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This set of patches introduces Message Signaled Interrupt support in
the Marvell EBU PCIe driver. It has been successfully tested on the
Armada XP GP platform with an Intel e1000e PCIe network card that
supports MSI.

This version 2 follows the RFC version sent on March, 26th 2013. This
is based on work done by Lior Amsalem <alior@marvell.com>.

The patches do the following:

 * Patch 1 comes from Thierry Redding, and adds a minimal msi_chip
   infrastructure.

   This needs to be reviewed/acked by Bjorn Helgaas.

 * Patch 2 extends the msi_chip infrastructure with a small registry,
   so that one driver can register an msi_chip, and another driver can
   find the msi_chip associated to a particular Device Tree node.

   This needs to be reviewed/acked by Bjorn Helgaas.

 * Patch 3 makes some not very interesting preparation in the Armada
   370/XP IRQ controller driver.

 * Patch 4 implements the MSI support in the Armada 370/XP IRQ
   controller driver. It registers an msi_chip using the
   msi_chip_add() function added in PATCH 2.

 * Patch 5 adjust the Armada 370/XP Device Tree to indicate that the
   MPIC is not only an interrupt-controller, but also an
   msi-controller.

 * Patch 6 adds MSI support in the Marvell PCIe host controller
   driver. The work to do here is minimal: get a reference to the
   msi-parent controller thanks to msi_chip_find_by_of_node(), and
   link it to the pci_bus structure before the bus gets enumerated.

   This needs to be reviewed/acked by Bjorn Helgaas.

 * Patch 7 tunes Kconfig to indicate that Armada 370/XP supports MSI.

 * Patch 8 adjusts the Armada 370/XP Device Tree to add the msi-parent
   properties in the PCIe controller nodes.

This set of patches currently applies on top of the current "for-next"
branch of Jason Cooper's repository.

The Device Tree binding documentation updates will be added once the
general approach is agreed on.

Thanks,

Thomas

Thierry Reding (1):
  PCI: Introduce new MSI chip infrastructure

Thomas Petazzoni (7):
  PCI: Add registry of MSI chips
  irqchip: armada-370-xp: properly request resources
  irqchip: armada-370-xp: implement MSI support
  arm: mvebu: the MPIC now provides MSI controller features
  pci: mvebu: add support for MSI
  arm: mvebu: indicate that this platform supports MSI
  arm: mvebu: link PCIe controllers to the MSI controller

 arch/arm/boot/dts/armada-370-xp.dtsi     |   1 +
 arch/arm/boot/dts/armada-370.dtsi        |   1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   1 +
 arch/arm/mach-mvebu/Kconfig              |   1 +
 drivers/irqchip/irq-armada-370-xp.c      | 186 ++++++++++++++++++++++++++++++-
 drivers/pci/host/pci-mvebu.c             |  21 ++++
 drivers/pci/msi.c                        |  59 +++++++++-
 drivers/pci/probe.c                      |   1 +
 include/linux/msi.h                      |  22 ++++
 include/linux/pci.h                      |   1 +
 12 files changed, 288 insertions(+), 8 deletions(-)

-- 
1.8.1.2

