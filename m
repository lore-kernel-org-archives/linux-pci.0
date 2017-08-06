Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:40522 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdHFAEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 20:04:14 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v6 0/6] PCI: xilinx: Fixes, optimisation & MIPS support
Date: Sat, 5 Aug 2017 17:03:45 -0700
Message-ID: <20170806000351.17952-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series fixes an issue found using INTx interrupts with the Xilinx
AXI PCIe Host Bridge IP on the Imagination Technologies MIPS Boston
development board, performs a couple of optimisations to interrupt
handling & allows the driver to be used on MIPS systems.

Applies atop v4.13-rc3.

Paul Burton (6):
  PCI: Move enum pci_interrupt_pin to a new common header
  PCI: Introduce pci_irqd_intx_xlate()
  PCI: xilinx: Translate INTx range to hwirqs 0-3
  PCI: xilinx: Unify INTx & MSI interrupt decode
  PCI: xilinx: Don't enable config completion interrupts
  PCI: xilinx: Allow build on MIPS platforms

 drivers/pci/host/Kconfig       |  2 +-
 drivers/pci/host/pcie-xilinx.c | 58 +++++++++++++++---------------------------
 include/linux/pci-common.h     | 31 ++++++++++++++++++++++
 include/linux/pci-epf.h        |  9 +------
 include/linux/pci.h            | 33 ++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/pci-common.h

-- 
2.13.4
