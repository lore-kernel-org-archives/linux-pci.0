Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH 1/2] PCI: Add quirk for Fintek F81504/508/512 AER issue
Date: Mon,  7 Nov 2016 17:22:31 +0800
Message-Id: <1478510552-4883-2-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fintek F81504/508/512 PCIe-to-UART/GPIO will generate mass AER
correctable error interrupt message and stop the system boot on Intel
Skylake platform, AER message like the following link:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1521173

Due to the error is correctable error, we'll try to mask the parent AER
interrupt to skip it and preserve generate uncorrectable erro interrupt
normally.

Tested and verified on Ganlot PGB-8130 industrial gaming PCB

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/pci/quirks.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  5 +++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729..182712e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
@@ -4460,3 +4461,39 @@ static void quirk_no_aersid(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
+
+/*
+ * Fintek F81504/508/512 PCIe-to-UART/GPIO will generate mass AER
+ * correctable error interrupt message and stop the system boot on Intel
+ * Skylake platform, AER message like the following link:
+ * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1521173
+ *
+ * Due to the error is correctable error, we'll try to mask the parent AER
+ * interrupt to skip it and preserve generate uncorrectable erro interrupt
+ * normally.
+ */
+static void quirk_aer_report(struct pci_dev *pdev)
+{
+	struct pci_dev *parent;
+	int pos;
+	u32 mask = PCI_ERR_COR_RCVR | PCI_ERR_COR_BAD_TLP |
+			PCI_ERR_COR_BAD_DLLP | PCI_ERR_COR_REP_TIMER;
+
+	parent = pci_upstream_bridge(pdev);
+	if (!parent)
+		return;
+
+	pos = pci_find_ext_capability(parent, PCI_EXT_CAP_ID_ERR);
+	if (!pos) {
+		dev_dbg(&pdev->dev, "%s: bridge not support AER\n", __func__);
+		return;
+	}
+
+	pci_write_config_dword(parent, pos + PCI_ERR_COR_MASK, mask);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81504,
+			quirk_aer_report);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81508,
+			quirk_aer_report);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81512,
+			quirk_aer_report);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c58752f..9854cf4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3034,4 +3034,9 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_FINTEK		0x1c29
+#define PCI_DEVICE_ID_F81504		0x1104
+#define PCI_DEVICE_ID_F81508		0x1108
+#define PCI_DEVICE_ID_F81512		0x1112
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
1.9.1
