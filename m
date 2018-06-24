Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:38451 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeFXIfi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jun 2018 04:35:38 -0400
Message-Id: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 24 Jun 2018 10:35:18 +0200
Subject: [PATCH v2 1/2] genirq: Update code comments wrt recycled thread_mask
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously a race existed between __free_irq() and __setup_irq() wherein
the thread_mask of a just removed action could be handed out to a newly
added action and the freed irq thread would then tread on the oneshot
mask bit of the newly added irq thread in irq_finalize_oneshot():

time
 |  __free_irq()
 |    raw_spin_lock_irqsave(&desc->lock, flags);
 |    <remove action from linked list>
 |    raw_spin_unlock_irqrestore(&desc->lock, flags);
 |
 |  __setup_irq()
 |    raw_spin_lock_irqsave(&desc->lock, flags);
 |    <traverse linked list to determine oneshot mask bit>
 |    raw_spin_unlock_irqrestore(&desc->lock, flags);
 |
 |  irq_thread() of freed irq (__free_irq() waits in synchronize_irq())
 |    irq_thread_fn()
 |      irq_finalize_oneshot()
 |        raw_spin_lock_irq(&desc->lock);
 |        desc->threads_oneshot &= ~action->thread_mask;
 |        raw_spin_unlock_irq(&desc->lock);
 v

The race was known at least since 2012 when it was documented in a code
comment by commit e04268b0effc ("genirq: Remove paranoid warnons and
bogus fixups").

But it wasn't until 2017 that it was fixed by commit 9114014cf4e6
("genirq: Add mutex to irq desc to serialize request/free_irq()"),
apparently inadvertantly so because the race is neither mentioned in the
commit message nor was the code comment updated.  Make up for that.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 kernel/irq/manage.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 591cfe901162..123a227d3357 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1025,10 +1025,7 @@ static int irq_thread(void *data)
 	 * This is the regular exit path. __free_irq() is stopping the
 	 * thread via kthread_stop() after calling
 	 * synchronize_irq(). So neither IRQTF_RUNTHREAD nor the
-	 * oneshot mask bit can be set. We cannot verify that as we
-	 * cannot touch the oneshot mask at this point anymore as
-	 * __setup_irq() might have given out currents thread_mask
-	 * again.
+	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel(current, irq_thread_dtor);
 	return 0;
@@ -1245,7 +1242,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	/*
 	 * Protects against a concurrent __free_irq() call which might wait
 	 * for synchronize_irq() to complete without holding the optional
-	 * chip bus lock and desc->lock.
+	 * chip bus lock and desc->lock. Also protects against handing out
+	 * a recycled oneshot thread_mask bit while it's still in use by
+	 * its previous owner.
 	 */
 	mutex_lock(&desc->request_mutex);
 
-- 
2.17.1
