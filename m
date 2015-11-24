Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:44999 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbbKXXEj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 18:04:39 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v2 0/5] Add iProc PCIe PAXC and MSI support
Date: Tue, 24 Nov 2015 15:04:49 -0800
Message-ID: <1448406294-732-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support for the iProc PAXC interface and support for
event queue based MSI, integrated in the iProc PCIe core

This patch series is based on Linux v4.4-rc1 and is avaliable here:
https://github.com/Broadcom/cygnus-linux/tree/iproc-msi-v2

This patch series is tested on the following platforms:

PAXB:
- Broadcom Cygnus wireless audio board with Intel e1000e network card
- Broadcom NS2 SVK board with Intel e1000e network card

PAXC:
- Broadcom NS2 SVK board with integrated dual 10 Gig Ethernet ports

Changes from v1:
- Fixed incorrect 1-to-1 mapping between MSI vector and GIC interrupt. Now the
driver supports multiple MSI vectors per GIC interrupt
- Added MSI IRQ affinity support by distributing GIC interrupts across
available CPU cores and dynamically steer MSI vectors to the target CPU
- replace readl/writel with readl_relaxed/writel_relaxed since all register
accesses within the iProc MSI driver are to/from the same I/O block, i.e., the
iProc PCIe core
- Removed all redundant irq_chip callback assignments
- Changed to use uncached host memory for both MSI posted writes and event
queues
- Add functions to free resources in error/exit cases
- In pcie-iproc-platform.c, pass in interface type through OF device data
- Moved define for max number of interrupts from pcie-iproc.h to
pcie-iproc-msi.c
- Other misc. changes

Ray Jui (5):
  PCI: iproc: Update iProc PCIe device tree binding
  PCI: iproc: Add PAXC interface support
  PCI: iproc: Add iProc PCIe MSI device tree binding
  PCI: iproc: Add iProc PCIe MSI support
  ARM: dts: Enable MSI support for Broadcom Cygnus

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  44 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  22 +
 drivers/pci/host/Kconfig                           |   9 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-iproc-msi.c                  | 662 +++++++++++++++++++++
 drivers/pci/host/pcie-iproc-platform.c             |  24 +-
 drivers/pci/host/pcie-iproc.c                      | 228 +++++--
 drivers/pci/host/pcie-iproc.h                      |  40 +-
 8 files changed, 987 insertions(+), 43 deletions(-)
 create mode 100644 drivers/pci/host/pcie-iproc-msi.c

-- 
1.9.1

