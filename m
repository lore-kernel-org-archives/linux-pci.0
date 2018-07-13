Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH] PCI: Unify pci and normal dma direction definition
Date: Fri, 13 Jul 2018 14:37:20 +0800
Message-ID: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current DMA direction definitions in pci-dma-compat.h and dma-direction.h
are mirrored in value. Unify them to enhance readability and avoid
possible inconsistency.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 include/linux/dma-direction.h  | 2 +-
 include/linux/pci-dma-compat.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
index 3649a031893a..9d52716e9218 100644
--- a/include/linux/dma-direction.h
+++ b/include/linux/dma-direction.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_DMA_DIRECTION_H
 #define _LINUX_DMA_DIRECTION_H
 /*
- * These definitions mirror those in pci.h, so they can be used
+ * These definitions mirror those in pci-dma-compat.h, so they can be used
  * interchangeably with their PCI_ counterparts.
  */
 enum dma_data_direction {
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
index 0dd1a3f7b309..c1c8d49b6072 100644
--- a/include/linux/pci-dma-compat.h
+++ b/include/linux/pci-dma-compat.h
@@ -8,10 +8,10 @@
 #include <linux/dma-mapping.h>
 
 /* This defines the direction arg to the DMA mapping routines. */
-#define PCI_DMA_BIDIRECTIONAL	0
-#define PCI_DMA_TODEVICE	1
-#define PCI_DMA_FROMDEVICE	2
-#define PCI_DMA_NONE		3
+#define PCI_DMA_BIDIRECTIONAL	(DMA_BIDIRECTIONAL)
+#define PCI_DMA_TODEVICE	(DMA_TO_DEVICE)
+#define PCI_DMA_FROMDEVICE	(DMA_FROM_DEVICE)
+#define PCI_DMA_NONE		(DMA_NONE)
 
 static inline void *
 pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-- 
1.8.3.1
