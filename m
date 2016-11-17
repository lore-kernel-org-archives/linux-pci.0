Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752852AbcKQXa2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 18:30:28 -0500
Subject: [PATCH v3 4/5] PCI: Convert Mellanox broken INTx quirks to be for
 listed devices only
From: Bjorn Helgaas <bhelgaas@google.com>
To: Noa Osherovich <noaos@mellanox.com>
Cc: linux-pci@vger.kernel.org, majd@mellanox.com,
        gwshan@linux.vnet.ibm.com
Date: Thu, 17 Nov 2016 17:30:24 -0600
Message-ID: <20161117233024.2003.82747.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117232458.2003.88193.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Noa Osherovich <noaos@mellanox.com>

Change Mellanox's broken_intx_masking() quirk from an "all Mellanox
devices" to a quirk for listed devices only.

[bhelgaas: remove #defines, reorder to keep other quirks together]
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85048fd..f0515b7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3137,8 +3137,9 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b5, quirk_remove_d3_delay);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x22b7, quirk_remove_d3_delay);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x2298, quirk_remove_d3_delay);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x229c, quirk_remove_d3_delay);
+
 /*
- * Some devices may pass our check in pci_intx_mask_supported if
+ * Some devices may pass our check in pci_intx_mask_supported() if
  * PCI_COMMAND_INTX_DISABLE works though they actually do not properly
  * support this feature.
  */
@@ -3150,6 +3151,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x0030,
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			quirk_broken_intx_masking);
+
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
  * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
@@ -3158,8 +3160,6 @@ DECLARE_PCI_FIXUP_FINAL(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
 			quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
-			quirk_broken_intx_masking);
 
 /*
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
@@ -3194,6 +3194,40 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1,
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d2,
 			quirk_broken_intx_masking);
 
+static u16 mellanox_broken_intx_devs[] = {
+	PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
+	PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
+	PCI_DEVICE_ID_MELLANOX_HERMON_QDR,
+	PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2,
+	PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2,
+	PCI_DEVICE_ID_MELLANOX_HERMON_EN,
+	PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX2,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX3,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
+	PCI_DEVICE_ID_MELLANOX_CONNECTIB,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX4,
+	PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX,
+};
+
+static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
+		if (pdev->device == mellanox_broken_intx_devs[i]) {
+			pdev->broken_intx_masking = 1;
+			return;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
+			mellanox_check_broken_intx_masking);
+
 static void quirk_no_bus_reset(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;

