Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45192 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030562Ab2CTQYY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:24:24 -0400
Received: by wejx9 with SMTP id x9so204085wej.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:24:23 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 6/6] x86,IRQ: Use memory barriers to protect searching side code
Date: Wed, 21 Mar 2012 00:21:03 +0800
Message-Id: <1332260463-13924-8-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use memory barriers to protect searching side code when hot-plugging
IOAPICs.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 9c2ac7b..49c016a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -352,12 +352,15 @@ static void free_ioapic_gsi_irq_base(int idx)
 
 static void alloc_ioapic_saved_registers(int idx)
 {
+	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(idx);
+	int irq_cnt = gsi_cfg->gsi_end - gsi_cfg->gsi_base + 1;
+
 	if (ioapics[idx].saved_registers)
 		return;
 
 	ioapics[idx].saved_registers =
 			kzalloc(sizeof(struct IO_APIC_route_entry) *
-				ioapics[idx].nr_registers, GFP_KERNEL);
+				irq_cnt, GFP_KERNEL);
 
 	if (!ioapics[idx].saved_registers)
 		pr_err("IOAPIC %d: suspend/resume impossible!\n", idx);
@@ -1174,6 +1177,8 @@ int IO_APIC_get_PCI_irq_vector(int bus, int slot, int pin,
 		for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
 			if (!ioapics[ioapic_idx].nr_registers)
 				continue;
+
+			smp_rmb();
 			if (mpc_ioapic_id(ioapic_idx) == mp_irqs[i].dstapic ||
 			    mp_irqs[i].dstapic == MP_APIC_ALL)
 				break;
@@ -2083,7 +2088,7 @@ void __init enable_IO_APIC(void)
 	if (!legacy_pic->nr_legacy_irqs)
 		return;
 
-	for(apic = 0; apic < nr_ioapics; apic++) {
+	for (apic = 0; apic < nr_ioapics; apic++) {
 		int pin;
 		/* See if any of the pins is in ExtINT mode */
 		for (pin = 0; pin < ioapics[apic].nr_registers; pin++) {
@@ -4134,6 +4139,7 @@ int mp_find_ioapic(u32 gsi)
 		if (!ioapics[i].nr_registers)
 			continue;
 
+		smp_rmb();
 		if ((gsi >= gsi_cfg->gsi_base) && (gsi <= gsi_cfg->gsi_end))
 			return i;
 	}
@@ -4214,11 +4220,6 @@ int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hotadd)
 	gsi_cfg->gsi_base = gsi_base;
 	gsi_cfg->gsi_end = gsi_base + entries - 1;
 
-	/*
-	 * The number of IO-APIC IRQ registers (== #pins):
-	 */
-	ioapics[idx].nr_registers = entries;
-
 	if (!hotadd) {
 		/*
 		 * irqs will be reserved in arch_early_irq_init()
@@ -4247,6 +4248,13 @@ int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hotadd)
 	if (idx == nr_ioapics)
 		nr_ioapics++;
 
+	smp_wmb();
+
+	/*
+	 * The number of IO-APIC IRQ registers (== #pins):
+	 */
+	ioapics[idx].nr_registers = entries;
+
 	return 0;
 
 failed:
@@ -4270,6 +4278,9 @@ int mp_unregister_ioapic(u32 gsi_base)
 	if (idx < 0)
 		return -EINVAL;
 
+	ioapics[idx].nr_registers = 0;
+	smp_wmb();
+
 	free_ioapic_saved_registers(idx);
 
 	free_ioapic_gsi_irq_base(idx);
-- 
1.7.5.4

