Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:56925 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1B4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 21:56:19 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/9] Add new helper to allocate IRQ domain for host drivers
Date: Sat, 28 Apr 2018 09:48:22 +0800
Message-Id: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn and Lorenzo,

PCI drivers use highly similar code block to allocate IRQ domain which
leads to code duplication than expected. This patchset adds a new helper,
pci_alloc_intx_irqd(), to avoid that as much as possible. Just leave
pcie-rockchip out now as it's under re-construct and will add incremental
patch for it if this series looks ok and the pcie-rockchip ongoing patches
got merge.


Changes in v2:
- fix typo and move the code to C file.

Shawn Lin (9):
  PCI: Add pci_alloc_intx_irqd() for allocating IRQ domain
  PCI: dra7xx: Use pci_alloc_intx_irqd() helper to simplify the code
  PCI: keystone-dw: Use pci_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: aardvark: Use pci_alloc_intx_irqd() helper to get irq domain for
    INTx
  PCI: faraday: Use pci_alloc_intx_irqd() helper to get irq domain for
    INTx
  PCI: altera: Use pci_alloc_intx_irqd() helper to get irq domain for
    INTx
  PCI: mediatek: Use pci_alloc_intx_irqd() helper to get irq domain for
    INTx
  PCI: xilinx-nwl: Use pci_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: xilinx: Use pci_alloc_intx_irqd() helper to get irq domain for
    INTx

 drivers/pci/dwc/pci-dra7xx.c       | 41 ++---------------------
 drivers/pci/dwc/pci-keystone-dw.c  | 12 +++----
 drivers/pci/host/pci-aardvark.c    | 24 +++-----------
 drivers/pci/host/pci-ftpci100.c    | 15 +++------
 drivers/pci/host/pcie-altera.c     | 38 +++------------------
 drivers/pci/host/pcie-mediatek.c   | 29 ++--------------
 drivers/pci/host/pcie-xilinx-nwl.c | 21 +++---------
 drivers/pci/host/pcie-xilinx.c     | 43 ++----------------------
 drivers/pci/irq.c                  | 68 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                | 10 ++++++
 10 files changed, 108 insertions(+), 193 deletions(-)

-- 
1.9.1
