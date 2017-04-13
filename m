Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbdDMHHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2017 03:07:06 -0400
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] genirq: return the irq name from free_irq
Date: Thu, 13 Apr 2017 09:06:41 +0200
Message-Id: <20170413070643.32165-3-hch@lst.de>
In-Reply-To: <20170413070643.32165-1-hch@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This allows callers to get back at them instead of having to store
it in another variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/interrupt.h |  2 +-
 kernel/irq/manage.c       | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 53144e78a369..a6fba4804672 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -155,7 +155,7 @@ extern int __must_check
 request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *percpu_dev_id);
 
-extern void free_irq(unsigned int, void *);
+extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
 struct device;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 391cb738b2db..e688e7e06772 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1574,20 +1574,27 @@ EXPORT_SYMBOL_GPL(remove_irq);
  *	have completed.
  *
  *	This function must not be called from interrupt context.
+ *
+ *	Returns the devname argument passed to request_irq.
  */
-void free_irq(unsigned int irq, void *dev_id)
+const void *free_irq(unsigned int irq, void *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action;
+	const char *devname;
 
 	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		return;
+		return NULL;
 
 #ifdef CONFIG_SMP
 	if (WARN_ON(desc->affinity_notify))
 		desc->affinity_notify = NULL;
 #endif
 
-	kfree(__free_irq(irq, dev_id));
+	action = __free_irq(irq, dev_id);
+	devname = action->name;
+	kfree(action);
+	return devname;
 }
 EXPORT_SYMBOL(free_irq);
 
-- 
2.11.0
