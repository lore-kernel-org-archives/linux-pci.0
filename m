Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Subject: [RFT v2 19/48] genirq: Change prototypes of register_irq_proc() and friends
Date: Thu,  4 Jun 2015 12:13:29 +0800
Message-Id: <1433391238-19471-20-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change prototypes of register_irq_proc() and friends, so we either
passing 'irq' or 'irq_desc', but not both.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 kernel/irq/internals.h |   18 ++++++++++--------
 kernel/irq/irqdesc.c   |    2 +-
 kernel/irq/manage.c    |    8 ++++----
 kernel/irq/proc.c      |   16 ++++++++--------
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 3d274e2fe605..ed0388b754fa 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -94,16 +94,18 @@ bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
 #ifdef CONFIG_PROC_FS
-extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
-extern void unregister_irq_proc(unsigned int irq, struct irq_desc *desc);
-extern void register_handler_proc(unsigned int irq, struct irqaction *action);
-extern void unregister_handler_proc(unsigned int irq, struct irqaction *action);
+extern void register_irq_proc(struct irq_desc *desc);
+extern void unregister_irq_proc(struct irq_desc *desc);
+extern void register_handler_proc(struct irq_desc *desc,
+				  struct irqaction *action);
+extern void unregister_handler_proc(struct irq_desc *desc,
+				    struct irqaction *action);
 #else
-static inline void register_irq_proc(unsigned int irq, struct irq_desc *desc) { }
-static inline void unregister_irq_proc(unsigned int irq, struct irq_desc *desc) { }
-static inline void register_handler_proc(unsigned int irq,
+static inline void register_irq_proc(struct irq_desc *desc) { }
+static inline void unregister_irq_proc(struct irq_desc *desc) { }
+static inline void register_handler_proc(struct irq_desc *desc,
 					 struct irqaction *action) { }
-static inline void unregister_handler_proc(unsigned int irq,
+static inline void unregister_handler_proc(struct irq_desc *desc,
 					   struct irqaction *action) { }
 #endif
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 500e6fd11d78..969f7e252846 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -175,7 +175,7 @@ static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	unregister_irq_proc(irq, desc);
+	unregister_irq_proc(desc);
 
 	/*
 	 * sparse_irq_lock protects also show_interrupts() and
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 32567d4d7031..e478a0f25bd6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1293,9 +1293,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (new->thread)
 		wake_up_process(new->thread);
 
-	register_irq_proc(irq, desc);
+	register_irq_proc(desc);
 	new->dir = NULL;
-	register_handler_proc(irq, new);
+	register_handler_proc(desc, new);
 	free_cpumask_var(mask);
 
 	return 0;
@@ -1405,7 +1405,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	unregister_handler_proc(irq, action);
+	unregister_handler_proc(desc, action);
 
 	/* Make sure it's not being used on another CPU: */
 	synchronize_irq(irq);
@@ -1712,7 +1712,7 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	unregister_handler_proc(irq, action);
+	unregister_handler_proc(desc, action);
 
 	module_put(desc->owner);
 	return action;
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index e3a8c9577ba6..3e2514b47367 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -301,13 +301,12 @@ static int name_unique(unsigned int irq, struct irqaction *new_action)
 	return ret;
 }
 
-void register_handler_proc(unsigned int irq, struct irqaction *action)
+void register_handler_proc(struct irq_desc *desc, struct irqaction *action)
 {
 	char name [MAX_NAMELEN];
-	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (!desc->dir || action->dir || !action->name ||
-					!name_unique(irq, action))
+	    !name_unique(irq_desc_get_irq(desc), action))
 		return;
 
 	memset(name, 0, MAX_NAMELEN);
@@ -321,9 +320,10 @@ void register_handler_proc(unsigned int irq, struct irqaction *action)
 
 #define MAX_NAMELEN 10
 
-void register_irq_proc(unsigned int irq, struct irq_desc *desc)
+void register_irq_proc(struct irq_desc *desc)
 {
 	char name [MAX_NAMELEN];
+	unsigned int irq = irq_desc_get_irq(desc);
 
 	if (!root_irq_dir || (desc->irq_data.chip == &no_irq_chip) || desc->dir)
 		return;
@@ -357,7 +357,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 			 &irq_spurious_proc_fops, (void *)(long)irq);
 }
 
-void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
+void unregister_irq_proc(struct irq_desc *desc)
 {
 	char name [MAX_NAMELEN];
 
@@ -372,13 +372,13 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 	remove_proc_entry("spurious", desc->dir);
 
 	memset(name, 0, MAX_NAMELEN);
-	sprintf(name, "%u", irq);
+	sprintf(name, "%u", irq_desc_get_irq(desc));
 	remove_proc_entry(name, root_irq_dir);
 }
 
 #undef MAX_NAMELEN
 
-void unregister_handler_proc(unsigned int irq, struct irqaction *action)
+void unregister_handler_proc(struct irq_desc *desc, struct irqaction *action)
 {
 	proc_remove(action->dir);
 }
@@ -410,7 +410,7 @@ void init_irq_proc(void)
 		if (!desc)
 			continue;
 
-		register_irq_proc(irq, desc);
+		register_irq_proc(desc);
 	}
 }
 
-- 
1.7.10.4

