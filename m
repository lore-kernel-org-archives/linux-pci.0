Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35705 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751575AbcF3Jcy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 05:32:54 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>, Victor Gu <xigu@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 0/3] pci: Aardvark PCIe controller driver for Marvell Armada 3700
Date: Thu, 30 Jun 2016 11:32:29 +0200
Message-Id: <1467279152-5717-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This is the third iteration of the patch series that adds a PCIe
controller driver for the Aardvark PCI controller, which is used on
Marvell Armada 3700.

Changes since v2:

 - Fix typo in the DT binding documentation (handled ->
   handle). Noticed by Bjorn Helgaas.

 - Make all macro definitions use lower-case letters for hexadecimal
   numbers. Suggested by Bjorn Helgaas.

 - Remove numerous unused macro definitions. Suggested by Bjorn
   Helgaas.

 - Remove useless parenthesis in macro definitions. Suggested by Bjorn
   Helgaas.

 - Read the root bus number from the Device Tree (through the
   IORESOURCE_BUS resource) instead of hardcoding bus 0. Suggested by
   Bjorn Helgaas.

 - Rework the "link up" functions in two separate functions:
   advk_pcie_link_up() and advk_pcie_wait_for_link(), and use
   usleep_range() with a number of retries. Suggested by Bjorn
   Helgaas.

 - Fix some comments for consistency.

 - Switch from the AXI disabling logic to a different strategy for
   accessing the configuration space. This avoids the need for
   synchronization, and therefore solves some stability problems.

 - Minor improvements to the advk_pcie_wait_pio() function.

 - Make the 'if (where % size)' test earlier in the
   advk_pcie_wr_conf() function. Suggested by Bjorn Helgaas.

 - Use dev_err() instead of pr_err(). Suggested by Bjorn Helgaas.

 - Split the irq domain initialization (for legacy interrupts and MSI
   interrupts into two functions). While at it, also fix a device_node
   reference count leak when initializing the legacy irq
   domain. Requested by Bjorn Helgaas.

 - Remove the advk_pcie_release_of_pci_ranges() function, and call
   pci_free_resource_list() directly. Suggested by Bjorn Helgaas.

 - Remove MODULE_DEVICE_TABLE(), as the driver is not compiled as a
   module. Suggested by Bjorn Helgaas.

 - Change the "select PCI_MSI" to "depends on
   PCI_MSI_IRQ_DOMAIN". Suggested by Bjorn Helgaas.

Changes since v1:

 - Even if the MSI handling is currently done directly by the PCIe
   controller, use a msi-parent property to indicate this
   relationship. This way, if in the future we want to use the MSI
   capabilities from the GIC interrupt controller rather than the MSI
   functionality of the PCI controller, it will be possible.

   Suggested by Arnd Bergmann.

 - Replace the number-of-retry based loops by timeout based loops,
   using time_before().

   Suggested by Arnd Bergmann.

 - Simplify the IRQ handling, which actually also fixes a number of
   issues with the interrupt handling.

   Suggested by Marcin Wojtas.

Thanks,

Thomas

Thomas Petazzoni (3):
  dt-bindings: add DT binding for the Aardvark PCIe controller
  PCI: host: new PCI host controller driver for Aardvark
  arm64: dts: marvell: Aardvark PCIe support for Armada 3700

 .../devicetree/bindings/pci/aardvark-pci.txt       |   56 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |    5 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   25 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-aardvark.c                    | 1014 ++++++++++++++++++++
 7 files changed, 1117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
 create mode 100644 drivers/pci/host/pci-aardvark.c

-- 
2.7.4

