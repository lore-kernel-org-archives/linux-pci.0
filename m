Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:49530 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbFIOrh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 10:47:37 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v3 14/18] NTB: Use NUMA memory in Intel driver
Date: Tue,  9 Jun 2015 05:44:41 -0400
Message-Id: <28dee49b012e53823387291f4ad0084b99ff8244.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allocate memory for the numa node of the ntb device.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index bef94a8bab96..a7f1b01cfdb3 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -413,10 +413,12 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 			 int msix_shift, int total_shift)
 {
 	struct pci_dev *pdev;
-	int rc, i, msix_count;
+	int rc, i, msix_count, node;
 
 	pdev = ndev_pdev(ndev);
 
+	node = dev_to_node(&pdev->dev);
+
 	/* Mask all doorbell interrupts */
 	ndev->db_mask = ndev->db_valid_mask;
 	ndev->reg->db_iowrite(ndev->db_mask,
@@ -425,11 +427,13 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
 
 	/* Try to set up msix irq */
 
-	ndev->vec = kcalloc(msix_max, sizeof(*ndev->vec), GFP_KERNEL);
+	ndev->vec = kzalloc_node(msix_max * sizeof(*ndev->vec),
+				 GFP_KERNEL, node);
 	if (!ndev->vec)
 		goto err_msix_vec_alloc;
 
-	ndev->msix = kcalloc(msix_max, sizeof(*ndev->msix), GFP_KERNEL);
+	ndev->msix = kzalloc_node(msix_max * sizeof(*ndev->msix),
+				  GFP_KERNEL, node);
 	if (!ndev->msix)
 		goto err_msix_alloc;
 
@@ -1960,10 +1964,12 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	struct intel_ntb_dev *ndev;
-	int rc;
+	int rc, node;
+
+	node = dev_to_node(&pdev->dev);
 
 	if (pdev_is_bwd(pdev)) {
-		ndev = kmalloc(sizeof(*ndev), GFP_KERNEL);
+		ndev = kmalloc_node(sizeof(*ndev), GFP_KERNEL, node);
 		if (!ndev) {
 			rc = -ENOMEM;
 			goto err_ndev;
@@ -1980,7 +1986,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 			goto err_init_dev;
 
 	} else if (pdev_is_snb(pdev)) {
-		ndev = kmalloc(sizeof(*ndev), GFP_KERNEL);
+		ndev = kmalloc_node(sizeof(*ndev), GFP_KERNEL, node);
 		if (!ndev) {
 			rc = -ENOMEM;
 			goto err_ndev;
-- 
2.4.0.rc0.43.gcf8a8c6

