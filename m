Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:48630 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbbKRAbw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2015 19:31:52 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 0/5] Add iProc PCIe PAXC and MSI support
Date: Tue, 17 Nov 2015 16:31:50 -0800
Message-ID: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support for the iProc PAXC interface and support for
event queue based MSI, integrated in the iProc PCIe core

Traditionally, all iProc PCIe root complexes use the PAXB interface, with an
integrated on-chip Serdes to support external endpoint devices. On newer iProc
platforms, a PAXC interface is introduced, for connection with internally
emulated PCIe endpoint devices in the ASIC
 
This iProc event queue based MSI support is meant for older platforms including
NS, NSP, Cygnus, and etc. Newer platforms with integrated MSI in the GIC (e.g.,
giv2m or gicv3-its) should not use iProc event queue based MSI

This patch series is based on Linux v4.4-rc1 and is avaliable here:
https://github.com/Broadcom/cygnus-linux/tree/iproc-msi-v1

Ray Jui (5):
  PCI: iproc: Update iProc PCIe device tree binding
  PCI: iproc: Add PAXC interface support
  PCI: iproc: Add iProc PCIe MSI device tree binding
  PCI: iproc: Add iProc PCIe MSI support
  ARM: dts: Enable MSI support for Broadcom Cygnus

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  45 ++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  26 ++
 drivers/pci/host/Kconfig                           |   9 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-iproc-msi.c                  | 434 +++++++++++++++++++++
 drivers/pci/host/pcie-iproc-platform.c             |   8 +
 drivers/pci/host/pcie-iproc.c                      | 221 +++++++++--
 drivers/pci/host/pcie-iproc.h                      |  31 ++
 8 files changed, 740 insertions(+), 35 deletions(-)
 create mode 100644 drivers/pci/host/pcie-iproc-msi.c

-- 
1.9.1

