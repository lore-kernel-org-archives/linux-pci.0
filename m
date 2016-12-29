Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36739 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbcL2UpQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2016 15:45:16 -0500
Received: by mail-lf0-f43.google.com with SMTP id t196so227448894lff.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2016 12:45:15 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc: artemi.ivanov@cogentembedded.com, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit DMA mask
Date: Thu, 29 Dec 2016 23:45:03 +0300
Message-Id: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is possible that PCI device supports 64-bit DMA addressing, and thus
it's driver sets device's dma_mask to DMA_BIT_MASK(64), however PCI host
bridge has limitations on inbound transactions addressing. Example of
such setup is NVME SSD device connected to RCAR PCIe controller.

Previously there was attempt to handle this via bus notifier: after
driver is attached to PCI device, bridge driver gets notifier callback,
and resets dma_mask from there. However, this is racy: PCI device driver
could already allocate buffers and/or start i/o in probe routine.
In NVME case, i/o is started in workqueue context, and this race gives
"sometimes works, sometimes not" effect.

Proper solution should make driver's dma_set_mask() call to fail if host
bridge can't support mask being set.

This patch makes __swiotlb_dma_supported() to check mask being set for
PCI device against dma_mask of struct device corresponding to PCI host
bridge (one with name "pciXXXX:YY"), if that dma_mask is set.

This is the least destructive approach: currently dma_mask of that device
object is not used anyhow, thus all existing setups will work as before,
and modification is required only in actually affected components -
driver of particular PCI host bridge, and dma_map_ops of particular
platform.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm64/mm/dma-mapping.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 290a84f..49645277 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -28,6 +28,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
+#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 
@@ -347,6 +348,16 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
+#ifdef CONFIG_PCI
+	if (dev_is_pci(hwdev)) {
+		struct pci_dev *pdev = to_pci_dev(hwdev);
+		struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
+
+		if (br->dev.dma_mask && (*br->dev.dma_mask) &&
+				(mask & (*br->dev.dma_mask)) != mask)
+			return 0;
+	}
+#endif
 	if (swiotlb)
 		return swiotlb_dma_supported(hwdev, mask);
 	return 1;
-- 
2.1.4

