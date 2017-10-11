Return-Path: <SRS0=aHpY=BK=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=aHpY=BK=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <hch@lst.de>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V4 0/2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service drivers
Date: Wed, 11 Oct 2017 18:52:56 +0800
Message-ID: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This patchset is to optimize the interrupt vector allocation strategy
in pcie_port_enable_irq_vec() and add #defines for the AER and DPC
Interrupt Message Number masks.

v3->v4: 
- Optimize the interrupt vector allocation strategy in
pcie_port_enable_irq_vec().
- add #defines for the AER and DPC Interrupt Message Number masks.
v2->v3:
- Use a 12-character SHA1 commit id.
- Rebase on v4.14-rc4.
v1->v2:
- Fix comments on PATCH v1.
- Simplify implementation.

Dongdong Liu (2):
  PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service drivers
  PCI/portdrv: Add #defines for the AER and DPC Interrupt Message Number
    masks

 drivers/pci/pcie/portdrv_core.c | 49 ++++++++++++++---------------------------
 include/uapi/linux/pci_regs.h   |  2 ++
 2 files changed, 18 insertions(+), 33 deletions(-)

-- 
1.9.1
