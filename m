Return-Path: <SRS0=ubAl=65=bombadil.srs.infradead.org=BATV+0f69485e8eba9f9d9296+5085+infradead.org+hch@kernel.org>
Return-Path: <SRS0=ubAl=65=bombadil.srs.infradead.org=BATV+0f69485e8eba9f9d9296+5085+infradead.org+hch@kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI/MSI: don't try to apply MSI(-X) affinity for single vectors
Date: Wed, 26 Jul 2017 22:17:41 +0200
Message-Id: <20170726201741.4842-1-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

We'll always get NULL back in that case, so skip the call and the
resulting warning.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 253d92409bb3..19653e5cb68f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -538,7 +538,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
 	struct msi_desc *entry;
 	u16 control;
 
-	if (affd) {
+	if (affd && nvec > 1) {
 		masks = irq_create_affinity_masks(nvec, affd);
 		if (!masks)
 			dev_err(&dev->dev, "can't allocate MSI affinity masks for %d vectors\n",
@@ -679,7 +679,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 	struct msi_desc *entry;
 	int ret, i;
 
-	if (affd) {
+	if (affd && nvec > 1) {
 		masks = irq_create_affinity_masks(nvec, affd);
 		if (!masks)
 			dev_err(&dev->dev, "can't allocate MSI-X affinity masks for %d vectors\n",
-- 
2.11.0
