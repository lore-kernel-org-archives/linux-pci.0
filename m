Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42745 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966524AbcKAOr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2016 10:47:59 -0400
From: Noa Osherovich <noaos@mellanox.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, noaos@mellanox.com
Subject: [PATCH] PCI: Refine broken INTx masking for Mellanox devices
Date: Tue,  1 Nov 2016 16:47:24 +0200
Message-Id: <1478011644-12080-1-git-send-email-noaos@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mellanox devices were marked as having INTx masking ability broken.
As a result, the VFIO driver fails to start when more than one device
function is passed-through to a VM if both have the same INTx pin.

Prior to Connect-IB, Mellanox devices exposed to the operating system
one PCI function per all ports.
Starting from Connect-IB, the devices are function-per-port. When
passing the second function to a VM, VFIO will fail to start.

Exclude ConnectX-4, ConnectX4-Lx and Connect-IB from the list of
Mellanox devices marked as having broken INTx masking:

- ConnectX-4 and ConnectX4-LX firmware version is checked. If INTx
  masking is supported, we unmark the broken INTx masking.
- Connect-IB does not support INTx currently so will not cause any
  problem.

Fixes: 11e42532ada31 ('PCI: Assume all Mellanox devices have ...')
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
--
Previous patch version can be found here:
https://patchwork.ozlabs.org/patch/612222/
---
 drivers/pci/quirks.c    | 111 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci_ids.h |  16 +++++++
 2 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c232729f5b1b..9e6d6aafc2ab 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3158,8 +3158,117 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
 			 quirk_broken_intx_masking);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
+
+#define CONNECTX_4_CURR_MAX_MINOR 99
+#define CONNECTX_4_INTX_SUPPORT_MINOR 14
+
+/*
+ * Checking ConnectX-4/LX FW version to see if it supports legacy interrupts.
+ * If so, don't mark it as broken.
+ * FW minor > 99 means older FW version format and no INTx masking support.
+ * FW minor < 14 means new FW version format and no INTx masking support.
+ */
+static void quirk_connectx_4_verify_fw(struct pci_dev *dev)
+{
+	u16 pmcsr;
+	u8 __iomem *fw_ver;
+	u8 fw_minor;
+
+	dev->broken_intx_masking = 1;
+
+	/*
+	 * Check that the device is in the D0 power state. If it's not,
+	 * there is no point to look any further.
+	 */
+	if (dev->pm_cap) {
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0)
+			return;
+	}
+
+	/* Convert from PCI bus to resource space.  */
+	fw_ver = ioremap(pci_resource_start(dev, 0), 2);
+	if (!fw_ver) {
+		dev_warn(&dev->dev, "Can't map ConnectX-4 initialization segment\n");
+		return;
+	}
+
+	fw_minor = readb(fw_ver + 1);
+	if (fw_minor > CONNECTX_4_CURR_MAX_MINOR ||
+	    fw_minor < CONNECTX_4_INTX_SUPPORT_MINOR)
+		dev_warn(&dev->dev, "ConnectX-4: FW doesn't support INTx masking, disabling. Please upgrade FW for INTx support\n");
+	else
+		dev->broken_intx_masking = 0;
+
+	iounmap(fw_ver);
+}
+
+/*
+ * Mellanox devices that fail under PCI device assignment using DisINTx masking
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_ARBEL,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SINAI,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_SINAI_OLD,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_QDR,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_EN,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX2,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX3,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
 			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX4,
+			 quirk_connectx_4_verify_fw);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX,
+			 quirk_connectx_4_verify_fw);
 
 /*
  * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c58752fe16c4..1c742842e76c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2262,6 +2262,22 @@
 #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
 #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
 #define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
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
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4 0x1013
+#define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX 0x1015
 
 #define PCI_VENDOR_ID_DFI		0x15bd
 
-- 
1.8.3.1

