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
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com
Subject: [Patch v3 22/36] mn10300, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:31 +0800
Message-Id: <1433145945-789-23-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mn10300/kernel/cevt-mn10300.c |    2 +-
 arch/mn10300/kernel/irq.c          |   13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mn10300/kernel/cevt-mn10300.c b/arch/mn10300/kernel/cevt-mn10300.c
index 60f64ca1752a..326677d4a3b2 100644
--- a/arch/mn10300/kernel/cevt-mn10300.c
+++ b/arch/mn10300/kernel/cevt-mn10300.c
@@ -123,7 +123,7 @@ int __init init_clockevents(void)
 	{
 		struct irq_data *data;
 		data = irq_get_irq_data(cd->irq);
-		cpumask_copy(data->affinity, cpumask_of(cpu));
+		cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
 		iact->flags |= IRQF_NOBALANCING;
 	}
 #endif
diff --git a/arch/mn10300/kernel/irq.c b/arch/mn10300/kernel/irq.c
index 480de70f4059..c716437baa2c 100644
--- a/arch/mn10300/kernel/irq.c
+++ b/arch/mn10300/kernel/irq.c
@@ -87,7 +87,8 @@ static void mn10300_cpupic_mask_ack(struct irq_data *d)
 		tmp2 = GxICR(irq);
 
 		irq_affinity_online[irq] =
-			cpumask_any_and(d->affinity, cpu_online_mask);
+			cpumask_any_and(irq_data_get_affinity_mask(d),
+					cpu_online_mask);
 		CROSS_GxICR(irq, irq_affinity_online[irq]) =
 			(tmp & (GxICR_LEVEL | GxICR_ENABLE)) | GxICR_DETECT;
 		tmp = CROSS_GxICR(irq, irq_affinity_online[irq]);
@@ -124,7 +125,7 @@ static void mn10300_cpupic_unmask_clear(struct irq_data *d)
 	} else {
 		tmp = GxICR(irq);
 
-		irq_affinity_online[irq] = cpumask_any_and(d->affinity,
+		irq_affinity_online[irq] = cpumask_any_and(irq_data_get_affinity_mask(d),
 							   cpu_online_mask);
 		CROSS_GxICR(irq, irq_affinity_online[irq]) = (tmp & GxICR_LEVEL) | GxICR_ENABLE | GxICR_DETECT;
 		tmp = CROSS_GxICR(irq, irq_affinity_online[irq]);
@@ -316,15 +317,16 @@ void migrate_irqs(void)
 	self = smp_processor_id();
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		struct irq_data *data = irq_get_irq_data(irq);
+		struct cpumask *mask = irq_data_get_affinity_mask(data);
 
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (cpumask_test_cpu(self, data->affinity) &&
+		if (cpumask_test_cpu(self, mask) &&
 		    !cpumask_intersects(&irq_affinity[irq], cpu_online_mask)) {
 			int cpu_id;
 			cpu_id = cpumask_first(cpu_online_mask);
-			cpumask_set_cpu(cpu_id, data->affinity);
+			cpumask_set_cpu(cpu_id, mask);
 		}
 		/* We need to operate irq_affinity_online atomically. */
 		arch_local_cli_save(flags);
@@ -335,8 +337,7 @@ void migrate_irqs(void)
 			GxICR(irq) = x & GxICR_LEVEL;
 			tmp = GxICR(irq);
 
-			new = cpumask_any_and(data->affinity,
-					      cpu_online_mask);
+			new = cpumask_any_and(mask, cpu_online_mask);
 			irq_affinity_online[irq] = new;
 
 			CROSS_GxICR(irq, new) =
-- 
1.7.10.4

