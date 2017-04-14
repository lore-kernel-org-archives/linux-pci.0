Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42747 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbdDNR2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2017 13:28:47 -0400
Date: Fri, 14 Apr 2017 19:28:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] genirq: return the irq name from free_irq
In-Reply-To: <20170413070643.32165-3-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1704141920560.2327@nanos>
References: <20170413070643.32165-1-hch@lst.de> <20170413070643.32165-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 13 Apr 2017, Christoph Hellwig wrote:

> This allows callers to get back at them instead of having to store
> it in another variable.

Alternatively you tell the irq code to free it for you. Patch below.

Thanks,

	tglx

8<-----------------------

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -60,7 +60,9 @@
  * IRQF_COND_SUSPEND - If the IRQ is shared with a NO_SUSPEND user, execute this
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
- *                their interrupt handlers.
+ *                their interrupt handlers
+ * IRQF_FREE_NAME - Free the memory pointed to by the @name argument of
+ *		    request_irq() in free_irq()
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -74,6 +76,7 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
+#define IRQF_FREE_NAME		0x00080000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1542,6 +1542,8 @@ static struct irqaction *__free_irq(unsi
 	irq_chip_pm_put(&desc->irq_data);
 	module_put(desc->owner);
 	kfree(action->secondary);
+	if (action->flags & IRQF_FREE_NAME)
+		kfree(action->name);
 	return action;
 }
 
