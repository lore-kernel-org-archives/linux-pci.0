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
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com
Subject: [Patch v3 13/36] mn10300: Fix incorrect use of data->affinity
Date: Mon,  1 Jun 2015 16:05:22 +0800
Message-Id: <1433145945-789-14-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The field affinity in struct irq_data is type of cpumask_var_t, so
we should pass in data->affinity instead of &data->affinity when
calling cpumask_xxxx().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/mn10300/kernel/irq.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mn10300/kernel/irq.c b/arch/mn10300/kernel/irq.c
index 6ab3b73efcf8..480de70f4059 100644
--- a/arch/mn10300/kernel/irq.c
+++ b/arch/mn10300/kernel/irq.c
@@ -320,11 +320,11 @@ void migrate_irqs(void)
 		if (irqd_is_per_cpu(data))
 			continue;
 
-		if (cpumask_test_cpu(self, &data->affinity) &&
+		if (cpumask_test_cpu(self, data->affinity) &&
 		    !cpumask_intersects(&irq_affinity[irq], cpu_online_mask)) {
 			int cpu_id;
 			cpu_id = cpumask_first(cpu_online_mask);
-			cpumask_set_cpu(cpu_id, &data->affinity);
+			cpumask_set_cpu(cpu_id, data->affinity);
 		}
 		/* We need to operate irq_affinity_online atomically. */
 		arch_local_cli_save(flags);
@@ -335,7 +335,7 @@ void migrate_irqs(void)
 			GxICR(irq) = x & GxICR_LEVEL;
 			tmp = GxICR(irq);
 
-			new = cpumask_any_and(&data->affinity,
+			new = cpumask_any_and(data->affinity,
 					      cpu_online_mask);
 			irq_affinity_online[irq] = new;
 
-- 
1.7.10.4

