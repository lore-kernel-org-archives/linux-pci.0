Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va-smtp02.263.net ([38.83.106.158]:42332 "EHLO smtphy.263.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757548AbeD0Igi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 04:36:38 -0400
Received: from transport.263xmail.com (unknown [38.83.106.156])
        by smtphy.263.net (Postfix) with ESMTPS id BBF462F709D
        for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2018 16:30:28 +0800 (CST)
Received: from lucky1.263xmail.com (unknown [192.168.165.180])
        by transportlucky.263xmail.com (Postfix) with ESMTP id EE622A03C
        for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2018 16:30:27 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/9] Add new helper to allocate irq domain for hosts
Date: Fri, 27 Apr 2018 16:22:02 +0800
Message-Id: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn and Lorenzo,

PCI drivers use highly similar code block to allocate irq domain which
leads to code duplication than expected. This patchset adds a new helper,
pci_alloc_intx_irqd(), to avoid that as much as possible. Just leave
pcie-rockchip out now as it's under re-construct and will add incremental
patch for it if this series looks ok and the pcie-rockchip ongoing patches
got merge.



Shawn Lin (9):
  PCI: Add new helper for allocating irq domain for INTx
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

 drivers/pci/dwc/pci-dra7xx.c       | 41 ++-------------------
 drivers/pci/dwc/pci-keystone-dw.c  | 12 +++----
 drivers/pci/host/pci-aardvark.c    | 24 +++----------
 drivers/pci/host/pci-ftpci100.c    | 15 +++-----
 drivers/pci/host/pcie-altera.c     | 38 +++-----------------
 drivers/pci/host/pcie-mediatek.c   | 29 ++-------------
 drivers/pci/host/pcie-xilinx-nwl.c | 21 +++--------
 drivers/pci/host/pcie-xilinx.c     | 43 ++--------------------
 include/linux/pci.h                | 74 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 104 insertions(+), 193 deletions(-)

-- 
1.9.1
