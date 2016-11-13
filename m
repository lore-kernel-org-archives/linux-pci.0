Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55073 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933828AbcKMOWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 09:22:06 -0500
From: Noa Osherovich <noaos@mellanox.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
        majd@mellanox.com, noaos@mellanox.com
Subject: [PATCH 2/4] PCI: Convert Mellanox quirks to be for listed devices only
Date: Sun, 13 Nov 2016 16:21:40 +0200
Message-Id: <1479046901-25360-3-git-send-email-noaos@mellanox.com>
In-Reply-To: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
References: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change Mellanox's broken_intx_masking quirk from an "all Mellanox
devices" to a quirk for listed devices only.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
---
 drivers/pci/quirks.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85048fdf2474..d3977c847e1f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3158,8 +3158,59 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8169,
 			quirk_broken_intx_masking);
+
+#define PCI_DEVICE_ID_MELLANOX_HERMON_SDR 0x6340
+#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR 0x634a
+#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR 0x6354
+#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2 0x6732
+#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2 0x673c
+#define PCI_DEVICE_ID_MELLANOX_HERMON_EN 0x6368
+#define PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2 0x6750
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN 0x6372
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2 0x675a
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2 0x6764
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2 0x6746
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX2 0x676e
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX3 0x1003
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO 0x1007
+#define PCI_DEVICE_ID_MELLANOX_CONNECTIB 0x1011
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4 0x1013
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX 0x1015
+
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
+	PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX
+};
+
+static void mellanox_check_broken_intx_masking(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
+		if (dev->device == mellanox_broken_intx_devs[i]) {
+			dev->broken_intx_masking = 1;
+			return;
+		}
+	}
+}
+
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
-			quirk_broken_intx_masking);
+			mellanox_check_broken_intx_masking);
 
 /*
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
-- 
1.8.3.1

