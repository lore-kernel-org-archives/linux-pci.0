Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:51936 "EHLO
	sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab3CFF7w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 00:59:52 -0500
From: xiong <xiong@qca.qualcomm.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <unified-drivers@lists.infradead.org>,
	<nic-devel@qca.qualcomm.com>,
	"Huang,Xiong" <xiong@qca.qualcomm.com>
Subject: [PATCH] PCI: add MSI INTX_DISABLE quirks for AR8161/AR8162/AR8171/AR8172
Date: Wed, 6 Mar 2013 13:59:07 +0800
Message-ID: <1362549547-2160-1-git-send-email-xiong@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Huang,Xiong" <xiong@qca.qualcomm.com>

PCI devices of AR8161/AR8162/AR8171/AR8172 which revision lower than
0x18 have this bug.

Signed-off-by: Huang,Xiong <xiong@qca.qualcomm.com>
---
 drivers/pci/quirks.c    | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0369fb6..bf31d72 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2594,6 +2594,29 @@ static void quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
 		dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
 	pci_dev_put(p);
 }
+static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
+{
+	static u16 qca_eth_devid[] = {
+			PCI_DEVICE_ID_AR8161,
+			PCI_DEVICE_ID_AR8162,
+			PCI_DEVICE_ID_AR8171,
+			PCI_DEVICE_ID_AR8172};
+	struct pci_dev *p;
+	int i;
+
+	/* AR816X/AR817X MSI is fixed at HW level from revision 0x18 */
+	for (i = 0; i < ARRAY_SIZE(qca_eth_devid); i++) {
+		p = pci_get_device(PCI_VENDOR_ID_ATTANSIC,
+				   qca_eth_devid[i],
+				   NULL);
+		if (!p)
+			return;
+
+		if (p->revision < 0x18)
+			dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
+		pci_dev_put(p);
+	}
+}
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
 			PCI_DEVICE_ID_TIGON3_5780,
 			quirk_msi_intx_disable_bug);
@@ -2643,6 +2666,18 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1073,
 			quirk_msi_intx_disable_bug);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1083,
 			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC,
+			PCI_DEVICE_ID_AR8161,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC,
+			PCI_DEVICE_ID_AR8162,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC,
+			PCI_DEVICE_ID_AR8171,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC,
+			PCI_DEVICE_ID_AR8172,
+			quirk_msi_intx_disable_qca_bug);
 #endif /* CONFIG_PCI_MSI */
 
 /* Allow manual resource allocation for PCI hotplug bridges
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f11c1c2..7e171fb 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2438,6 +2438,10 @@
 #define PCI_VENDOR_ID_ATTANSIC		0x1969
 #define PCI_DEVICE_ID_ATTANSIC_L1	0x1048
 #define PCI_DEVICE_ID_ATTANSIC_L2	0x2048
+#define PCI_DEVICE_ID_AR8161		0x1091
+#define PCI_DEVICE_ID_AR8162		0x1090
+#define PCI_DEVICE_ID_AR8171		0x10A1
+#define PCI_DEVICE_ID_AR8172		0x10A0
 
 #define PCI_VENDOR_ID_JMICRON		0x197B
 #define PCI_DEVICE_ID_JMICRON_JMB360	0x2360
-- 
1.7.11.7

