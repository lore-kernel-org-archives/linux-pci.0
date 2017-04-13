Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] genirq: fix indentation in remove_irq
Date: Thu, 13 Apr 2017 09:06:40 +0200
Message-Id: <20170413070643.32165-2-hch@lst.de>
In-Reply-To: <20170413070643.32165-1-hch@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a4afe5cc5af1..391cb738b2db 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1557,7 +1557,7 @@ void remove_irq(unsigned int irq, struct irqaction *act)
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc && !WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-	    __free_irq(irq, act->dev_id);
+		__free_irq(irq, act->dev_id);
 }
 EXPORT_SYMBOL_GPL(remove_irq);
 
-- 
2.11.0
