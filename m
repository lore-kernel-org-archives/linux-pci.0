Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:6354 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdERKje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2017 06:39:34 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <mika.westerberg@linux.intel.com>,
        <hch@infradead.org>, <liudongdong3@huawei.com>
Subject: [PATCH v3 0/2] add MSI support for PCIe port services and DPC IRQ support
Date: Thu, 18 May 2017 11:35:46 +0100
Message-ID: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset:
1) adds support for MSI interrupt vectors to be used for Roor Port services
2) adds support for DPC Root Port service interrupt

The patchset has been tested on Hisilicon Hip08 Chipset

Changes from v2:
- Fixed comment mismatch for function pcie_port_enable_irq_vec
- removed redundant commet on pci_irq_vector()

Changes from v1:
According to comments from Christoph Hellwig in
https://www.spinics.net/lists/kernel/msg2508842.html
and
https://www.spinics.net/lists/kernel/msg2508850.html

- reduced the calls of pci_alloc_irq_vectors by ORing PCI_IRQ_MSIX and 
  PCI_IRQ_MSI
- used a unique macro for the max number of MSI/MSIx interrupt vectors
- reworked pcie_init_service_irqs() to call pci_alloc_irq_vectors() only
  for legacy IRQ

Gabriele Paoloni (1):
  PCI/portdrv: add support for different MSI interrupts for PCIe port
    services

gabriele paoloni (1):
  PCI/portdrv: allocate MSI/MSIx vector for DPC RP service

 drivers/pci/pcie/portdrv.h      |  8 +++--
 drivers/pci/pcie/portdrv_core.c | 68 ++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 21 deletions(-)

-- 
2.7.4
