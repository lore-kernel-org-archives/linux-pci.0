Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35896 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdFTBdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 21:33:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so20165735pfd.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2017 18:33:47 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org
Cc: Daniel Axtens <dja@axtens.net>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: [PATCH v2] PCI: Support hibmc VGA cards behind a misbehaving HiSilicon bridge
Date: Tue, 20 Jun 2017 11:33:02 +1000
Message-Id: <20170620013302.528-1-dja@axtens.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The HiSilicon D05 board has some PCI bridges (PCI ID 19e5:1610) that
are not spec-compliant: the VGA Enable bit is set to 0 in hardware
and writes do not change it.

This stops VGA arbitrartion from marking a VGA card behind the bridge
as a boot device, and therefore breaks Xorg auto-configuration.

The hibmc VGA card (PCI ID 19e5:1711) is known to work when behind
these bridges.

Provide a quirk so that this combination of bridge and card is eligible
to be the default VGA card.

This fixes Xorg auto-detection.

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/pci/quirks.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 16e6cd86ad71..86d7c848f3e2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/vgaarb.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -4664,3 +4665,48 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
+
+/*
+ * The hibmc card on a HiSilicon D05 board sits behind a non-compliant
+ * bridge. The bridge has the PCI_BRIDGE_CTL_VGA config bit fixed at 0
+ * in hardware. This prevents the vgaarb from marking a card behind it
+ * as boot VGA device.
+ *
+ * However, the hibmc card is known to still work, so if we have that
+ * card behind that particular bridge (19e5:1610), mark it as the
+ * default device if none has been detected.
+ */
+static void hibmc_fixup_vgaarb(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	u16 config;
+
+	bus = pdev->bus;
+	bridge = bus->self;
+	if (!bridge)
+		return;
+
+	if (!pci_is_bridge(bridge))
+		return;
+
+	if (bridge->vendor != PCI_VENDOR_ID_HUAWEI ||
+	    bridge->device != 0x1610)
+		return;
+
+	pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+			     &config);
+	if (config & PCI_BRIDGE_CTL_VGA) {
+		/*
+		 * Weirdly, this bridge *is* spec compliant, so bail
+		 * and let vgaarb do its job
+		 */
+		return;
+	}
+
+	if (vga_default_device())
+		return;
+
+	vga_set_default_device(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1711, hibmc_fixup_vgaarb);
-- 
2.11.0
