Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60405 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030383Ab2CTQX6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:23:58 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so215351iag.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:23:58 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 3/6] x86,IRQ: Enhance irq allocation policy for hot-added IOAPICs
Date: Wed, 21 Mar 2012 00:21:00 +0800
Message-Id: <1332260463-13924-5-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For hot-added IOAPICs, try to allocate irqs starting from
ioapic->gsi_base first, and fallback to starting from 0.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 622374f..e5b6ca4 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -294,13 +294,16 @@ static struct irq_cfg *realloc_irq_and_cfg_at(unsigned int at, int node)
 	return alloc_irq_and_cfg_at(at, node);
 }
 
-static int reserve_ioapic_gsi_irq_base(int idx)
+static int reserve_ioapic_gsi_irq_base(int idx, bool hotadd)
 {
 	int irq;
 	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(idx);
 	int cnt = gsi_cfg->gsi_end - gsi_cfg->gsi_base + 1;
 
 	irq = __irq_reserve_irqs(-1, gsi_cfg->gsi_base, cnt);
+	if (irq < 0 && hotadd)
+		irq = __irq_reserve_irqs(-1, 0, cnt);
+
 	if (irq >= 0) {
 		gsi_cfg->irq_base = irq;
 		printk(KERN_INFO
@@ -378,7 +381,7 @@ int __init arch_early_irq_init(void)
 		alloc_ioapic_saved_registers(i);
 
 	for (i = 0; i < nr_ioapics; i++)
-		reserve_ioapic_gsi_irq_base(i);
+		reserve_ioapic_gsi_irq_base(i, false);
 
 	reserve_ioapic_gsi_irq_extra();
 
@@ -4181,7 +4184,7 @@ int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hotadd)
 		if (gsi_cfg->gsi_end >= gsi_top)
 			gsi_top = gsi_cfg->gsi_end + 1;
 	} else {
-		int irq = reserve_ioapic_gsi_irq_base(idx);
+		int irq = reserve_ioapic_gsi_irq_base(idx, true);
 
 		if (irq < 0)
 			goto failed;
-- 
1.7.5.4

