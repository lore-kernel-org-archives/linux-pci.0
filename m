Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46366 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031006Ab3HIU1X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 16:27:23 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv9 00/10] MSI support for Marvell EBU PCIe driver
Date: Fri,  9 Aug 2013 22:27:05 +0200
Message-Id: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This set of patches introduces Message Signaled Interrupt support in
the Marvell EBU PCIe driver. It has been successfully tested on the
Armada XP GP platform with an Intel e1000e PCIe network card that
supports MSI.

Compared to v8, this is a minor update with some build fixes and more
Acked-by.

This patch set is intended for merging in 3.12, so the respective
maintainers of the different areas are invited to review/ack the
patches, see below for the details.

The patches do the following:

 * Patch 1 reworks how the architecture-specific MSI functions can be
   overriden by architecture-specific code, by using weak
   functions. It was suggested by Bjorn Helgaas.

   This patch has been acked by Bjorn Helgaas, the PCI maintainter.

 * Patch 2 removes the ARCH_SUPPORTS_MSI hidden kconfig boolean which
   is no longer needed now that we have weak functions for all MSI
   architecture-specific hooks.

   This patch has been acked by Bjorn Helgaas, the PCI maintainer.

 * Patch 3 adds a minimal msi_chip infrastructure, that allows a
   pci_bus to be connected to a msi_chip, and that provides default
   implementations of the architecture-specific MSI functions to use
   msi_chip.

   This patch has been acked by Bjorn Helgaas, the PCI maintainter.

 * Patch 4 adds a simple registry of msi_chip <-> of_node in
   drivers/of.

   This patch has been Acked by Rob Herring.

 * Patch 5 makes some not very interesting preparation in the Armada
   370/XP IRQ controller driver.

   This patch needs the Ack from Thomas Gleixner, as the
   drivers/irqchip maintainer.

   It has been Acked-by Gregory Clement, as a mvebu maintainer.

 * Patch 6 implements the MSI support in the Armada 370/XP IRQ
   controller driver. It registers an msi_chip using the
   msi_chip_add() function added in PATCH 3.

   This patch needs the Ack from Thomas Gleixner, as the
   drivers/irqchip maintainer.

   It has been Acked-by Gregory Clement, as a mvebu maintainer.

 * Patch 7 extends the ARM PCI core to expose ->add_bus() and
   ->remove_bus() hooks to PCI drivers. This was suggested by Bjorn
   Helgaas to allow the PCI driver to connected the PCI busses with
   the corresponding MSI chip.

   This patch has been Acked by Russell King, the ARM maintainer.

 * Patch 8 adjust the Armada 370/XP Device Tree to indicate that the
   MPIC is not only an interrupt-controller, but also an
   msi-controller.

   It has been Acked-by Gregory Clement, as a mvebu maintainer.

 * Patch 9 adds MSI support in the Marvell PCIe host controller
   driver. The work to do here is minimal: get a reference to the
   msi-parent controller thanks to msi_chip_find_by_of_node(), and
   link it to the pci_bus structure before the bus gets enumerated.

   This patch has been acked by Bjorn Helgaas, the PCI maintainer.

 * Patch 10 adjusts the Armada 370/XP Device Tree to add the msi-parent
   properties in the PCIe controller nodes.

   It has been Acked-by Gregory Clement, as a mvebu maintainer.

This version 9 follows:
 * PATCH version 8 sent on August, 9th 2013
 * PATCH version 7 sent on August, 7th 2013
 * PATCH version 6 sent on August, 1st 2013
 * PATCH version 5 sent on July, 15th 2013
 * PATCH version 4 sent on July, 1st 2013
 * PATCH version 3 sent on June, 19th 2013
 * PATCH version 2 sent on June, 6th 2013
 * RFC version 1 sent on March, 26th 2013

Changes since v8:

 * Fix !CONFIG_PCI_MSI build on x86 (by removing some unneeded defines
   in arch/x86/include/asm/pci.h, and adding some compile-time
   conditions in arch/x86/kernel/x86_init.c).

 * Fix !CONFIG_PCI_MSI && !CONFIG_OF build by adding a missing ';' in
   include/linux/of_pci.h.

 * Added Acked-by from Benjamin Herrenschmidt on patches:
    PCI: use weak functions for MSI arch-specific functions
    PCI: remove ARCH_SUPPORTS_MSI kconfig option
    of: pci: add registry of MSI chips

 * Re-added Acked-by from Rob Herring on patch:
    of: pci: add registry of MSI chips
   it had been lost in the process, but Rob did give his ack on this
   patch on July, 9th.

 * Added Acked-by from Gregory Clement on patches:
    irqchip: armada-370-xp: properly request resources
    irqchip: armada-370-xp: implement MSI support
    ARM: mvebu: the MPIC now provides MSI controller features
    ARM: mvebu: link PCIe controllers to the MSI controller

Changes since v7:

 * Instead of using an irq_domain based allocation of MSI interrupts,
   revert back to a bitmap-based solution directly implemented inside
   the IRQ controller driver. This is identical to what was done in
   Version 2 of this patch set.

 * Instead of tightly coupling msi_chip and irq_domain, revert back to
   the simple msi_chip <-> of_node registry in drivers/of, which was
   part of Version 3, Version 4 and Version 5 of this patch set.

 * Remove Tested-by from Daniel Price on the two modified patches.

 * Fix the indentation problem noticed by Thierry Reding on the 'ARM:
   pci: add ->add_bus() and ->remove_bus() hooks to hw_pci' patch.

