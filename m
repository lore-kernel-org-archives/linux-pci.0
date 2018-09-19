Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34788 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISULU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:20 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
Date: Wed, 19 Sep 2018 10:32:01 -0400
Message-Id: <1537367527-20773-7-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The design of the Broadcom PCIe RC controller requires us to remap its
DMA addresses for inbound traffic.  We do this by modifying the
definitions of __phys_to_dma() and __dma_to_phys().

In arch/mips/bmips/dma.c, these functions are already in use to remap
DMA addresses for the 338x SOC chips.  We leave this code alone -- and
give its mapping priority -- but if it is not in use, the PCIe DMA
mapping is in effect.

One might think that the two DMA remapping systems of dma.c could be
combined, but they cannot: one governs only DMA addresses for the PCIe
controller of BrcmSTB ARM/ARM64/MIPs chips, while the other governs
the PCIe controller *and* other peripherals for only MIPs 338x
chips.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/bmips/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 3d13c77..292994f 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/bmips.h>
+#include <soc/brcmstb/common.h>
 
 /*
  * BCM338x has configurable address translation windows which allow the
@@ -44,6 +45,10 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
 {
 	struct bmips_dma_range *r;
 
+#ifdef CONFIG_PCIE_BRCMSTB
+	if (!bmips_dma_ranges)
+		return brcm_phys_to_dma(dev, pa);
+#endif
 	for (r = bmips_dma_ranges; r && r->size; r++) {
 		if (pa >= r->child_addr &&
 		    pa < (r->child_addr + r->size))
@@ -56,6 +61,10 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	struct bmips_dma_range *r;
 
+#ifdef CONFIG_PCIE_BRCMSTB
+	if (!bmips_dma_ranges)
+		return (unsigned long)brcm_dma_to_phys(dev, dma_addr);
+#endif
 	for (r = bmips_dma_ranges; r && r->size; r++) {
 		if (dma_addr >= r->parent_addr &&
 		    dma_addr < (r->parent_addr + r->size))
-- 
1.9.0.138.g2de3478
