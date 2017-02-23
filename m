Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdBWKbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2017 05:31:08 -0500
Date: Thu, 23 Feb 2017 02:30:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Message-ID: <20170223103051.GA23982@infradead.org>
References: <1487830355-16963-1-git-send-email-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487830355-16963-1-git-send-email-himanshu.madhani@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2017 at 10:12:35PM -0800, Himanshu Madhani wrote:
> From: Michael Hernandez <michael.hernandez@cavium.com>
> 
> min_vecs is the minimum amount of vectors needed to operate in MSI-X mode
> which may just include the vectors that don't need affinity.
> 
> Disabling affinity settings causes the qla2xxx driver scsi_add_host
> to fail when blk_mq is enabled as the blk_mq_pci_map_queues expects
> affinity masks on each vector.

I don't think this is correct either.  We'll need to move these checks
into __pci_enable_msix_range instead I think so that they operate
on the actual number of vectors not the min/max ones.

Something like the untested patch below, which will also need a MSI
version of the check, and possibly a bit of cleanup:


diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7f73bacf13ed..6d11c4f620f3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1138,6 +1138,18 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affd) {
+			if (affd->pre_vectors + affd->post_vectors > nvec)
+				return -EINVAL;
+
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
@@ -1206,16 +1218,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
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
