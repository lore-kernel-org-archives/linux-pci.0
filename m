Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936121AbdGTX17 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 19:27:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] vmd: Reserve IRQ pre-vector for better affinity
Date: Thu, 20 Jul 2017 19:33:53 -0400
Message-Id: <1500593634-4558-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver has a special purpose for the vmd device's first, so this
one shouldn't be considered for irq affinity.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/host/vmd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index e27ad2a..8cddf30 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -662,6 +662,14 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int i, err;
 
+	/*
+	 * The first vector is reserved for special use, so start affinity at
+	 * the second vector
+	 */
+	struct irq_affinity affd = {
+		.pre_vectors = 1,
+	};
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
@@ -687,8 +695,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
+					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
-- 
2.5.5
