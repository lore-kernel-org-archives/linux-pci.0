Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:57434 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcBHRpT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 12:45:19 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vineet.Gupta1@synopsys.com, helgaas@kernel.org, arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v9 0/2] adding PCI support to AXS10x
Date: Mon,  8 Feb 2016 17:45:09 +0000
Message-Id: <cover.1454952698.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
AXS10x. It includes the necessary tweaks to:
 - the ARC architecture (PCI support)
 - the PCI subsystem (ARC CPU support)
 - to pcie-designware (Centralisation of wait for link routine)
 - to dra7xx, exynos, imx6 and spear13xx drivers to use the centralised
 code for link wait

A simple module was (pcie-designware-plat) was created to contain the 
specific platform init code.

The patches were produced against Bjorn Helgaas' repository. It was properly
tested in an IP Prototyping Kit.

Joao Pinto (2):
  PCI support added to ARC
  pcie-designware platform driver

 .../devicetree/bindings/pci/designware-pcie.txt    |  17 +++
 arch/arc/Kconfig                                   |  23 ++++
 arch/arc/include/asm/dma.h                         |   5 +
 arch/arc/include/asm/io.h                          |   9 ++
 arch/arc/include/asm/pci.h                         |  31 +++++
 arch/arc/kernel/Makefile                           |   1 +
 arch/arc/kernel/pcibios.c                          |  23 ++++
 arch/arc/plat-axs10x/Kconfig                       |   1 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/host/Kconfig                           |  11 ++
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-dra7xx.c                      |  11 +-
 drivers/pci/host/pci-exynos.c                      |  11 +-
 drivers/pci/host/pci-imx6.c                        |  11 +-
 drivers/pci/host/pcie-designware-plat.c            | 143 +++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 |  31 ++++-
 drivers/pci/host/pcie-designware.h                 |   6 +
 drivers/pci/host/pcie-spear13xx.c                  |  12 +-
 18 files changed, 311 insertions(+), 37 deletions(-)
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c
 create mode 100644 drivers/pci/host/pcie-designware-plat.c

-- 
1.8.1.5

