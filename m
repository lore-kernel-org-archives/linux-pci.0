Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHIWat (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 18:30:49 -0400
Subject: [PATCH v4 2/3] PCI: Samsung SM961/PM961 NVMe disable before FLR
 quirk
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Thu, 09 Aug 2018 14:04:22 -0600
Message-ID: <153384506190.15793.5959667641864701895.stgit@gimli.home>
In-Reply-To: <153384487209.15793.15203778129263981368.stgit@gimli.home>
References: <153384487209.15793.15203778129263981368.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Samsung SM961/PM961 (960 EVO) sometimes fails to return from FLR
with the PCI config space reading back as -1.  A reproducible instance
of this behavior is resolved by clearing the enable bit in the NVMe
configuration register and waiting for the ready status to clear
(disabling the NVMe controller) prior to FLR.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1542494
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/quirks.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e72c8742aafa..0a4d802cb307 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/switchtec.h>
+#include <linux/nvme.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -3669,6 +3670,87 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
 
+/*
+ * The Samsung SM961/PM961 controller can sometimes enter a fatal state after
+ * FLR where config space reads from the device return -1.  We seem to be
+ * able to avoid this condition if we disable the NVMe controller prior to
+ * FLR.  This quirk is generic for any NVMe class device requiring similar
+ * assistance to quiesce the device prior to FLR.
+ *
+ * NVMe specification: https://nvmexpress.org/resources/specifications/
+ * Revision 1.0e:
+ *    Chapter 2: Required and optional PCI config registers
+ *    Chapter 3: NVMe control registers
+ *    Chapter 7.3: Reset behavior
+ */
+static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
+{
+	void __iomem *bar;
+	u16 cmd;
+	u32 cfg;
+
+	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
+	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
+	if (!bar)
+		return -ENOTTY;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
+
+	cfg = readl(bar + NVME_REG_CC);
+
+	/* Disable controller if enabled */
+	if (cfg & NVME_CC_ENABLE) {
+		u32 cap = readl(bar + NVME_REG_CAP);
+		unsigned long timeout;
+
+		/*
+		 * Per nvme_disable_ctrl() skip shutdown notification as it
+		 * could complete commands to the admin queue.  We only intend
+		 * to quiesce the device before reset.
+		 */
+		cfg &= ~(NVME_CC_SHN_MASK | NVME_CC_ENABLE);
+
+		writel(cfg, bar + NVME_REG_CC);
+
+		/*
+		 * Some controllers require an additional delay here, see
+		 * NVME_QUIRK_DELAY_BEFORE_CHK_RDY.  None of those are yet
+		 * supported by this quirk.
+		 */
+
+		/* Cap register provides max timeout in 500ms increments */
+		timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
+		for (;;) {
+			u32 status = readl(bar + NVME_REG_CSTS);
+
+			/* Ready status becomes zero on disable complete */
+			if (!(status & NVME_CSTS_RDY))
+				break;
+
+			msleep(100);
+
+			if (time_after(jiffies, timeout)) {
+				pci_warn(dev, "Timeout waiting for NVMe ready status to clear after disable\n");
+				break;
+			}
+		}
+	}
+
+	pci_iounmap(dev, bar);
+
+	pcie_flr(dev);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -3676,6 +3758,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
+	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
 	{ 0 }
