Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v5 15/33] x86, irq: Split out alloc_ioapic_save_registers()
Date: Thu,  2 Jan 2014 16:05:47 -0800
Message-Id: <1388707565-16535-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split alloc_ioapic_save_registers() from early_irq_init(),
so it will be used per ioapic.

Will call that later for hot-added ioapic controller.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/x86/kernel/apic/io_apic.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 5822c37..c94dd19 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -283,6 +283,19 @@ static struct irq_cfg *alloc_reserved_irq_and_cfg_at(unsigned int at, int node)
 /* irq_cfg is indexed by the sum of all RTEs in all I/O APICs. */
 static struct irq_cfg irq_cfgx[NR_IRQS_LEGACY];
 
+static void alloc_ioapic_saved_registers(int idx)
+{
+	if (ioapics[idx].saved_registers)
+		return;
+
+	ioapics[idx].saved_registers =
+			kzalloc(sizeof(struct IO_APIC_route_entry) *
+				ioapics[idx].nr_registers, GFP_KERNEL);
+
+	if (!ioapics[idx].saved_registers)
+		pr_err("IOAPIC %d: suspend/resume impossible!\n", idx);
+}
+
 int __init arch_early_irq_init(void)
 {
 	struct irq_cfg *cfg;
@@ -291,13 +304,8 @@ int __init arch_early_irq_init(void)
 	if (!legacy_pic->nr_legacy_irqs)
 		io_apic_irqs = ~0UL;
 
-	for (i = 0; i < nr_ioapics; i++) {
-		ioapics[i].saved_registers =
-			kzalloc(sizeof(struct IO_APIC_route_entry) *
-				ioapics[i].nr_registers, GFP_KERNEL);
-		if (!ioapics[i].saved_registers)
-			pr_err("IOAPIC %d: suspend/resume impossible!\n", i);
-	}
+	for (i = 0; i < nr_ioapics; i++)
+		alloc_ioapic_saved_registers(i);
 
 	cfg = irq_cfgx;
 	count = ARRAY_SIZE(irq_cfgx);
-- 
1.8.4

