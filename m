Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbcKIBPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2016 20:15:43 -0500
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] genirq/affinity: Introduce struct irq_affinity
Date: Tue,  8 Nov 2016 17:15:01 -0800
Message-Id: <1478654107-7384-2-git-send-email-hch@lst.de>
In-Reply-To: <1478654107-7384-1-git-send-email-hch@lst.de>
References: <1478654107-7384-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some drivers (various network and RDMA adapter for example) have a MSI-X
vector layout where most of the vectors are used for I/O queues and should
have CPU affinity assigned to them, but some (usually 1 but sometimes more)
at the beginning or end are used for low-performance admin or configuration
work and should not have any explicit affinity assigned to them.

This adds a new irq_affinity structure, which will be passed through a
variant of pci_irq_alloc_vectors that allows to specify these
requirements (and is extensible to any future quirks in that area) so that
the core IRQ affinity algorithm can take this quirks into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 include/linux/interrupt.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 72f0721..6b52686 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -232,6 +232,18 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+/**
+ * struct irq_affinity - Description for automatic irq affinity assignements
+ * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
+ *			the MSI(-X) vector space
+ * @post_vectors:	Don't apply affinity to @post_vectors at end of
+ *			the MSI(-X) vector space
+ */
+struct irq_affinity {
+	int	pre_vectors;
+	int	post_vectors;
+};
+
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
-- 
2.1.4

