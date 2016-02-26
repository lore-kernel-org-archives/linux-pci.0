Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53649 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbcBZQ3x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 11:29:53 -0500
Subject: [PATCH v11 0/4] ARC: Add PCI support
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: mark.rutland@arm.com, Alexey.Brodkin@synopsys.com, arnd@arndb.de,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-pci@vger.kernel.org, Vineet.Gupta1@synopsys.com,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com,
	robh+dt@kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
	galak@codeaurora.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-snps-arc@lists.infradead.org
Date: Fri, 26 Feb 2016 10:29:49 -0600
Message-ID: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From Joao's v9 posting
(http://lkml.kernel.org/r/cover.1454952698.git.jpinto@synopsys.com):

  "This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
  AXS10x. It includes the necessary tweaks to:

   - the ARC architecture (PCI support)
   - the PCI subsystem (ARC CPU support)
   - to pcie-designware (Centralisation of wait for link routine)
   - to dra7xx, exynos, imx6 and spear13xx drivers to use the centralised
     code for link wait

  A simple module was (pcie-designware-plat) was created to contain the
  specific platform init code."

Changes from v10:
  - Update keystone link establishment to wait longer for link to come up
    before re-initiating link training
  - Also use generic dw_pcie_wait_for_link() in keystone and qcom drivers

I would still like acks from DesignWare maintainers (Jingoo or
Pratyush), from Murali for the Keystone changes, and from Arnd for the
DT updates.

This series is in my pci/host-synopsys branch here:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-syn
opsys
---

Joao Pinto (4):
      ARC: Add PCI support
      PCI: designware: Add generic dw_pcie_wait_for_link()
      PCI: designware: Add default link up check if sub-driver doesn't override
      PCI: designware: Add driver for prototyping kits based on ARC SDP


 .../devicetree/bindings/pci/designware-pcie.txt    |   17 ++
 MAINTAINERS                                        |    7 +
 arch/arc/Kconfig                                   |   26 ++++
 arch/arc/include/asm/dma.h                         |    5 +
 arch/arc/include/asm/io.h                          |    9 +
 arch/arc/include/asm/pci.h                         |   31 ++++
 arch/arc/kernel/Makefile                           |    1 
 arch/arc/kernel/pcibios.c                          |   22 +++
 arch/arc/plat-axs10x/Kconfig                       |    1 
 drivers/pci/Makefile                               |    1 
 drivers/pci/host/Kconfig                           |   11 ++
 drivers/pci/host/Makefile                          |    1 
 drivers/pci/host/pci-dra7xx.c                      |   11 --
 drivers/pci/host/pci-exynos.c                      |   13 --
 drivers/pci/host/pci-imx6.c                        |   13 +-
 drivers/pci/host/pci-keystone.c                    |   10 +
 drivers/pci/host/pcie-designware-plat.c            |  138 ++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 |   29 ++++
 drivers/pci/host/pcie-designware.h                 |    6 +
 drivers/pci/host/pcie-qcom.c                       |   10 -
 drivers/pci/host/pcie-spear13xx.c                  |   14 --
 21 files changed, 318 insertions(+), 58 deletions(-)
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c
 create mode 100644 drivers/pci/host/pcie-designware-plat.c
