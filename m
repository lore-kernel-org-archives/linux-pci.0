Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71571C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 01:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA620815
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 01:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfACBbT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:31:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfACBbT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jan 2019 20:31:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE7E07BDA5;
        Thu,  3 Jan 2019 01:31:18 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2C1660C47;
        Thu,  3 Jan 2019 01:31:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] PCI/MSI: preference to returning -ENOSPC from pci_alloc_irq_vectors_affinity
Date:   Thu,  3 Jan 2019 09:31:06 +0800
Message-Id: <20190103013106.26452-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 03 Jan 2019 01:31:19 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
if fewer than @min_vecs interrupt vectors are available for @dev.

However, if a device supports MSI-X but not MSI and a caller requests
@min_vecs that can't be satisfied by MSI-X, we previously returned
-EINVAL (from the failed attempt to enable MSI), not -ENOSPC.

Users of pci_alloc_irq_vectors_affinity() may try to reduce irq vectors
and allocate vectors again in case that -ENOSPC is returned, such as NVMe,
so we need to respect the current interface and give preference to -ENOSPC.

Especially the min/max vecs doesn't work correctly when using the
irq_affinity nr_sets because rebalancing the set counts is driver specific.
To get around that, drivers using nr_sets have to set min and max to the same
value and handle the "reduce and try again".

Cc: Jens Axboe <axboe@fb.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/pci/msi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..4c0b47867258 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1168,7 +1168,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   const struct irq_affinity *affd)
 {
 	static const struct irq_affinity msi_default_affd;
-	int vecs = -ENOSPC;
+	int msix_vecs = -ENOSPC;
+	int msi_vecs = -ENOSPC;
 
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
@@ -1179,16 +1180,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
-		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-				affd);
-		if (vecs > 0)
-			return vecs;
+		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
+						    max_vecs, affd);
+		if (msix_vecs > 0)
+			return msix_vecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
-		if (vecs > 0)
-			return vecs;
+		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
+						  affd);
+		if (msi_vecs > 0)
+			return msi_vecs;
 	}
 
 	/* use legacy irq if allowed */
@@ -1199,7 +1201,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	return vecs;
+	if (msix_vecs == -ENOSPC)
+		return -ENOSPC;
+	return msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
-- 
2.9.5

