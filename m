Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37914 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbcFNT71 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 15:59:27 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] irq/msi: Make use of affinity aware allocations
Date: Tue, 14 Jun 2016 21:58:58 +0200
Message-Id: <1465934346-20648-6-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Allow the MSI code to provide affinity hints per MSI descriptor.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h | 2 ++
 kernel/irq/msi.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index c33abfa..4f0bfe5 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,6 +47,7 @@ struct fsl_mc_msi_desc {
  * @nvec_used:	The number of vectors used
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
+ * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
  *
  * @masked:	[PCI MSI/X] Mask bits
  * @is_msix:	[PCI MSI/X] True if MSI-X
@@ -67,6 +68,7 @@ struct msi_desc {
 	unsigned int			nvec_used;
 	struct device			*dev;
 	struct msi_msg			msg;
+	const struct cpumask		*affinity;
 
 	union {
 		/* PCI MSI/X specific data */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 58dbbac..0e2a736 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -335,7 +335,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
-					       NULL);
+					       desc->affinity);
 		if (virq < 0) {
 			ret = -ENOSPC;
 			if (ops->handle_error)
-- 
2.1.4

