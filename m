Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0097.outbound.protection.outlook.com ([207.46.100.97]:53072
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753978AbbIAKaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Sep 2015 06:30:21 -0400
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
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>
Subject: [PATCH v6 0/6] Altera PCIe host controller driver with MSI support
Date: Tue, 1 Sep 2015 18:30:02 +0800
Message-ID: <1441103408-8433-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the 6th version of patch set to add support for Altera PCIe host
controller with MSI feature on Altera FPGA device families. This patchset
mainly resolve comments from Marc Zyngier in v5 and minor fixes.

It is based on patch series from Marc Zyngier "Per-device MSI domain &
platform MSI" [1] to get rid of struct msi_controller.

v5->v6 changes:
- altera-msi: remove irq_enable and irq_disable
- pcie-altera: change to PCI_VENDOR_ID_ALTERA for fixup
- pcie-altera: change to use switch case method
- update interrupt handling
- include: pci: add Altera PCI vendor ID

[1]: https://lkml.org/lkml/2015/7/23/172

History:
-------
[v1]: https://lkml.org/lkml/2015/7/28/395
[v2]: https://lkml.org/lkml/2015/7/31/267
[v3]: http://www.kernelhub.org/?msg=811940&p=2
[v4]: https://lkml.org/lkml/2015/8/17/141
[v5]: https://lkml.org/lkml/2015/8/25/238

Ley Foon Tan (6):
  arm: add msi.h to Kbuild
  pci: add Altera PCI vendor ID
  pci:host: Add Altera PCIe host controller driver
  pci: altera: Add Altera PCIe MSI driver
  Documentation: dt-bindings: pci: altera pcie device tree binding
  MAINTAINERS: Add Altera PCIe and MSI drivers maintainer

 .../devicetree/bindings/pci/altera-pcie-msi.txt    |  28 +
 .../devicetree/bindings/pci/altera-pcie.txt        |  49 ++
 MAINTAINERS                                        |  16 +
 arch/arm/include/asm/Kbuild                        |   1 +
 drivers/pci/host/Kconfig                           |  16 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pcie-altera-msi.c                 | 311 +++++++++++
 drivers/pci/host/pcie-altera.c                     | 593 +++++++++++++++++++++
 include/linux/pci_ids.h                            |   2 +
 9 files changed, 1018 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
 create mode 100644 drivers/pci/host/pcie-altera-msi.c
 create mode 100644 drivers/pci/host/pcie-altera.c

-- 
1.8.2.1

