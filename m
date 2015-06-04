Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Christoph Lameter <cl@linux.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, lguest@lists.ozlabs.org
Subject: [RFT v2 41/48] genirq, x86: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:51 +0800
Message-Id: <1433391238-19471-42-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/irq_32.c |   13 ++++++-------
 arch/x86/kernel/irq_64.c |    2 +-
 arch/x86/lguest/boot.c   |    2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index cd74f5978ab9..9bf5cccefebd 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -69,10 +69,10 @@ static inline void *current_stack(void)
 }
 
 static inline int
-execute_on_irq_stack(int overflow, struct irq_desc *desc, int irq)
+execute_on_irq_stack(int overflow, struct irq_desc *desc)
 {
 	struct irq_stack *curstk, *irqstk;
-	u32 *isp, *prev_esp, arg1, arg2;
+	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
 	irqstk = __this_cpu_read(hardirq_stack);
@@ -98,9 +98,8 @@ execute_on_irq_stack(int overflow, struct irq_desc *desc, int irq)
 	asm volatile("xchgl	%%ebx,%%esp	\n"
 		     "call	*%%edi		\n"
 		     "movl	%%ebx,%%esp	\n"
-		     : "=a" (arg1), "=d" (arg2), "=b" (isp)
-		     :  "0" (irq),   "1" (desc),  "2" (isp),
-			"D" (desc->handle_irq)
+		     : "=a" (arg1), "=b" (isp)
+		     :  "0" (desc), "1" (isp), "D" (desc->handle_irq)
 		     : "memory", "cc", "ecx");
 	return 1;
 }
@@ -159,10 +158,10 @@ bool handle_irq(unsigned irq, struct pt_regs *regs)
 	if (unlikely(!desc))
 		return false;
 
-	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc, irq)) {
+	if (user_mode(regs) || !execute_on_irq_stack(overflow, desc)) {
 		if (unlikely(overflow))
 			print_stack_overflow();
-		desc->handle_irq(irq, desc);
+		desc->handle_irq(desc);
 	}
 
 	return true;
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index bc4604e500a3..eca6d5e3ad25 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -78,6 +78,6 @@ bool handle_irq(unsigned irq, struct pt_regs *regs)
 	if (unlikely(!desc))
 		return false;
 
-	generic_handle_irq_desc(irq, desc);
+	generic_handle_irq_desc(desc);
 	return true;
 }
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index cab9aaa7802c..24efba1c1f3d 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1021,7 +1021,7 @@ static struct clock_event_device lguest_clockevent = {
  * This is the Guest timer interrupt handler (hardware interrupt 0).  We just
  * call the clockevent infrastructure and it does whatever needs doing.
  */
-static void lguest_time_irq(unsigned int irq, struct irq_desc *desc)
+static void lguest_time_irq(struct irq_desc *desc)
 {
 	unsigned long flags;
 
-- 
1.7.10.4

