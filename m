Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48871 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcDPBf4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2016 21:35:56 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] genirq: add a helper to program the pre-set affinity mask into the controller
Date: Fri, 15 Apr 2016 18:35:48 -0700
Message-Id: <1460770552-31260-5-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/interrupt.h |  2 ++
 kernel/irq/manage.c       | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 67bc1e1f..ae345da 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -713,4 +713,6 @@ extern char __softirqentry_text_end[];
 #define __softirq_entry
 #endif
 
+void irq_program_affinity(unsigned int irq);
+
 #endif
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index cc1cc64..02552a4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -240,6 +240,20 @@ int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 	return ret;
 }
 
+void irq_program_affinity(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(!desc))
+		return;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	irq_set_affinity_locked(data, desc->irq_common_data.affinity, false);
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
 int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 {
 	unsigned long flags;
-- 
2.1.4

