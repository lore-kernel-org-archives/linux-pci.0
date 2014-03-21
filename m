Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:59367 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760120AbaCUKc7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 06:32:59 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>
Message-ID: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 21 Mar 2014 10:32:39 +0000
Subject: [PATCH v4 0/9] R-Car Gen2 PCIe host driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is version 4 of a PCIe Host driver for the R-Car Gen2 devices,
i.e. R-Car H2 (r8a7790) and R-Car M2 (r8a7791). This version includes
DT support, and includes a patch to add MSI.

v4:
 - Patch 0001 changed to correct use of runtime PM

Thanks
Phil

Phil Edworthy (9):
  PCI: host: rcar: Add Renesas R-Car PCIe driver
  PCI: host: rcar: Add MSI support
  ARM: shmobile: r8a7790: Add PCIe clock device tree nodes
  ARM: shmobile: r8a7791: Add PCIe clock device tree nodes
  dt-bindings: pci: rcar pcie device tree bindings
  ARM: shmobile: Add PCIe device tree nodes for R8A7790
  ARM: shmobile: Add PCIe device tree nodes for R8A7791 Koelsch board
  ARM: koelsch: Add PCIe to defconfig
  ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig

 Documentation/devicetree/bindings/pci/rcar-pci.txt |  40 +
 arch/arm/boot/dts/r8a7790.dtsi                     |  26 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   4 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  26 +-
 arch/arm/configs/koelsch_defconfig                 |   4 +
 drivers/pci/host/Kconfig                           |   6 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-rcar.c                       | 831 +++++++++++++++++++++
 drivers/pci/host/pcie-rcar.h                       |  87 +++
 include/dt-bindings/clock/r8a7790-clock.h          |   1 +
 include/dt-bindings/clock/r8a7791-clock.h          |   1 +
 11 files changed, 1022 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
 create mode 100644 drivers/pci/host/pcie-rcar.c
 create mode 100644 drivers/pci/host/pcie-rcar.h

-- 
1.9.0

