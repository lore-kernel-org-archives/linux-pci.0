Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 17/48] genirq: Kill the parameter 'irq' of check_irq_resend()
Date: Thu,  4 Jun 2015 12:13:27 +0800
Message-Id: <1433391238-19471-18-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify interrupt management interfaces by killing the parameter 'irq'
of check_irq_resend().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 kernel/irq/chip.c      |    2 +-
 kernel/irq/internals.h |    2 +-
 kernel/irq/manage.c    |    2 +-
 kernel/irq/resend.c    |    4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index fc7545ca6bf7..7fe80d2fcc6c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -187,7 +187,7 @@ int irq_startup(struct irq_desc *desc, bool resend)
 		irq_enable(desc);
 	}
 	if (resend)
-		check_irq_resend(desc, desc->irq_data.irq);
+		check_irq_resend(desc);
 	return ret;
 }
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index d6f65336650c..ca2ca5531be6 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -90,7 +90,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *act
 irqreturn_t handle_irq_event(struct irq_desc *desc);
 
 /* Resending of interrupts :*/
-void check_irq_resend(struct irq_desc *desc, unsigned int irq);
+void check_irq_resend(struct irq_desc *desc);
 bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e7688140bfb6..379a1d60c4f4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -516,7 +516,7 @@ void __enable_irq(struct irq_desc *desc, unsigned int irq)
 		/* Prevent probing on this irq: */
 		irq_settings_set_noprobe(desc);
 		irq_enable(desc);
-		check_irq_resend(desc, irq);
+		check_irq_resend(desc);
 		/* fall-through */
 	}
 	default:
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 9065107f083e..32fc47c2c622 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -53,7 +53,7 @@ static DECLARE_TASKLET(resend_tasklet, resend_irqs, 0);
  *
  * Is called with interrupts disabled and desc->lock held.
  */
-void check_irq_resend(struct irq_desc *desc, unsigned int irq)
+void check_irq_resend(struct irq_desc *desc)
 {
 	/*
 	 * We do not resend level type interrupts. Level type
@@ -74,6 +74,8 @@ void check_irq_resend(struct irq_desc *desc, unsigned int irq)
 		if (!desc->irq_data.chip->irq_retrigger ||
 		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data)) {
 #ifdef CONFIG_HARDIRQS_SW_RESEND
+			unsigned int irq = irq_desc_get_irq(desc);
+
 			/*
 			 * If the interrupt has a parent irq and runs
 			 * in the thread context of the parent irq,
-- 
1.7.10.4

