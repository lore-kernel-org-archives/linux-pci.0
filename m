Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40540 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965AbbLPOPm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 09:15:42 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org, Vineet.Gupta1@synopsys.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 0/2] adding PCI support to AXS10x
Date: Wed, 16 Dec 2015 14:14:54 +0000
Message-Id: <cover.1450274797.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
AXS10x. It includes the necessary tweaks to the ARC architecture, necessary
tweaks to the PCI subsystem and a new driver (pcie-snpsdev).
This new driver will be used extensively in the PCIe RC Prototyping Kit.

The patches were produced against Bjorn Helgaas' repository. It was properly
tested in an IP Prototyping Kit.

Joao Pinto (2):
  PCI support added to ARC
  add new platform driver for PCI RC

 .../devicetree/bindings/pci/pcie-snpsdev.txt       |  28 ++
 MAINTAINERS                                        |   7 +
 arch/arc/Kconfig                                   |  23 ++
 arch/arc/include/asm/dma.h                         |   5 +
 arch/arc/include/asm/io.h                          |  10 +
 arch/arc/include/asm/mach/pci.h                    |  97 ++++++
 arch/arc/include/asm/pci.h                         |  34 ++
 arch/arc/kernel/Makefile                           |   1 +
 arch/arc/kernel/pcibios.c                          | 358 +++++++++++++++++++++
 arch/arc/mm/ioremap.c                              |  10 +-
 arch/arc/plat-axs10x/Kconfig                       |   1 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/host/Kconfig                           |   5 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 |  15 +
 drivers/pci/host/pcie-designware.h                 |   1 +
 drivers/pci/host/pcie-snpsdev.c                    | 288 +++++++++++++++++
 17 files changed, 884 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
 create mode 100644 arch/arc/include/asm/mach/pci.h
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c
 create mode 100644 drivers/pci/host/pcie-snpsdev.c

-- 
1.8.1.5

