Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:17536
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752544AbbHGHnO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Aug 2015 03:43:14 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/5] Altera PCIe host controller driver with MSI support
Date: Fri, 7 Aug 2015 15:42:57 +0800
Message-ID: <1438933382-2936-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the 3rd version of patch set to add support for Altera PCIe host
controller with MSI feature on Altera FPGA device families. This patchset
mainly resolve comments from Marc Zyngier in v2.

It is based on patch series from Marc Zyngier "Per-device MSI domain &
platform MSI" [1] to get rid of struct msi_controller.

[1]: https://lkml.org/lkml/2015/7/23/172

v2->v3 changes:
- pci: host: move depends on PCI_MSI_IRQ_DOMAIN to PCIE_ALTERA_MSI in Kconfig
- pcie-altera: change to use find_first_bit in isr
- pcie-altera: change to use chained irq handler
- pcie-altera: rename hwirq to irq
- pcie-altera: rename irq to virq
- pcie-altera-msi: update isr handling
- pcie-altera-msi: change u64 to phys_addr_t
- pcie-altera-msi: fix find_first_zero_bit error handle
- pcie-altera-msi: change altera_msi_probe to static function
- pcie-altera-msi: remove .owner
- pcie-altera-msi: remove MODULE_DEVICE_TABLE
- pcie-altera-msi: move INTMASK to _alloc()
- change from clear_bit to __clear_bit
- change to use irq_set_chained_handler_and_data
- fix coding style

History:
-------
[v1]: https://lkml.org/lkml/2015/7/28/395
[v2]: https://lkml.org/lkml/2015/7/31/267


Ley Foon Tan (5):
  arm: add msi.h to Kbuild
  pci:host: Add Altera PCIe host controller driver
  pci: altera: Add Altera PCIe MSI driver
  Documentation: dt-bindings: pci: altera pcie device tree binding
  MAINTAINERS: Add Altera PCIe and MSI drivers maintainer

 .../devicetree/bindings/pci/altera-pcie-msi.txt    |  27 ++
 .../devicetree/bindings/pci/altera-pcie.txt        |  49 ++
 MAINTAINERS                                        |  16 +
 arch/arm/include/asm/Kbuild                        |   1 +
 drivers/pci/host/Kconfig                           |  15 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pcie-altera-msi.c                 | 309 ++++++++++++
 drivers/pci/host/pcie-altera.c                     | 532 +++++++++++++++++++++
 8 files changed, 951 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 drivers/pci/host/pcie-altera-msi.c
 create mode 100644 drivers/pci/host/pcie-altera.c

-- 
1.8.2.1