Changes since v6:

 * Fixed x86 build failure related to default_restore_msi_irqs(),
   noticed by Stephen Rothwell on linux-next.

 * Added Acked-by from Bjorn Helgaas on 'PCI: remove ARCH_SUPPORTS_MSI
   kconfig option'.

 * Fixed a compile-time issue in drivers/irqchip/irq-armada-370-xp.c
   in the !CONFIG_PCI_MSI case.

 * Fixed one of the stylistic issue raised by Thierry Reding on 'ARM:
   pci: add ->add_bus() and ->remove_bus() hooks to hw_pci' (i.e do
   not align '=' when assigning elements of the pci_sys_data
   structure). I however didn't fix the tab vs. spaces indentation
   issue noticed by Thierry, since I couldn't see it (to me the
   indentation was identical in both locations).

 * Added Tested-by from Daniel Price on all patches.

Changes since v5:

 * Rebased on top of 3.11-rc3.

 * Implemented the suggestions of Grant Likely on "irqdomain: add
   irq_alloc_mapping() function" and added his Acked-by.

 * Added Bjorn Helgaas Acked-by on "PCI: use weak functions for MSI
   arch-specific functions".

 * Added Bjorn Helgaas Acked-by on "PCI: Introduce new MSI chip
   infrastructure".

 * Remove the drivers/of global registry of irq_chip, and as suggested
   by Grant Likely, create an association between an irq_domain and a
   msi_chip. This required refactoring the __irq_domain_add()
   function, adding a 'msi_chip' pointer to 'irq_domain', adding an
   irq_domain_add_msi() function and a irq_find_msi_host() function.

 * Added Russell King Acked-by on "ARM: pci: add ->add_bus() and
 ->remove_bus() hooks to hw_pci"

Changes since v4:

 * Rebased on top of 3.11-rc1.

 * Slightly rework the implementation of arch_setup_msi_irq(),
   arch_teardown_msi_irq and arch_msi_check_device() according to the
   suggestions of Bjorn Helgaas (PATCH 4)

 * Make a few improvements to the msi_chip registry, according to the
   suggestion of Bjorn Helgaas and Rob Herring: coding style fixes,
   usage of mutex while traversing the list of msi_chip, usage of
   of_pci_msi_* prefix instead of just of_msi_*.

Changes since v3:

 * Keep only a default_teardown_msi_irqs() function needed for the Xen
   PCI x86 code, and remove all other default_*() function and put the
   default behavior directly in the weak functions. Suggested by
   Thierry Redding and Bjorn Helgaas.

 * Misc small improvements the MSI chip registry code: compiled only
   under CONFIG_PCI_MSI, functions exported to modules, addition of an
   of_msi_chip_remove() function, renaming of
   of_msi_chip_find_by_node() to of_find_msi_chip_by_node(), move the
   test of the "msi-controller" property to the of_msi_chip_add()
   function, renamed the list_head field from link to list, added
   dummy functions in the header files when !CONFIG_PCI_MSI &&
   !CONFIG_OF. All suggested by Thierry Redding.

 * Add a patch that entirely removes the ARCH_SUPPORTS_MSI, as we now
   have weak functions, so even if an arch doesn't actually
   use/support MSI, the code will build properly. Suggested by Thierry
   Redding.

 * Added Device Tree binding documentation updates for the IRQ
   controller and the PCIe controller.

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

This set of patches applies on top of 3.11-rc3, and is available as a
Git branch at
https://github.com/MISL-EBU-System-SW/mainline-public/tree/marvell-pcie-msi-v9.

Thanks,

Thomas

Thierry Reding (1):
  PCI: Introduce new MSI chip infrastructure

Thomas Petazzoni (9):
  PCI: use weak functions for MSI arch-specific functions
  PCI: remove ARCH_SUPPORTS_MSI kconfig option
  of: pci: add registry of MSI chips
  irqchip: armada-370-xp: properly request resources
  irqchip: armada-370-xp: implement MSI support
  ARM: pci: add ->add_bus() and ->remove_bus() hooks to hw_pci
  ARM: mvebu: the MPIC now provides MSI controller features
  PCI: mvebu: add support for MSI
  ARM: mvebu: link PCIe controllers to the MSI controller

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   3 +
 .../devicetree/bindings/pci/mvebu-pci.txt          |   3 +
 arch/arm/Kconfig                                   |   1 -
 arch/arm/boot/dts/armada-370-xp.dtsi               |   1 +
 arch/arm/boot/dts/armada-370.dtsi                  |   1 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   1 +
 arch/arm/include/asm/mach/pci.h                    |   4 +
 arch/arm/kernel/bios32.c                           |  16 ++
 arch/ia64/Kconfig                                  |   1 -
 arch/mips/Kconfig                                  |   2 -
 arch/mips/include/asm/pci.h                        |   5 -
 arch/powerpc/Kconfig                               |   1 -
 arch/powerpc/include/asm/pci.h                     |   5 -
 arch/s390/Kconfig                                  |   1 -
 arch/s390/include/asm/pci.h                        |   4 -
 arch/sparc/Kconfig                                 |   1 -
 arch/tile/Kconfig                                  |   1 -
 arch/x86/Kconfig                                   |   1 -
 arch/x86/include/asm/pci.h                         |  30 ---
 arch/x86/kernel/x86_init.c                         |  24 +++
 drivers/irqchip/irq-armada-370-xp.c                | 202 ++++++++++++++++++++-
 drivers/of/of_pci.c                                |  45 +++++
 drivers/pci/Kconfig                                |   4 -
 drivers/pci/host/pci-mvebu.c                       |  26 +++
 drivers/pci/msi.c                                  |  69 ++++---
 drivers/pci/probe.c                                |   1 +
 include/linux/msi.h                                |  21 ++-
 include/linux/of_pci.h                             |  12 ++
 include/linux/pci.h                                |   1 +
 31 files changed, 403 insertions(+), 86 deletions(-)

-- 
1.8.1.2

