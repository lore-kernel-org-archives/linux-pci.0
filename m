Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:61903
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752865AbdCAXdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Mar 2017 18:33:53 -0500
From: Himanshu Madhani <himanshu.madhani@cavium.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <hch@lst.de>
CC: <himanshu.madhani@cavium.com>
Subject: [PATCH] PCI/MSI: Only disable affinity settings if pre and post vector count is equal to max_vecs and not min_vecs
Date: Wed, 1 Mar 2017 15:31:58 -0800
Message-ID: <20170301233158.1035-1-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael Hernandez <michael.hernandez@cavium.com>

min_vecs is the minimum amount of vectors needed to operate in MSI-X mode
which may just include the vectors that don't need affinity.

Disabling affinity settings causes the qla2xxx driver scsi_add_host
to fail when blk_mq is enabled as the blk_mq_pci_map_queues expects
affinity masks on each vector.

v2 --> v3
o fixed code as per review comments.

v1 --> v2

o Moved the check from pci_alloc_irq_vectors_affinity() to
  __pci_enable_{msi|msix}_range()

Fixes: dfef358 ("PCI/MSI: Don't apply affinity if there aren't enough vectors left")
Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/msi.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7f73bac..46c0cdd 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1091,6 +1091,15 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affd) {
+			/*
+			 * If there aren't any vectors left after applying the
+			 * pre/post vectors don't bother with assigning
+			 * affinity.
+			 */
+			if (affd->pre_vectors + affd->post_vectors == nvec)
+				affd = NULL;
+		}
+		if (affd) {
 			nvec = irq_calc_affinity_vectors(nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
@@ -1138,6 +1147,15 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affd) {
+			/*
+			 * If there aren't any vectors left after applying the
+			 * pre/post vectors don't bother with assigning
+			 * affinity.
+			 */
+			if (affd->pre_vectors + affd->post_vectors == nvec)
+				affd = NULL;
+		}
+		if (affd) {
 			nvec = irq_calc_affinity_vectors(nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
@@ -1209,13 +1227,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 
 		if (affd->pre_vectors + affd->post_vectors > min_vecs)
 			return -EINVAL;
-
-		/*
-		 * If there aren't any vectors left after applying the pre/post
-		 * vectors don't bother with assigning affinity.
-		 */
-		if (affd->pre_vectors + affd->post_vectors == min_vecs)
-			affd = NULL;
 	} else {
 		if (WARN_ON(affd))
 			affd = NULL;
-- 
1.7.1
