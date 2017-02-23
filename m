Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0084.outbound.protection.outlook.com ([104.47.41.84]:12905
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751165AbdBWGN2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Feb 2017 01:13:28 -0500
From: Himanshu Madhani <himanshu.madhani@cavium.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <himanshu.madhani@cavium.com>
Subject: [PATCH] PCI/MSI: Only disable affinity settings if pre and post vector count is equal to max_vecs and not min_vecs
Date: Wed, 22 Feb 2017 22:12:35 -0800
Message-ID: <1487830355-16963-1-git-send-email-himanshu.madhani@cavium.com>
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

Fixes: dfef358 ("PCI/MSI: Don't apply affinity if there aren't enough vectors left")
Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7f73bac..5823348 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1214,7 +1214,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		 * If there aren't any vectors left after applying the pre/post
 		 * vectors don't bother with assigning affinity.
 		 */
-		if (affd->pre_vectors + affd->post_vectors == min_vecs)
+		if (affd->pre_vectors + affd->post_vectors == max_vecs)
 			affd = NULL;
 	} else {
 		if (WARN_ON(affd))
-- 
1.8.3.1
