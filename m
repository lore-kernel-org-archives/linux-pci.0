Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60405 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030562Ab2CTQYP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:24:15 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so215351iag.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:24:15 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 5/6] x86,IRQ: Correctly manage MMIO resource used by IOAPIC when hot-plugging IOPAICs
Date: Wed, 21 Mar 2012 00:21:02 +0800
Message-Id: <1332260463-13924-7-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Correctly manage MMIO resource used by IOAPIC when hot-plugging IOAPICs.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c |   46 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index dfb6f45..9c2ac7b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -4054,6 +4054,42 @@ fake_ioapic_page:
 	res->end = ioapic_phys + IO_APIC_SLOT_SIZE - 1;
 }
 
+static struct resource *ioapic_add_resource(int idx)
+{
+	char *name;
+	struct resource *res;
+	size_t sz = IOAPIC_RESOURCE_NAME_SIZE + sizeof(struct resource);
+
+	res = kzalloc(sz, GFP_KERNEL);
+	if (res) {
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		res->name = name = (char *)(res + 1);
+		snprintf(name, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", idx);
+		ioapic_setup_resource(idx, res, true);
+		ioapics[idx].resource = res;
+
+		if (insert_resource(&iomem_resource, res)) {
+			kfree(res);
+			res = NULL;
+		}
+	}
+
+	return res;
+}
+
+static void ioapic_remove_resource(int idx)
+{
+	struct resource *res = ioapics[idx].resource;
+
+	if (res) {
+		if (res->parent)
+			release_resource(res);
+		if (PageSlab(virt_to_page(res)))
+			kfree(res);
+		ioapics[idx].resource = NULL;
+	}
+}
+
 void __init ioapic_and_gsi_init(void)
 {
 	int i;
@@ -4191,8 +4227,12 @@ int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hotadd)
 		if (gsi_cfg->gsi_end >= gsi_top)
 			gsi_top = gsi_cfg->gsi_end + 1;
 	} else {
-		int irq = reserve_ioapic_gsi_irq_base(idx, true);
+		int irq;
 
+		if (ioapic_add_resource(idx) == NULL)
+			goto failed;
+
+		irq = reserve_ioapic_gsi_irq_base(idx, true);
 		if (irq < 0)
 			goto failed;
 
@@ -4210,6 +4250,7 @@ int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hotadd)
 	return 0;
 
 failed:
+	ioapic_remove_resource(idx);
 	clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
 	memset(&ioapics[idx], 0, sizeof(struct ioapic));
 	ioapics[idx].mp_config.apicid = 0xff;
@@ -4234,6 +4275,9 @@ int mp_unregister_ioapic(u32 gsi_base)
 	free_ioapic_gsi_irq_base(idx);
 
 	clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
+
+	ioapic_remove_resource(idx);
+
 	memset(&ioapics[idx], 0, sizeof(struct ioapic));
 	ioapics[idx].mp_config.apicid = 0xff;
 
-- 
1.7.5.4

