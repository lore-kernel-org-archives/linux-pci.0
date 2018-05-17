Return-Path: <linux-kernel-owner@vger.kernel.org>
From: dmeyer@gigaio.com
To: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>
Subject: [PATCH 1/2] NTB: Migrate PCI Constants to Cannonical PCI Header
Date: Thu, 17 May 2018 05:00:12 -0700
Message-Id: <1526558413-23113-2-git-send-email-dmeyer@gigaio.com>
In-Reply-To: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Doug Meyer <dmeyer@gigaio.com>

This is the first of two patches to implement a PCI quirk which will
allow the Switchtec NTB code to work with the IOMMU turned on.

Here, the Microsemi Switchtec PCI vendor and device ID constants are
moved to the canonical location in pci_ids.h. Also, Microsemi class
constants are replaced with the standard PCI usage.

Signed-off-by: Doug Meyer <dmeyer@gigaio.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  3 ++-
 drivers/pci/switch/switchtec.c         | 15 +++++++--------
 include/linux/pci_ids.h                | 32 ++++++++++++++++++++++++++++++++
 include/linux/switchtec.h              |  4 ----
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index f624ae2..5ee5f40 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -19,6 +19,7 @@
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/ntb.h>
+#include <linux/pci.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) NTB Driver");
 MODULE_VERSION("0.1");
@@ -1487,7 +1488,7 @@ static int switchtec_ntb_add(struct device *dev,
 
 	stdev->sndev = NULL;
 
-	if (stdev->pdev->class != MICROSEMI_NTB_CLASSCODE)
+	if (stdev->pdev->class != (PCI_CLASS_BRIDGE_OTHER << 8))
 		return -ENODEV;
 
 	sndev = kzalloc_node(sizeof(*sndev), GFP_KERNEL, dev_to_node(dev));
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 47cd0c0..07a03b9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 /*
  * Microsemi Switchtec(tm) PCIe Management Driver
  * Copyright (c) 2017, Microsemi Corporation
@@ -641,7 +640,7 @@ static int ioctl_event_summary(struct switchtec_dev *stdev,
 
 	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
 		reg = ioread16(&stdev->mmio_pff_csr[i].vendor_id);
-		if (reg != MICROSEMI_VENDOR_ID)
+		if (reg != PCI_VENDOR_ID_MICROSEMI)
 			break;
 
 		reg = ioread32(&stdev->mmio_pff_csr[i].pff_event_summary);
@@ -1203,7 +1202,7 @@ static void init_pff(struct switchtec_dev *stdev)
 
 	for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
 		reg = ioread16(&stdev->mmio_pff_csr[i].vendor_id);
-		if (reg != MICROSEMI_VENDOR_ID)
+		if (reg != PCI_VENDOR_ID_MICROSEMI)
 			break;
 	}
 
@@ -1267,7 +1266,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	struct switchtec_dev *stdev;
 	int rc;
 
-	if (pdev->class == MICROSEMI_NTB_CLASSCODE)
+	if (pdev->class == (PCI_CLASS_BRIDGE_OTHER << 8))
 		request_module_nowait("ntb_hw_switchtec");
 
 	stdev = stdev_create(pdev);
@@ -1321,19 +1320,19 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 
 #define SWITCHTEC_PCI_DEVICE(device_id) \
 	{ \
-		.vendor     = MICROSEMI_VENDOR_ID, \
+		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
 		.device     = device_id, \
 		.subvendor  = PCI_ANY_ID, \
 		.subdevice  = PCI_ANY_ID, \
-		.class      = MICROSEMI_MGMT_CLASSCODE, \
+		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
 		.class_mask = 0xFFFFFFFF, \
 	}, \
 	{ \
-		.vendor     = MICROSEMI_VENDOR_ID, \
+		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
 		.device     = device_id, \
 		.subvendor  = PCI_ANY_ID, \
 		.subdevice  = PCI_ANY_ID, \
-		.class      = MICROSEMI_NTB_CLASSCODE, \
+		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
 		.class_mask = 0xFFFFFFFF, \
 	}
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index cc608fc5..7b04ca95 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3073,4 +3073,36 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_MICROSEMI			0x11f8
+#define PCI_DEVICE_ID_MICROSEMI_PFX24XG3	0x8531
+#define PCI_DEVICE_ID_MICROSEMI_PFX32XG3	0x8532
+#define PCI_DEVICE_ID_MICROSEMI_PFX48XG3	0x8533
+#define PCI_DEVICE_ID_MICROSEMI_PFX64XG3	0x8534
+#define PCI_DEVICE_ID_MICROSEMI_PFX80XG3	0x8535
+#define PCI_DEVICE_ID_MICROSEMI_PFX96XG3	0x8536
+#define PCI_DEVICE_ID_MICROSEMI_PSX24XG3	0x8541
+#define PCI_DEVICE_ID_MICROSEMI_PSX32XG3	0x8542
+#define PCI_DEVICE_ID_MICROSEMI_PSX48XG3	0x8543
+#define PCI_DEVICE_ID_MICROSEMI_PSX64XG3	0x8544
+#define PCI_DEVICE_ID_MICROSEMI_PSX80XG3	0x8545
+#define PCI_DEVICE_ID_MICROSEMI_PSX96XG3	0x8546
+#define PCI_DEVICE_ID_MICROSEMI_PAX24XG3	0x8551
+#define PCI_DEVICE_ID_MICROSEMI_PAX32XG3	0x8552
+#define PCI_DEVICE_ID_MICROSEMI_PAX48XG3	0x8553
+#define PCI_DEVICE_ID_MICROSEMI_PAX64XG3	0x8554
+#define PCI_DEVICE_ID_MICROSEMI_PAX80XG3	0x8555
+#define PCI_DEVICE_ID_MICROSEMI_PAX96XG3	0x8556
+#define PCI_DEVICE_ID_MICROSEMI_PFXL24XG3	0x8561
+#define PCI_DEVICE_ID_MICROSEMI_PFXL32XG3	0x8562
+#define PCI_DEVICE_ID_MICROSEMI_PFXL48XG3	0x8563
+#define PCI_DEVICE_ID_MICROSEMI_PFXL64XG3	0x8564
+#define PCI_DEVICE_ID_MICROSEMI_PFXL80XG3	0x8565
+#define PCI_DEVICE_ID_MICROSEMI_PFXL96XG3	0x8566
+#define PCI_DEVICE_ID_MICROSEMI_PFXI24XG3	0x8571
+#define PCI_DEVICE_ID_MICROSEMI_PFXI32XG3	0x8572
+#define PCI_DEVICE_ID_MICROSEMI_PFXI48XG3	0x8573
+#define PCI_DEVICE_ID_MICROSEMI_PFXI64XG3	0x8574
+#define PCI_DEVICE_ID_MICROSEMI_PFXI80XG3	0x8575
+#define PCI_DEVICE_ID_MICROSEMI_PFXI96XG3	0x8576
+
 #endif /* _LINUX_PCI_IDS_H */
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index ec93e93..ab400af 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -19,10 +19,6 @@
 #include <linux/pci.h>
 #include <linux/cdev.h>
 
-#define MICROSEMI_VENDOR_ID         0x11f8
-#define MICROSEMI_NTB_CLASSCODE     0x068000
-#define MICROSEMI_MGMT_CLASSCODE    0x058000
-
 #define SWITCHTEC_MRPC_PAYLOAD_SIZE 1024
 #define SWITCHTEC_MAX_PFF_CSR 48
 
-- 
1.8.3.1
