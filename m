Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42307 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933869Ab3FSQ4Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 12:56:24 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCHv3 00/11] MSI support for Marvell EBU PCIe driver
Date: Wed, 19 Jun 2013 18:56:08 +0200
Message-Id: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This set of patches introduces Message Signaled Interrupt support in
the Marvell EBU PCIe driver. It has been successfully tested on the
Armada XP GP platform with an Intel e1000e PCIe network card that
supports MSI.

This version 3 follows:
 * PATCH version 2 sent on June, 6th 2013
 * RFC version 1 sent on March, 26th 2013

Changes since v2:

 * Add an IRQ domain function that allows to allocate dynamically a
   free hwirq number from an IRQ domain, and create a virq mapping to
   it. It was suggested by Grant Likely in order to remove the hwirq
   allocation code from the IRQ driver itself. (PATCH 1)

 * Separate the use of weak functions from the introduction of the
   msi_chip infrastructure, and use weak functions for all
   architecture-specific MSI hooks. Suggested by Bjorn Helgaas (PATCH
   2).

 * Move the msi_chip registry to drivers/of. Suggested by Bjorn
   Helgaas (PATCH 4).

 * Use pcibios_add_bus() and pcibios_remove_bus() to connect the PCI
   busses to their msi_chip, as suggested by Bjorn Helgaas. Requires
   some ARM PCI core changes (PATCH 7), and then changes to the PCI
   driver itself (PATCH 9).

It would be great if some of those patches were taken for 3.11. For
example, PATCH 1, PATCH 2, PATCH 5 and PATCH 7 are completely
independent from each other.

The patches do the following:

 * Patch 1 adds an IRQ domain function that allows to allocate
   dynamically a free hwirq number from an IRQ domain, and create a
   virq mapping to it. It was suggested by Grant Likely in order to
   remove the hwirq allocation code from the IRQ driver itself.

   This patch needs the Ack of Grant Likely.

 * Patch 2 reworks how the architecture-specific MSI functions can be
   overriden by architecture-specific code, by using weak
   functions. It was suggested by Bjorn Helgaas.

   This patch needs the Ack from Bjorn Helgaas.

 * Patch 3 adds a minimal msi_chip infrastructure, that allows a
   pci_bus to be connected to a msi_chip, and that provides default
   implementations of the architecture-specific MSI functions to use
   msi_chip.

   This patch needs the Ack from Bjorn Helgaas.

 * Patch 4 adds a small registry of msi_chip <-> of_node in the OF
   code. It was originally located in drivers/pci/msi.c, but Bjorn
   Helgaas suggested that it probably belongs to drivers/of/.

   This patch needs the Ack from Grant Likely or Rob Herring, and
   probably Bjorn Helgaas as well.

 * Patch 5 makes some not very interesting preparation in the Armada
   370/XP IRQ controller driver.

   This patch needs the Ack from Thomas Gleixner.

 * Patch 6 implements the MSI support in the Armada 370/XP IRQ
   controller driver. It registers an msi_chip using the
   msi_chip_add() function added in PATCH 3.

   This patch needs the Ack from Thomas Gleixner.

 * Patch 7 extends the ARM PCI core to expose ->add_bus() and
   ->remove_bus() hooks to PCI drivers. This was suggested by Bjorn
   Helgaas to allow the PCI driver to connected the PCI busses with
   the corresponding MSI chip.

   This patch needs the Ack from Russell King.

 * Patch 8 adjust the Armada 370/XP Device Tree to indicate that the
   MPIC is not only an interrupt-controller, but also an
   msi-controller.

   This patch needs the Ack from Jason Cooper, Gregory Clement
   and/or Andrew Lunn, the Marvell Maintainers.

 * Patch 9 adds MSI support in the Marvell PCIe host controller
   driver. The work to do here is minimal: get a reference to the
   msi-parent controller thanks to msi_chip_find_by_of_node(), and
   link it to the pci_bus structure before the bus gets enumerated.

   This patch needs the Ack from Bjorn Helgaas.

 * Patch 10 tunes Kconfig to indicate that Armada 370/XP supports MSI.

   This patch needs the Ack from Jason Cooper, Gregory Clement
   and/or Andrew Lunn, the Marvell Maintainers.

 * Patch 8 adjusts the Armada 370/XP Device Tree to add the msi-parent
   properties in the PCIe controller nodes.

   This patch needs the Ack from Jason Cooper, Gregory Clement
   and/or Andrew Lunn, the Marvell Maintainers.

This set of patches currently applies on top of the current "for-next"
branch of Jason Cooper's repository + the irqdomain/test branch of
Grant Likely's tree.

The Device Tree binding documentation updates will be added once the
general approach is agreed on.

Thanks,

Thomas

Thierry Reding (1):
  PCI: Introduce new MSI chip infrastructure

Thomas Petazzoni (10):
  irqdomain: add irq_alloc_mapping() function
  pci: use weak functions for MSI arch-specific functions
  of: pci: add registry of MSI chips
  irqchip: armada-370-xp: properly request resources
  irqchip: armada-370-xp: implement MSI support
  arm: pci: add ->add_bus() and ->remove_bus() hooks to hw_pci
  arm: mvebu: the MPIC now provides MSI controller features
  pci: mvebu: add support for MSI
  arm: mvebu: indicate that this platform supports MSI
  arm: mvebu: link PCIe controllers to the MSI controller

 arch/arm/boot/dts/armada-370-xp.dtsi     |   1 +
 arch/arm/boot/dts/armada-370.dtsi        |   1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   1 +
 arch/arm/include/asm/mach/pci.h          |   4 +
 arch/arm/kernel/bios32.c                 |  16 ++++
 arch/arm/mach-mvebu/Kconfig              |   1 +
 arch/mips/include/asm/pci.h              |   5 -
 arch/powerpc/include/asm/pci.h           |   5 -
 arch/s390/include/asm/pci.h              |   4 -
 arch/x86/include/asm/pci.h               |  28 ------
 arch/x86/kernel/x86_init.c               |  21 +++++
 drivers/irqchip/irq-armada-370-xp.c      | 155 ++++++++++++++++++++++++++++++-
 drivers/of/of_pci.c                      |  22 +++++
 drivers/pci/host/pci-mvebu.c             |  26 ++++++
 drivers/pci/msi.c                        |  80 +++++++++++-----
 drivers/pci/probe.c                      |   1 +
 include/linux/irqdomain.h                |   2 +
 include/linux/msi.h                      |  28 +++++-
 include/linux/of_pci.h                   |   4 +
 include/linux/pci.h                      |   1 +
 kernel/irq/irqdomain.c                   |  32 +++++++
 23 files changed, 371 insertions(+), 69 deletions(-)

-- 
1.8.1.2

