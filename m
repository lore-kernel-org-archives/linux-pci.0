Return-Path: <SRS0=SCap=Y2=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=SCap=Y2=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH 2/3] PCI: Set pdev->no_msi=1 for HiSilicon Hip06/Hip07 host controllers
Date: Thu, 12 Jan 2017 14:28:23 +0800
Message-ID: <1484202504-96686-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

The PCIe root port in Hip06/Hip07 SoCs does not support MSI/MSI-X,
it can only transfer MSI/MSI-X from EP, so we add the quirk to
set root port pdev->no_msi = 1.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/quirks.c    | 1 +
 include/linux/pci_ids.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1800bef..20cbdae 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1634,6 +1634,7 @@ static void quirk_pcie_mch(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	PCI_DEVICE_ID_HISILICON_1610,	quirk_pcie_mch);
 
 
 /*
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73dda0e..9cc4720 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3054,4 +3054,7 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_HUAWEI         	0x19e5
+#define PCI_DEVICE_ID_HISILICON_1610 	0x1610
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
1.9.1
