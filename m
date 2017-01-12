Return-Path: <SRS0=SCap=Y2=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=SCap=Y2=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH 0/3] PCI:hisi: Add DT almost ECAM support for HiSilicon Hip06/Hip07 host controllers
Date: Thu, 12 Jan 2017 14:28:21 +0800
Message-ID: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

The PCIe controller in Hip06/Hip07 SoCs is not completely
ECAM-compliant. It is non-ECAM only for the RC bus config space; for
any other bus underneath the root bus it does support ECAM access.

This series contains
1. Add the almost ECAM support in DT way. 
2. Add quirk to set root port pdev->no_msi = 1. 
3. Add condition #ifndef CONFIG_ARM64 for pci_fixup_irqs.

This patchset is based on 4.10-rc3.

Dongdong Liu (3):
  PCI:hisi: Add DT almost ECAM support for HiSilicon Hip06/Hip07 host
    controllers
  PCI: Set pdev->no_msi=1 for HiSilicon Hip06/Hip07 host controllers
  PCI: generic: Fix the bug of pci_fixup_irqs() for arm64 platform.

 .../devicetree/bindings/pci/hisilicon-pcie.txt     | 37 +++++++++++++++
 drivers/pci/host/pci-host-common.c                 |  2 +
 drivers/pci/host/pcie-hisi.c                       | 54 ++++++++++++++++++++--
 drivers/pci/quirks.c                               |  1 +
 include/linux/pci_ids.h                            |  3 ++
 5 files changed, 94 insertions(+), 3 deletions(-)

-- 
1.9.1
