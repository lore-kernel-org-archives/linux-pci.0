Return-Path: <SRS0=Gasj=PG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE696C43612
	for <linux-pci@archiver.kernel.org>; Sat, 29 Dec 2018 04:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9755721905
	for <linux-pci@archiver.kernel.org>; Sat, 29 Dec 2018 04:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeL2Ep1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbeL2Ep1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Dec 2018 23:45:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A274183F4C;
        Sat, 29 Dec 2018 03:27:06 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99E51608C7;
        Sat, 29 Dec 2018 03:27:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from pci_alloc_irq_vectors_affinity
Date:   Sat, 29 Dec 2018 11:26:48 +0800
Message-Id: <20181229032650.27256-2-ming.lei@redhat.com>
In-Reply-To: <20181229032650.27256-1-ming.lei@redhat.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sat, 29 Dec 2018 03:27:06 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
if leass than @min_vecs interrupt vectors are available for @dev.

However, this way may be changed by falling back to
__pci_enable_msi_range(), for example, if the device isn't capable of
MSI, __pci_enable_msi_range() will return -EINVAL, and finally it is
returned to users of pci_alloc_irq_vectors_affinity() even though
there are quite MSIX vectors available. This way violates the interface.

Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
vectors and allocate vectors again in case that -ENOSPC is returned, such
as NVMe, so we need to respect the current interface and give preference to
-ENOSPC.

Cc: Jens Axboe <axboe@fb.com>,
Cc: Keith Busch <keith.busch@intel.com>,
Cc: linux-pci@vger.kernel.org,
Cc: Bjorn Helgaas <bhelgaas@google.com>,
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/pci/msi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..91b4f03fee91 100644
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
@@ -1199,7 +1201,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	return vecs;
+	return msix_vecs == -ENOSPC ? msix_vecs : msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
-- 
2.9.5

