Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:43022 "EHLO
	sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3CGSzs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 13:55:48 -0500
From: xiong <xiong@qca.qualcomm.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <unified-drivers@lists.infradead.org>,
	<nic-devel@qca.qualcomm.com>,
	"Huang,Xiong" <xiong@qca.qualcomm.com>
Subject: [PATCH] PCI: add MSI INTX_DISABLE quirks for AR8161/AR8162/AR8171/AR8172/E210X
Date: Fri, 8 Mar 2013 02:55:16 +0800
Message-ID: <1362682516-9840-1-git-send-email-xiong@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Huang,Xiong" <xiong@qca.qualcomm.com>

following PCIe Devices with revision lower than 0x18 have this bug:

 AR8161(1091)/AR8162(1090)/AR8171(10A1)/AR8172(10A0)/E210X(E091).

Signed-off-by: Huang,Xiong <xiong@qca.qualcomm.com>
---
 drivers/pci/quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0369fb6..4273a2d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2594,6 +2594,14 @@ static void quirk_msi_intx_disable_ati_bug(struct pci_dev *dev)
 		dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
 	pci_dev_put(p);
 }
+static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
+{
+	/* AR816X/AR817X/E210X MSI is fixed at HW level from revision 0x18 */
+	if (dev->revision < 0x18) {
+		dev_info(&dev->dev, "set MSI_INTX_DISABLE_BUG flag\n");
+		dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
+	}
+}
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
 			PCI_DEVICE_ID_TIGON3_5780,
 			quirk_msi_intx_disable_bug);
@@ -2643,6 +2651,16 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1073,
 			quirk_msi_intx_disable_bug);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1083,
 			quirk_msi_intx_disable_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1090,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1091,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a0,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
+			quirk_msi_intx_disable_qca_bug);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
+			quirk_msi_intx_disable_qca_bug);
 #endif /* CONFIG_PCI_MSI */
 
 /* Allow manual resource allocation for PCI hotplug bridges
-- 
1.7.11.7

