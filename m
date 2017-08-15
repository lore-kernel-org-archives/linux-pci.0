Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:62996 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbdHOTCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2017 15:02:50 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v7 0/8] PCI: INTx interrupt fixes & cleanup
Date: Tue, 15 Aug 2017 12:02:15 -0700
Message-ID: <20170815190223.18807-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series fixes our handling of the PCI INTD interrupts in both Xilinx
PCIe controller drivers, and cleans up a wasted IRQ domain entry in the
Altera PCIe controller driver. It also adds a common PCI_INTX_NUM
definition which all relevant drivers under drivers/pci/host/ are
adjusted to make use of.

- Patch 1 moves enum pci_interrupt_pin to somewhere we can use it from
  PCI host code.

- Patch 2 introduces a helper function to translate 1-4 INTx ranges into
  the 0-3 range, by using it as a struct irq_domain's xlate callback.

- Patches 3 adjusts the Altera driver to avoid wasting an IRQ domain
  entry.

- Patches 4 & 5 fix the INTD interrupt for Xilinx PCIe drivers.

- Patches 6-8 make use of PCI_NUM_INTX to replace custom definitions or
  magic numbers in drivers.

The series versioning is continuing on from that of my "PCI: xilinx:
Fixes, optimisation & MIPS support" series which some of the earlier
patches were originally a part of, in order to prevent individual
patches from jumping backwards in versioning.

Applies atop v4.13-rc5.

Paul Burton (8):
  PCI: Move enum pci_interrupt_pin to linux/pci.h
  PCI: Introduce pci_irqd_intx_xlate()
  PCI: altera: Use size=4 IRQ domain for legacy INTx
  PCI: xilinx: Translate INTx range to hwirqs 0-3
  PCI: xilinx-nwl: Translate INTx range to hwirqs 0-3
  PCI: aardvark: Use PCI_NUM_INTX
  PCI: ftpci100: Use PCI_NUM_INTX
  PCI: rockchip: Use PCI_NUM_INTX

 drivers/pci/host/pci-aardvark.c    |  5 ++--
 drivers/pci/host/pci-ftpci100.c    |  2 +-
 drivers/pci/host/pcie-altera.c     |  9 +++----
 drivers/pci/host/pcie-rockchip.c   |  2 +-
 drivers/pci/host/pcie-xilinx-nwl.c |  9 +++----
 drivers/pci/host/pcie-xilinx.c     |  7 ++---
 include/linux/pci-epf.h            |  9 +------
 include/linux/pci.h                | 54 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 71 insertions(+), 26 deletions(-)

-- 
2.14.1
