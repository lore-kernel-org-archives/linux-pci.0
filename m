Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:50431 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeGKHAX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jul 2018 03:00:23 -0400
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <wangbinghui@hisilicon.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <andy.shevchenko@gmail.com>
CC: <kongfei@hisilicon.com>, <chenyao11@huawei.com>,
        <songxiaowei@hisilicon.com>
Subject: [PATCH v6 0/1] PCI: kirin: Add MSI support
Date: Wed, 11 Jul 2018 14:57:23 +0800
Message-ID: <20180711065724.128299-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Before Version Patches
======================
patch v5
https://patchwork.kernel.org/patch/10493797/
patch v4
https://patchwork.kernel.org/patch/10402399/
patch v3
https://www.spinics.net/lists/linux-pci/msg72322.html
patch v2
https://www.spinics.net/lists/kernel/msg2797610.html

patch v1
https://www.spinics.net/lists/kernel/msg2796410.html

Changes between V6 and V5
=========================
1. Fix the bug pointed by Lorenzo.
	(1) The bug of checking the return value of kirin_pcie_add_msi is fixed, which was pointed by Lorenzo.
2. Test the patch based on Hikey960.
   (1) the patch is tested on Hikey960 board with COLORFUL CN600 M.2 SSD connected.
   (2) As i can not cat /proc/interrupts for "adb shell"  is not working, so some log was added to test this patch as following.
			--- a/drivers/nvme/host/pci.c
			+++ b/drivers/nvme/host/pci.c
			@@ -1966,8 +1966,13 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
					pci_free_irq_vectors(pdev);
					result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues + 1,
									PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
			-       if (result <= 0)
			+       if (result <= 0) {
			+               printk(KERN_ERR "NVMe: alloc irq Fail.\n");
							return -EIO;
			+       }
			+       else
			+               printk(KERN_ERR "PCIe Device NVMe enable MSI IRQ Success.\n");
			+

			--- a/drivers/pci/dwc/pcie-kirin.c
			+++ b/drivers/pci/dwc/pcie-kirin.c
			@@ -462,6 +462,9 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
							}

							pci->pp.msi_irq = ret;
			+
			+               dev_err(&pdev->dev,
			+                               "Kirin PCIe MSI IRQ No.(%d)\n", ret);
					}

					return ret;

    (3) The running log is shown as below:
			...
			[    0.567993] kirin-pcie f4000000.pcie: Kirin PCIe MSI IRQ No.(55)
			[    0.568012] PCI: OF: host bridge /soc/pcie@f4000000 ranges:
			[    0.568026] PCI: OF:   MEM 0xf6000000..0xf7ffffff -> 0x00000000
			[    0.587310] kirin-pcie f4000000.pcie: PCI host bridge to bus 0000:00
			[    0.587319] pci_bus 0000:00: root bus resource [bus 00-ff]
			[    0.587326] pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf7ffffff] (bus address [0x00000000-0x01ffffff])
			[    0.587362] pci 0000:00:00.0: [19e5:3660] type 01 class 0x060400
			[    0.587409] pci 0000:00:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit]
			[    0.587514] pci 0000:00:00.0: supports D1 D2
			[    0.587519] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
			[    0.589065] pci 0000:01:00.0: [10ec:5760] type 00 class 0x010802
			[    0.589643] pci 0000:01:00.0: reg 0x10: [mem 0xf6000000-0xf6003fff 64bit]
			[    0.590142] pci 0000:01:00.0: reg 0x24: [mem 0xf6000000-0xf6001fff]
			[    0.604141] pci 0000:00:00.0: BAR 0: assigned [mem 0xf6000000-0xf6ffffff 64bit]
			[    0.604158] pci 0000:00:00.0: BAR 14: assigned [mem 0xf7000000-0xf70fffff]
			[    0.604166] pci 0000:01:00.0: BAR 0: assigned [mem 0xf7000000-0xf7003fff 64bit]
			[    0.604344] pci 0000:01:00.0: BAR 5: assigned [mem 0xf7004000-0xf7005fff]
			[    0.604400] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
			[    0.604409] pci 0000:00:00.0:   bridge window [mem 0xf7000000-0xf70fffff]
			[    0.604750] pcieport 0000:00:00.0: Signaling PME with IRQ 62
			[    0.604853] pcieport 0000:00:00.0: AER enabled with IRQ 62
			...
			[    0.623179] nvme nvme0: pci function 0000:01:00.0
			[    0.623252] nvme 0000:01:00.0: enabling device (0000 -> 0002)
			...
			[    0.974765] PCIe Device NVMe enable MSI IRQ Success.
			...

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
