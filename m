Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37788 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbcFNT7P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 15:59:15 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] irq/msi: Remove unused MSI_FLAG_IDENTITY_MAP
Date: Tue, 14 Jun 2016 21:58:54 +0200
Message-Id: <1465934346-20648-2-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

No user and we definitely don't want to grow one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h | 6 ++----
 kernel/irq/msi.c    | 8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8b425c6..c33abfa 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -264,12 +264,10 @@ enum {
 	 * callbacks.
 	 */
 	MSI_FLAG_USE_DEF_CHIP_OPS	= (1 << 1),
-	/* Build identity map between hwirq and irq */
-	MSI_FLAG_IDENTITY_MAP		= (1 << 2),
 	/* Support multiple PCI MSI interrupts */
-	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
+	MSI_FLAG_MULTI_PCI_MSI		= (1 << 2),
 	/* Support PCI MSIX interrupts */
-	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	MSI_FLAG_PCI_MSIX		= (1 << 3),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 38e89ce..eb5bf2b 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -324,7 +324,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct msi_domain_ops *ops = info->ops;
 	msi_alloc_info_t arg;
 	struct msi_desc *desc;
-	int i, ret, virq = -1;
+	int i, ret, virq;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
@@ -332,12 +332,8 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 	for_each_msi_entry(desc, dev) {
 		ops->set_desc(&arg, desc);
-		if (info->flags & MSI_FLAG_IDENTITY_MAP)
-			virq = (int)ops->get_hwirq(info, &arg);
-		else
-			virq = -1;
 
-		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
+		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false);
 		if (virq < 0) {
 			ret = -ENOSPC;
-- 
2.1.4

