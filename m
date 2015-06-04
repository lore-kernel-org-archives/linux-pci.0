Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 35/48] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:45 +0800
Message-Id: <1433391238-19471-36-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h        |   16 ++++++++--------
 include/linux/irqdesc.h    |    4 ++--
 include/linux/irqhandler.h |    2 +-
 kernel/irq/chip.c          |   22 ++++++++--------------
 kernel/irq/handle.c        |    4 ++--
 kernel/irq/irqdesc.c       |    2 +-
 6 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index ab6dca4ad968..3caa4e91cfe5 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -461,14 +461,14 @@ static inline int irq_set_parent(int irq, int parent_irq)
  * Built-in IRQ handlers for various IRQ types,
  * callable via desc->handle_irq()
  */
-extern void handle_level_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_edge_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_edge_eoi_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_simple_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_percpu_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc);
-extern void handle_bad_irq(unsigned int irq, struct irq_desc *desc);
+extern void handle_level_irq(struct irq_desc *desc);
+extern void handle_fasteoi_irq(struct irq_desc *desc);
+extern void handle_edge_irq(struct irq_desc *desc);
+extern void handle_edge_eoi_irq(struct irq_desc *desc);
+extern void handle_simple_irq(struct irq_desc *desc);
+extern void handle_percpu_irq(struct irq_desc *desc);
+extern void handle_percpu_devid_irq(struct irq_desc *desc);
+extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a7aaef44a10e..2d8463121f07 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -136,9 +136,9 @@ static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
  * irqchip-style controller then we call the ->handle_irq() handler,
  * and it calls __do_IRQ() if it's attached to an irqtype-style controller.
  */
-static inline void generic_handle_irq_desc(unsigned int irq, struct irq_desc *desc)
+static inline void generic_handle_irq_desc(struct irq_desc *desc)
 {
-	desc->handle_irq(irq, desc);
+	desc->handle_irq(desc);
 }
 
 int generic_handle_irq(unsigned int irq);
diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index 62d543004197..661bed0ed1f3 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -8,7 +8,7 @@
 
 struct irq_desc;
 struct irq_data;
-typedef	void (*irq_flow_handler_t)(unsigned int irq, struct irq_desc *desc);
+typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
 typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
 
 #endif
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 048698045dad..3c51483ce9d8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -372,7 +372,6 @@ static bool irq_may_run(struct irq_desc *desc)
 
 /**
  *	handle_simple_irq - Simple and software-decoded IRQs.
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  *	Simple interrupts are either sent from a demultiplexing interrupt
@@ -383,7 +382,7 @@ static bool irq_may_run(struct irq_desc *desc)
  *	unmask issues if necessary.
  */
 void
-handle_simple_irq(unsigned int irq, struct irq_desc *desc)
+handle_simple_irq(struct irq_desc *desc)
 {
 	raw_spin_lock(&desc->lock);
 
@@ -425,7 +424,6 @@ static void cond_unmask_irq(struct irq_desc *desc)
 
 /**
  *	handle_level_irq - Level type irq handler
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  *	Level type interrupts are active as long as the hardware line has
@@ -434,7 +432,7 @@ static void cond_unmask_irq(struct irq_desc *desc)
  *	interrupt line is back to inactive.
  */
 void
-handle_level_irq(unsigned int irq, struct irq_desc *desc)
+handle_level_irq(struct irq_desc *desc)
 {
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
@@ -496,7 +494,6 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 
 /**
  *	handle_fasteoi_irq - irq handler for transparent controllers
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  *	Only a single callback will be issued to the chip: an ->eoi()
@@ -505,7 +502,7 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
  *	details in hardware, transparently.
  */
 void
-handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
+handle_fasteoi_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
@@ -546,7 +543,6 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 
 /**
  *	handle_edge_irq - edge type IRQ handler
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  *	Interrupt occures on the falling and/or rising edge of a hardware
@@ -561,7 +557,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
  *	loop is left.
  */
 void
-handle_edge_irq(unsigned int irq, struct irq_desc *desc)
+handle_edge_irq(struct irq_desc *desc)
 {
 	raw_spin_lock(&desc->lock);
 
@@ -618,13 +614,12 @@ EXPORT_SYMBOL(handle_edge_irq);
 #ifdef CONFIG_IRQ_EDGE_EOI_HANDLER
 /**
  *	handle_edge_eoi_irq - edge eoi type IRQ handler
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  * Similar as the above handle_edge_irq, but using eoi and w/o the
  * mask/unmask logic.
  */
-void handle_edge_eoi_irq(unsigned int irq, struct irq_desc *desc)
+void handle_edge_eoi_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -665,13 +660,12 @@ out_eoi:
 
 /**
  *	handle_percpu_irq - Per CPU local irq handler
- *	@irq:	the interrupt number
  *	@desc:	the interrupt description structure for this irq
  *
  *	Per CPU interrupts on SMP machines without locking requirements
  */
 void
-handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
+handle_percpu_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -688,7 +682,6 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
 
 /**
  * handle_percpu_devid_irq - Per CPU local irq handler with per cpu dev ids
- * @irq:	the interrupt number
  * @desc:	the interrupt description structure for this irq
  *
  * Per CPU interrupts on SMP machines without locking requirements. Same as
@@ -698,11 +691,12 @@ handle_percpu_irq(unsigned int irq, struct irq_desc *desc)
  * contain the real device id for the cpu on which this handler is
  * called
  */
-void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
+void handle_percpu_devid_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	void *dev_id = raw_cpu_ptr(action->percpu_dev_id);
+	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
 	kstat_incr_irqs_this_cpu(desc);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index b6eeea8a80c5..6feab10c26a7 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -22,13 +22,13 @@
 
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
- * @irq:       the interrupt number
  * @desc:      description of the interrupt
  *
  * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
  */
-void handle_bad_irq(unsigned int irq, struct irq_desc *desc)
+void handle_bad_irq(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	print_irq_desc(irq, desc);
 	kstat_incr_irqs_this_cpu(desc);
 	ack_bad_irq(irq);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 969f7e252846..2a84d5532d80 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -347,7 +347,7 @@ int generic_handle_irq(unsigned int irq)
 
 	if (!desc)
 		return -EINVAL;
-	generic_handle_irq_desc(irq, desc);
+	generic_handle_irq_desc(desc);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
-- 
1.7.10.4

