Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <wangbinghui@hisilicon.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dimitrysh@google.com>
CC: <chenyao11@huawei.com>, <songxiaowei@hisilicon.com>
Subject: [PATCH v5 0/1] *** PCI: kirin: Add MSI support ***
Date: Thu, 28 Jun 2018 20:48:02 +0800
Message-ID: <20180628124803.110315-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Before Version Patches
======================
patch v4
https://patchwork.kernel.org/patch/10402399/
patch v3
https://www.spinics.net/lists/linux-pci/msg72322.html
patch v2
https://www.spinics.net/lists/kernel/msg2797610.html

patch v1
https://www.spinics.net/lists/kernel/msg2796410.html

Changes between V5 and V4
=========================
1. rebase the patch based on Linux next-version branch.
2. fix issues according to review comments from Andy Shevchenko and Lorenzo.
   (1) Del MSI irq handler for DW handle it, while Kirin only read the number from DT,
   (2) Use the function dw_pcie_msi_init directly if CONFIG_PCI_MSI is enabled.

Changes between V4 and V3
=========================
1. remove DT binding patch, for Wei Xu had applied it.
2. fix issues according to review comments from Andy Shevchenko.
   (1) Take the msi number get and request as a seperate function,
   (2) Use the result of  platform_get_irq as return val.

Changes between V3 and V2
=========================
1. fix issues according to review comments
   (1)from Bjorn Helgaas: Check for 'pci->pp.msi_irq < 0'.
   (2)from Bjorn Helgaas: Update the message of 'msi irq' in dev_err().

Changes between V2 and V1
=========================
1. seperate DT binding patch.
2. fix issues according to review comments
   (1)from Bjorn Helgaas: Update the style of subject and changelog.
   (2)from Bjorn Helgaas: Add msi irq number in the message.
   (3)from Bjorn Helgaas: Delete unnecessary code 'pci->pp.root_bus_nr = -1'.
   (4)from Dmitry Shmidt: Fix typing error. Replace 'interrupts-names' of 'interrupt-names'.

Xiaowei Song (1):
  PCI: kirin: Add MSI support

 drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.11.GIT
