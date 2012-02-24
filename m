Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:37326 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab2BXDto (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 22:49:44 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>
Subject: [PATCH 09/13] x86, irq: Add mp_unregister_ioapic could handle hotremove ioapic
Date: Thu, 23 Feb 2012 19:48:55 -0800
Message-Id: <1330055339-11662-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330055339-11662-1-git-send-email-yinghai@kernel.org>
References: <1330055339-11662-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

it will free ioapic related irq_desc and also clear allocated_irqs bits.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
---
 arch/x86/include/asm/mpspec.h  |    1 +
 arch/x86/kernel/apic/io_apic.c |   42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index aca26fa..6f80e04 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -97,6 +97,7 @@ static inline void early_reserve_e820_mpc_new(void) { }
 void __cpuinit generic_processor_info(int apicid, int version);
 #ifdef CONFIG_ACPI
 int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hot);
+int mp_unregister_ioapic(u32 gsi_base);
 extern void mp_register_ioapic(int id, u32 address, u32 gsi_base);
 extern void mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 				   u32 gsi);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2e8497c..4517713 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -255,6 +255,14 @@ static void free_irq_at(unsigned int at, struct irq_cfg *cfg)
 	irq_free_desc(at);
 }
 
+static void free_irqs(unsigned int from, int cnt)
+{
+	int i;
+
+	for (i = from; i < from + cnt; i++)
+		free_irq_at(i, irq_get_chip_data(i));
+}
+
 static struct irq_cfg *realloc_irq_and_cfg_at(unsigned int at, int node)
 {
 	struct irq_desc *desc = irq_to_desc(at);
@@ -328,6 +336,16 @@ static void __init reserve_ioapic_gsi_irq_extra(void)
 	}
 }
 
+static void free_ioapic_gsi_irq_base(int idx)
+{
+	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(idx);
+	int irq_base = gsi_cfg->irq_base;
+	int irq_cnt = gsi_cfg->gsi_end - gsi_cfg->gsi_base + 1;
+
+	if (irq_base > 0)
+		free_irqs(irq_base, irq_cnt);
+}
+
 static void alloc_ioapic_saved_registers(int idx)
 {
 	if (ioapics[idx].saved_registers)
@@ -341,6 +359,11 @@ static void alloc_ioapic_saved_registers(int idx)
 		pr_err("IOAPIC %d: suspend/resume impossible!\n", idx);
 }
 
+static void free_ioapic_saved_registers(int idx)
+{
+	kfree(ioapics[idx].saved_registers);
+}
+
 int __init arch_early_irq_init(void)
 {
 	int node = cpu_to_node(0);
@@ -4166,6 +4189,25 @@ void mp_register_ioapic(int id, u32 address, u32 gsi_base)
 	__mp_register_ioapic(id, address, gsi_base, false);
 }
 
+int mp_unregister_ioapic(u32 gsi_base)
+{
+	int idx;
+
+	idx = mp_find_ioapic(gsi_base);
+	if (idx < 0)
+		return -EINVAL;
+
+	free_ioapic_saved_registers(idx);
+
+	free_ioapic_gsi_irq_base(idx);
+
+	clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
+	memset(&ioapics[idx], 0, sizeof(struct ioapic));
+	ioapics[idx].mp_config.apicid = 0xff;
+
+	return 0;
+}
+
 /* Enable IOAPIC early just for system timer */
 void __init pre_init_apic_IRQ0(void)
 {
-- 
1.7.7

