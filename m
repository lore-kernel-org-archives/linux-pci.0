Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42780 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeISULb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:31 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 10/12] ARM64: declare __phys_to_dma on ARCH_HAS_PHYS_TO_DMA
Date: Wed, 19 Sep 2018 10:32:05 -0400
Message-Id: <1537367527-20773-11-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This change allows one to define custom routines for __phys_to_dma()
and __dma_to_phys() for the ARM64 architecture by selecting
ARCH_HAS_PHYS_TO_DMA.  This is done for similar reasons that caused
arch/x86/include/asm/dma-direct.h to exist (see CONFIG_STA2X11).

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/arm64/include/asm/dma-direct.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
new file mode 100644
index 0000000..d87da92
--- /dev/null
+++ b/arch/arm64/include/asm/dma-direct.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARM64_DMA_DIRECT_H
+#define _ARM64_DMA_DIRECT_H 1
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
+
+#endif /* _ARM64_DMA_DIRECT_H */
-- 
1.9.0.138.g2de3478
