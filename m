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
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: [Patch v3 28/36] xtensa, irq: Use access helper irq_data_get_affinity_mask()
Date: Mon,  1 Jun 2015 16:05:37 +0800
Message-Id: <1433145945-789-29-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/xtensa/kernel/irq.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 3eee94f621eb..d7b5a4c8ae5d 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -166,23 +166,25 @@ void migrate_irqs(void)
 
 	for_each_active_irq(i) {
 		struct irq_data *data = irq_get_irq_data(i);
+		struct cpumask *mask;
 		unsigned int newcpu;
 
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (!cpumask_test_cpu(cpu, data->affinity))
+		mask = irq_data_get_affinity_mask(data);
+		if (!cpumask_test_cpu(cpu, mask))
 			continue;
 
-		newcpu = cpumask_any_and(data->affinity, cpu_online_mask);
+		newcpu = cpumask_any_and(mask, cpu_online_mask);
 
 		if (newcpu >= nr_cpu_ids) {
 			pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 					    i, cpu);
 
-			cpumask_setall(data->affinity);
+			cpumask_setall(mask);
 		}
-		irq_set_affinity(i, data->affinity);
+		irq_set_affinity(i, mask);
 	}
 }
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
1.7.10.4

