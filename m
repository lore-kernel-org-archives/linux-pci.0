Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:53336 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbdJEAxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2017 20:53:51 -0400
Received: by mail-pg0-f43.google.com with SMTP id y192so72976pgd.10
        for <linux-pci@vger.kernel.org>; Wed, 04 Oct 2017 17:53:50 -0700 (PDT)
Date: Wed, 4 Oct 2017 17:53:48 -0700
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] pci/ehp_hpc: Convert timers to use timer_setup()
Message-ID: <20171005005348.GA23838@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. This fixes what appears to be a bug
in passing the wrong pointer to the timer handler (address of ctrl pointer
instead of ctrl pointer).

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mayurkumar Patel <mayurkumar.patel@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 drivers/pci/hotplug/pciehp_hpc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e5d5ce9e3010..ba5055c5115c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -50,14 +50,13 @@ static irqreturn_t pcie_isr(int irq, void *dev_id);
 static void start_int_poll_timer(struct controller *ctrl, int sec);
 
 /* This is the interrupt polling timeout function. */
-static void int_poll_timeout(unsigned long data)
+static void int_poll_timeout(struct timer_list *t)
 {
-	struct controller *ctrl = (struct controller *)data;
+	struct controller *ctrl = from_timer(ctrl, t, poll_timer);
 
 	/* Poll for interrupt events.  regs == NULL => polling */
 	pcie_isr(0, ctrl);
 
-	init_timer(&ctrl->poll_timer);
 	if (!pciehp_poll_time)
 		pciehp_poll_time = 2; /* default polling interval is 2 sec */
 
@@ -71,8 +70,6 @@ static void start_int_poll_timer(struct controller *ctrl, int sec)
 	if ((sec <= 0) || (sec > 60))
 		sec = 2;
 
-	ctrl->poll_timer.function = &int_poll_timeout;
-	ctrl->poll_timer.data = (unsigned long)ctrl;
 	ctrl->poll_timer.expires = jiffies + sec * HZ;
 	add_timer(&ctrl->poll_timer);
 }
@@ -83,7 +80,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 
 	/* Install interrupt polling timer. Start with 10 sec delay */
 	if (pciehp_poll_mode) {
-		init_timer(&ctrl->poll_timer);
+		timer_setup(&ctrl->poll_timer, int_poll_timeout, 0);
 		start_int_poll_timer(ctrl, 10);
 		return 0;
 	}
@@ -764,8 +761,7 @@ int pciehp_reset_slot(struct slot *slot, int probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 	if (pciehp_poll_mode)
-		int_poll_timeout(ctrl->poll_timer.data);
-
+		int_poll_timeout(&ctrl->poll_timer);
 	return 0;
 }
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
