Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] frv: remove stray pci_{alloc,free}_consistent declaration
Date: Sun,  6 Mar 2016 16:15:38 +0100
Message-Id: <1457277340-8778-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/frv/include/asm/pci.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/frv/include/asm/pci.h b/arch/frv/include/asm/pci.h
index e43d22c..7e96b57 100644
--- a/arch/frv/include/asm/pci.h
+++ b/arch/frv/include/asm/pci.h
@@ -32,12 +32,6 @@ extern void consistent_sync_page(struct page *page, unsigned long offset,
 				 size_t size, int direction);
 #endif
 
-extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-				  dma_addr_t *dma_handle);
-
-extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
-				void *vaddr, dma_addr_t dma_handle);
-
 /* Return the index of the PCI controller for device PDEV. */
 #define pci_controller_num(PDEV)	(0)
 
-- 
2.1.4

