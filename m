Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57636 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbcBASH5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2016 13:07:57 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vineet.Gupta1@synopsys.com, helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v7 0/2] adding PCI support to AXS10x
Date: Mon,  1 Feb 2016 18:07:43 +0000
Message-Id: <cover.1454349430.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
AXS10x. It includes the necessary tweaks to the ARC architecture, 
necessary tweaks to the PCI subsystem and a new driver (pcie-synopsys).
This new driver will be used extensively in the PCIe RC Prototyping Kit.

The patches were produced against Bjorn Helgaas' repository. It was properly
tested in an IP Prototyping Kit.

Joao Pinto (2):
  PCI support added to ARC
  add new platform driver for PCI RC

 .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 +++
 MAINTAINERS                                        |   7 +
 arch/arc/Kconfig                                   |  23 ++
 arch/arc/include/asm/dma.h                         |   5 +
 arch/arc/include/asm/io.h                          |   9 +
 arch/arc/include/asm/pci.h                         |  31 +++
 arch/arc/kernel/Makefile                           |   1 +
 arch/arc/kernel/pcibios.c                          |  23 ++
 arch/arc/plat-axs10x/Kconfig                       |   1 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-synopsys.c                   | 257 +++++++++++++++++++++
 13 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-synopsys.txt
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c
 create mode 100644 drivers/pci/host/pcie-synopsys.c

-- 
1.8.1.5

