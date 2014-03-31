Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:14433 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753821AbaCaKbF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Mar 2014 06:31:05 -0400
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
Message-ID: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
Date: Mon, 31 Mar 2014 11:30:45 +0100
Subject: [PATCH v7 00/10] R-Car Gen2 PCIe host driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is version 7 of a PCIe Host driver for the R-Car Gen2 devices,
i.e. R-Car H2 (r8a7790) and R-Car M2 (r8a7791).

v7:
 - Change binding description of clocks to 'clock specifiers'

v6:
 - Correct DT bindings description for reg and clocks
 - Split device and board DT changes
 - Add shmobile to subject for shmobile DT patches
 - Don't check MSI irq number is valid, as upper level checks this
 - Change "Unexpected MSI" msg to debug level
 - Reword "Unexpected MSI" comment so that it's one line
 - Remove patch that adds HAVE_ARM_ARCH_TIMER to koelsch defconfig as not needed

v5:
 - Use module_platform_driver instead of subsys_initcall
 - Use the of_device_id data field for HW init function
 - Init hw_pci struct in declaration
 - Renesas SoC compatible string has peripheral before device name
 - Add PCIe bus clock reference
 - Use dma-ranges property to specify inbound memory regions
 - Support multiple IO windows and correct resources
 - Return IRQ_NONE from MSI isr when there is no pending MSI
 - Add additional interrupt bindings

v4:
 - Use runtime PM properly

Phil Edworthy (10):
  PCI: host: rcar: Add Renesas R-Car PCIe driver
  PCI: host: rcar: Add MSI support
  ARM: shmobile: r8a7790: Add PCIe clock device tree nodes
  ARM: shmobile: r8a7791: Add PCIe clock device tree nodes
  dt-bindings: pci: rcar pcie device tree bindings
  ARM: shmobile: r8a7790: Add PCIe device nodes
  ARM: shmobile: lager: Add PCIe device nodes
  ARM: shmobile: r8a7791: Add PCIe device nodes
  ARM: shmobile: koelsch: Add PCIe device nodes
  ARM: shmobile: koelsch: Add PCIe to defconfig

 Documentation/devicetree/bindings/pci/rcar-pci.txt |  45 +
 arch/arm/boot/dts/r8a7790-lager.dts                |  10 +
 arch/arm/boot/dts/r8a7790.dtsi                     |  31 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  14 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  31 +-
 arch/arm/configs/koelsch_defconfig                 |   3 +
 drivers/pci/host/Kconfig                           |   6 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-rcar.c                       | 929 +++++++++++++++++++++
 drivers/pci/host/pcie-rcar.h                       |  87 ++
 include/dt-bindings/clock/r8a7790-clock.h          |   1 +
 include/dt-bindings/clock/r8a7791-clock.h          |   1 +
 12 files changed, 1154 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
 create mode 100644 drivers/pci/host/pcie-rcar.c
 create mode 100644 drivers/pci/host/pcie-rcar.h

-- 
1.9.0

