Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [Patch v3 23/36] parisc, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:32 +0800
Message-Id: <1433145945-789-24-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/parisc/kernel/irq.c |   12 ++++++------
 drivers/parisc/iosapic.c |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index f3191db6e2e9..413ec3c3f9cc 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -131,7 +131,7 @@ static int cpu_set_affinity_irq(struct irq_data *d, const struct cpumask *dest,
 	if (cpu_dest < 0)
 		return -1;
 
-	cpumask_copy(d->affinity, dest);
+	cpumask_copy(irq_data_get_affinity_mask(d), dest);
 
 	return 0;
 }
@@ -339,7 +339,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
 {
 #ifdef CONFIG_SMP
 	struct irq_data *d = irq_get_irq_data(irq);
-	cpumask_copy(d->affinity, cpumask_of(cpu));
+	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
 #endif
 
 	return per_cpu(cpu_data, cpu).txn_addr;
@@ -508,7 +508,7 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 	unsigned long eirr_val;
 	int irq, cpu = smp_processor_id();
 #ifdef CONFIG_SMP
-	struct irq_desc *desc;
+	struct irq_data *irq_data;
 	cpumask_t dest;
 #endif
 
@@ -522,9 +522,9 @@ void do_cpu_irq_mask(struct pt_regs *regs)
 	irq = eirr_to_irq(eirr_val);
 
 #ifdef CONFIG_SMP
-	desc = irq_to_desc(irq);
-	cpumask_copy(&dest, desc->irq_data.affinity);
-	if (irqd_is_per_cpu(&desc->irq_data) &&
+	irq_data = irq_get_irq_data(irq);
+	cpumask_copy(&dest, irq_data_get_affinity_mask(irq_data));
+	if (irqd_is_per_cpu(irq_data) &&
 	    !cpumask_test_cpu(smp_processor_id(), &dest)) {
 		int cpu = cpumask_first(&dest);
 
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 9ee04b4b68bf..144c77dfe4b1 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -691,7 +691,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
 	if (dest_cpu < 0)
 		return -1;
 
-	cpumask_copy(d->affinity, cpumask_of(dest_cpu));
+	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
 	vi->txn_addr = txn_affinity_addr(d->irq, dest_cpu);
 
 	spin_lock_irqsave(&iosapic_lock, flags);
-- 
1.7.10.4

