Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:35837
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731356AbeGRCQt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2018 22:16:49 -0400
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <bhelgaas@google.com>
CC: <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2] PCI: Unify pci and normal dma direction definition
Date: Wed, 18 Jul 2018 09:40:35 +0800
Message-ID: <1531878035-33147-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current DMA direction definitions in pci-dma-compat.h and dma-direction.h
are mirrored in value. Unifying them to enhance readability and avoid
possible inconsistency.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---

v2:
  Remove unnecessary comments and  braces according to Christoph's
  comments.

---
 include/linux/dma-direction.h  | 6 ++----
 include/linux/pci-dma-compat.h | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
index 3649a031893a..9c96e30e6a0b 100644
--- a/include/linux/dma-direction.h
+++ b/include/linux/dma-direction.h
@@ -1,14 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_DMA_DIRECTION_H
 #define _LINUX_DMA_DIRECTION_H
-/*
- * These definitions mirror those in pci.h, so they can be used
- * interchangeably with their PCI_ counterparts.
- */
+
 enum dma_data_direction {
 	DMA_BIDIRECTIONAL = 0,
 	DMA_TO_DEVICE = 1,
 	DMA_FROM_DEVICE = 2,
 	DMA_NONE = 3,
 };
+
 #endif
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index 0dd1a3f7b309..c3f1b44ade29 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -8,10 +8,10 @@
 #include <linux/dma-mapping.h>
 
 /* This defines the direction arg to the DMA mapping routines. */
-#define PCI_DMA_BIDIRECTIONAL	0
-#define PCI_DMA_TODEVICE	1
-#define PCI_DMA_FROMDEVICE	2
-#define PCI_DMA_NONE		3
+#define PCI_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
+#define PCI_DMA_TODEVICE	DMA_TO_DEVICE
+#define PCI_DMA_FROMDEVICE	DMA_FROM_DEVICE
+#define PCI_DMA_NONE		DMA_NONE
 
 static inline void *
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-- 
1.8.3.1
