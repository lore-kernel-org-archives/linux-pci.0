Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35450 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933181AbcFJPym (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 11:54:42 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 0/3] Aardvark PCIe controller driver for Marvell Armada 3700
Date: Fri, 10 Jun 2016 17:54:13 +0200
Message-Id: <1465574056-8787-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This is the second iteration of the patch series that adds a PCIe
controller driver for the Aardvark PCI controller, which is used on
Marvell Armada 3700.

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
 drivers/pci/host/pci-aardvark.c                    | 1023 ++++++++++++++++++++
 7 files changed, 1126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/aardvark-pci.txt
 create mode 100644 drivers/pci/host/pci-aardvark.c

-- 
2.7.4

