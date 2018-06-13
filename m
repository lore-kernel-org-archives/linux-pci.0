Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:35667 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934182AbeFMHZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 03:25:22 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/10] Add new helper to allocate IRQ domain for host drivers
Date: Wed, 13 Jun 2018 15:24:56 +0800
Message-Id: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn and Lorenzo,

PCI host drivers use highly similar code block to allocate IRQ domain which
leads to code duplication than expected. This patchset adds a new helper,
pci_host_alloc_intx_irqd(), to avoid that as much as possible.


Changes in v3:
- rename to pci_host_alloc_intx_irqd and move to probe.c
- fix compile error reported by Kbuild Robot
- rebased

Changes in v2:
- fix typo and move the code to C file.

Shawn Lin (10):
  PCI: Add pci_host_alloc_intx_irqd() for allocating IRQ domain
  PCI: dra7xx: Use pci_host_alloc_intx_irqd() helper to simplify the
    code
  PCI: keystone-dw: Use pci_host_alloc_intx_irqd() helper to get irq
    domain for INTx
  PCI: aardvark: Use pci_host_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: faraday: Use pci_host_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: altera: Use pci_host_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: mediatek: Use pci_host_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: xilinx-nwl: Use pci_host_alloc_intx_irqd() helper to get irq
    domain for INTx
  PCI: xilinx: Use pci_host_alloc_intx_irqd() helper to get irq domain
    for INTx
  PCI: rockchip: Use pci_host_alloc_intx_irqd() helper to get irq domain
    for INTx

 drivers/pci/controller/dwc/pci-dra7xx.c      | 42 ++--------------
 drivers/pci/controller/dwc/pci-keystone-dw.c | 13 ++---
 drivers/pci/controller/pci-aardvark.c        | 24 ++-------
 drivers/pci/controller/pci-ftpci100.c        | 15 ++----
 drivers/pci/controller/pcie-altera.c         | 38 ++------------
 drivers/pci/controller/pcie-mediatek.c       | 30 ++---------
 drivers/pci/controller/pcie-rockchip-host.c  | 38 ++------------
 drivers/pci/controller/pcie-xilinx-nwl.c     | 22 ++-------
 drivers/pci/controller/pcie-xilinx.c         | 44 ++---------------
 drivers/pci/probe.c                          | 74 ++++++++++++++++++++++++++++
 include/linux/pci.h                          | 13 +++++
 11 files changed, 125 insertions(+), 228 deletions(-)

-- 
1.9.1
