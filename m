Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Eli Billauer <eli.billauer@gmail.com>
To: tj@kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 3/3] dma-mapping: pci: Add devm_ interface for pci_map_single
Date: Sat, 17 May 2014 15:22:25 +0300
Message-Id: <1400329345-15556-3-git-send-email-eli.billauer@gmail.com>
In-Reply-To: <1400329345-15556-1-git-send-email-eli.billauer@gmail.com>
References: <1400329345-15556-1-git-send-email-eli.billauer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 Documentation/driver-model/devres.txt |    2 ++
 include/asm-generic/pci-dma-compat.h  |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 2112a00..fea2c69 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -274,6 +274,8 @@ DMA
 PCI
   pcim_enable_device()	: after success, all PCI ops become managed
   pcim_pin_device()	: keep PCI device enabled after release
+  pcim_map_single()
+  pcim_unmap_single()
 
 IOMAP
   devm_ioport_map()
diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
index 1437b7d..444e598 100644
--- a/include/asm-generic/pci-dma-compat.h
+++ b/include/asm-generic/pci-dma-compat.h
@@ -113,4 +113,21 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 }
 #endif
 
+/*
+ * Managed DMA API
+ */
+
+static inline dma_addr_t
+pcim_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
+{
+	return dmam_map_single(hwdev == NULL ? NULL : &hwdev->dev, ptr, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pcim_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
+		 size_t size, int direction)
+{
+	dmam_unmap_single(hwdev == NULL ? NULL : &hwdev->dev, dma_addr, size, (enum dma_data_direction)direction);
+}
+
 #endif
-- 
1.7.2.3

