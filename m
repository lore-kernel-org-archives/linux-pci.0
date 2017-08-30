Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26011 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbdH3QJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 12:09:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] vmd: Remove IRQ affinity
Date: Wed, 30 Aug 2017 12:15:04 -0400
Message-Id: <1504109704-17033-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VMD hardware has to share its vectors among child devices in its PCI
domain so we should allocate as many as possible rather than just ones
that can be affinitized.

Reported-by: Brad Goodman <Bradley.Goodman@dell.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/host/vmd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 4fe1756..509893b 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -671,14 +671,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int i, err;
 
-	/*
-	 * The first vector is reserved for special use, so start affinity at
-	 * the second vector
-	 */
-	struct irq_affinity affd = {
-		.pre_vectors = 1,
-	};
-
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
@@ -704,8 +696,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
+	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
+					PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
-- 
2.5.5
