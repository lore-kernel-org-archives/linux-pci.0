Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=f3dI=4W=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>
CC: <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/2] PCI/portdrv: add MSI support for PCIe port services and DPC IRQ support
Date: Tue, 16 May 2017 11:25:40 +0100
Message-ID: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset:
1) adds support for MSI interrupt vectors to be used for Roor Port services
2) adds support for DPC Root Port service interrupt 

The patchset has been tested on Hisilicon Hip08 Chipset

Gabriele Paoloni (1):
  PCI/portdrv: add support for different MSI interrupts for PCIe port
    services

gabriele paoloni (1):
  PCI/portdrv: allocate MSI/MSIx vector for DPC RP service

 drivers/pci/pcie/portdrv.h      |  5 ++++
 drivers/pci/pcie/portdrv_core.c | 62 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 6 deletions(-)

-- 
2.7.4
