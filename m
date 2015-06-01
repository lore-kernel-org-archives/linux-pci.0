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
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [Patch v3 25/36] sh, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:34 +0800
Message-Id: <1433145945-789-26-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sh/kernel/irq.c   |    7 ++++---
 drivers/sh/intc/chip.c |    6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 8dc677cc136b..6c0378c0b8b5 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -228,15 +228,16 @@ void migrate_irqs(void)
 		struct irq_data *data = irq_get_irq_data(irq);
 
 		if (irq_data_get_node(data) == cpu) {
-			unsigned int newcpu = cpumask_any_and(data->affinity,
+			struct cpumask *mask = irq_data_get_affinity_mask(data);
+			unsigned int newcpu = cpumask_any_and(mask,
 							      cpu_online_mask);
 			if (newcpu >= nr_cpu_ids) {
 				pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 						    irq, cpu);
 
-				cpumask_setall(data->affinity);
+				cpumask_setall(mask);
 			}
-			irq_set_affinity(irq, data->affinity);
+			irq_set_affinity(irq, mask);
 		}
 	}
 }
diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
index 46427b48e2f1..358df7510186 100644
--- a/drivers/sh/intc/chip.c
+++ b/drivers/sh/intc/chip.c
@@ -22,7 +22,7 @@ void _intc_enable(struct irq_data *data, unsigned long handle)
 
 	for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_E(handle)); cpu++) {
 #ifdef CONFIG_SMP
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		if (!cpumask_test_cpu(cpu, irq_data_get_affinity_mask(data)))
 			continue;
 #endif
 		addr = INTC_REG(d, _INTC_ADDR_E(handle), cpu);
@@ -50,7 +50,7 @@ static void intc_disable(struct irq_data *data)
 
 	for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_D(handle)); cpu++) {
 #ifdef CONFIG_SMP
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		if (!cpumask_test_cpu(cpu, irq_data_get_affinity_mask(data)))
 			continue;
 #endif
 		addr = INTC_REG(d, _INTC_ADDR_D(handle), cpu);
@@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
 	if (!cpumask_intersects(cpumask, cpu_online_mask))
 		return -1;
 
-	cpumask_copy(data->affinity, cpumask);
+	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
 
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
-- 
1.7.10.4

