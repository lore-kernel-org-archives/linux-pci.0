Return-Path: <SRS0=b4qK=7V=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=b4qK=7V=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V5 0/2] PCI/DPC: Add eDPC support
Date: Sat, 19 Aug 2017 17:07:19 +0800
Message-ID: <1503133641-114550-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This patchset is to add eDPC support and use a local
"struct device *dev" for brevity and consistency in DPC driver.

v4->v5:
- Fix some compile warnings.

v3->v4:
- Use pcie_device's device to keep consistency.
- Adjust patch sequence.
 
v2->v3: 
- Add a separate patch to use a local "struct device *dev" 
  for brevity and consistency in  DPC driver.
- Fix comments on PATCH V2.
- Rebase on v4.13-rc5.

v1->v2: 
- Use a stack local variable instead of the allocated memory for
  collecting RP PIO information.
- Fix the condition of RP PIO error.
- Rebase on v4.13-rc1.

Dongdong Liu (2):
  PCI/DPC: Add eDPC support
  PCI/DPC: Add local struct device

 drivers/pci/pcie/pcie-dpc.c   | 187 +++++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h |  10 +++
 2 files changed, 187 insertions(+), 10 deletions(-)

-- 
1.9.1
