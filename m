Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org
Cc: agordeev@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pci: switch msix_program_entries to use pci_msix_desc_addr
Date: Tue, 12 Jul 2016 18:20:15 +0900
Message-Id: <1468315218-20490-3-git-send-email-hch@lst.de>
In-Reply-To: <1468315218-20490-1-git-send-email-hch@lst.de>
References: <1468315218-20490-1-git-send-email-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of relying on the msix_entry structure for the vector number read
it from the msi_desc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0d94fbf..a385f39 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -713,11 +713,9 @@ static void msix_program_entries(struct pci_dev *dev,
 	int i = 0;
 
 	for_each_pci_msi_entry(entry, dev) {
-		int offset = entries[i].entry * PCI_MSIX_ENTRY_SIZE +
-						PCI_MSIX_ENTRY_VECTOR_CTRL;
-
 		entries[i].vector = entry->irq;
-		entry->masked = readl(entry->mask_base + offset);
+		entry->masked = readl(pci_msix_desc_addr(entry) +
+				PCI_MSIX_ENTRY_VECTOR_CTRL);
 		msix_mask_irq(entry, 1);
 		i++;
 	}
-- 
2.1.4
