Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com ([104.47.41.88]:2382
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751207AbdBWVC6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 16:02:58 -0500
From: Himanshu Madhani <himanshu.madhani@cavium.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <hch@lst.de>
CC: <himanshu.madhani@cavium.com>
Subject: [PATCH] PCI/MSI: Only disable affinity settings if pre and post vector count is equal to max_vecs and not min_vecs
Date: Thu, 23 Feb 2017 13:01:39 -0800
Message-ID: <1487883699-3528-1-git-send-email-himanshu.madhani@cavium.com>
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

v1 --> v2

o Moved the check from pci_alloc_irq_vectors_affinity() to
  __pci_enable_{msi|msix}_range()

Fixes: dfef358 ("PCI/MSI: Don't apply affinity if there aren't enough vectors left")
Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/msi.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7f73bac..c61039b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1091,6 +1091,17 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affd) {
+			if (affd->pre_vectors + affd->post_vectors > nvec)
+				return -EINVAL;
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
@@ -1138,6 +1149,17 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affd) {
+			if (affd->pre_vectors + affd->post_vectors > nvec)
+				return -EINVAL;
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
@@ -1206,16 +1228,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
 			affd = &msi_default_affd;
-
-		if (affd->pre_vectors + affd->post_vectors > min_vecs)
-			return -EINVAL;
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
