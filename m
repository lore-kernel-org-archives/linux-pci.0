Return-Path: <SRS0=YMSp=7T=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=YMSp=7T=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <keith.busch@intel.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH V3 0/2] PCI/DPC: Add eDPC support
Date: Thu, 17 Aug 2017 19:48:23 +0800
Message-ID: <1502970505-89777-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This patchset is to use a local "struct device *dev" for brevity and
consistency in DPC driver and add eDPC support.

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
  PCI/DPC: Add local struct device
  PCI/DPC: Add eDPC support

 drivers/pci/pcie/pcie-dpc.c   | 177 ++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/pci_regs.h |  10 +++
 2 files changed, 181 insertions(+), 6 deletions(-)

-- 
1.9.1
