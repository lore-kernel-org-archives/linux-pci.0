Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55072 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933689AbcKMOWG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2016 09:22:06 -0500
From: Noa Osherovich <noaos@mellanox.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
        majd@mellanox.com, noaos@mellanox.com
Subject: [PATCH 3/4] PCI: Add checks to mellanox_check_broken_intx_masking
Date: Sun, 13 Nov 2016 16:21:41 +0200
Message-Id: <1479046901-25360-4-git-send-email-noaos@mellanox.com>
In-Reply-To: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
References: <1479046901-25360-1-git-send-email-noaos@mellanox.com>
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
---
 drivers/pci/quirks.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d3977c847e1f..cbd6776e70e6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3192,21 +3192,70 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
 	PCI_DEVICE_ID_MELLANOX_CONNECTX2,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX3,
 	PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
-	PCI_DEVICE_ID_MELLANOX_CONNECTIB,
-	PCI_DEVICE_ID_MELLANOX_CONNECTX4,
-	PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX
 };
 
+#define CONNECTX_4_CURR_MAX_MINOR 99
+#define CONNECTX_4_INTX_SUPPORT_MINOR 14
+
+/*
+ * Checking ConnectX-4/LX FW version to see if it supports legacy interrupts.
+ * If so, don't mark it as broken.
+ * FW minor > 99 means older FW version format and no INTx masking support.
+ * FW minor < 14 means new FW version format and no INTx masking support.
+ */
 static void mellanox_check_broken_intx_masking(struct pci_dev *dev)
 {
+	__be32 __iomem *fw_ver;
+	u16 fw_major;
+	u16 fw_minor;
+	u16 fw_subminor;
+	u32 fw_maj_min;
+	u32 fw_sub_min;
 	int i;
 
+	dev->broken_intx_masking = 1;
+
 	for (i = 0; i < ARRAY_SIZE(mellanox_broken_intx_devs); i++) {
-		if (dev->device == mellanox_broken_intx_devs[i]) {
-			dev->broken_intx_masking = 1;
+		if (dev->device == mellanox_broken_intx_devs[i])
 			return;
-		}
 	}
+
+	/* Getting here means Connect-IB cards and up. Connect-IB has no INTx
+	 * support so shouldn't be checked further
+	 */
+	if (dev->device == PCI_DEVICE_ID_MELLANOX_CONNECTIB) {
+		dev->broken_intx_masking = 0;
+		return;
+	}
+
+	/* For ConnectX-4 and ConnectX-4LX, need to check FW support */
+	if (pci_enable_device_mem(dev)) {
+		dev_warn(&dev->dev, "Can't enable device memory\n");
+		return;
+	}
+
+	/* Convert from PCI bus to resource space. */
+	fw_ver = ioremap(pci_resource_start(dev, 0), 4);
+	if (!fw_ver) {
+		dev_warn(&dev->dev, "Can't map ConnectX-4 initialization segment\n");
+		return;
+	}
+
+	/* Reading from resource space should be 32b aligned */
+	fw_maj_min = ioread32be(fw_ver);
+	fw_sub_min = ioread32be(fw_ver + 1);
+	fw_major = fw_maj_min & 0xffff;
+	fw_minor = fw_maj_min >> 16;
+	fw_subminor = fw_sub_min & 0xffff;
+	if (fw_minor > CONNECTX_4_CURR_MAX_MINOR ||
+	    fw_minor < CONNECTX_4_INTX_SUPPORT_MINOR)
+		dev_warn(&dev->dev, "ConnectX-4: FW %u.%u.%u doesn't support INTx masking, disabling. Please upgrade FW to %d.14.1100 and up for INTx support\n",
+			 fw_major, fw_minor, fw_subminor, dev->device ==
+			 PCI_DEVICE_ID_MELLANOX_CONNECTX4 ? 12 : 14);
+	else
+		dev->broken_intx_masking = 0;
+
+	iounmap(fw_ver);
 }
 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
-- 
1.8.3.1

