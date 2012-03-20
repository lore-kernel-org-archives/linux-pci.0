Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61980 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030630Ab2CTQYH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:24:07 -0400
Received: by ghrr11 with SMTP id r11so228398ghr.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:24:07 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 4/6] x86,IRQ: split out function ioapic_setup_resource()
Date: Wed, 21 Mar 2012 00:21:01 +0800
Message-Id: <1332260463-13924-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split out function ioapic_setup_resource(), which will be used by IOAPIC
hotplug logic.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c |   69 ++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index e5b6ca4..dfb6f45 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -85,6 +85,7 @@ static struct ioapic {
 	 * Saved state during suspend/resume, or while enabling intr-remap.
 	 */
 	struct IO_APIC_route_entry *saved_registers;
+	struct resource *resource;
 	/* I/O APIC config */
 	struct mpc_ioapic mp_config;
 	/* IO APIC gsi routing info */
@@ -3987,7 +3988,7 @@ void __init setup_ioapic_dest(void)
 
 static struct resource *ioapic_resources;
 
-static struct resource * __init ioapic_setup_resources(int nr_ioapics)
+static struct resource * __init ioapic_alloc_resources(int nr_ioapics)
 {
 	unsigned long n;
 	struct resource *res;
@@ -4010,6 +4011,7 @@ static struct resource * __init ioapic_setup_resources(int nr_ioapics)
 		res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 		snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
 		mem += IOAPIC_RESOURCE_NAME_SIZE;
+		ioapics[i].resource = &res[i];
 	}
 
 	ioapic_resources = res;
@@ -4017,43 +4019,48 @@ static struct resource * __init ioapic_setup_resources(int nr_ioapics)
 	return res;
 }
 
-void __init ioapic_and_gsi_init(void)
+static void ioapic_setup_resource(int idx, struct resource *res, bool hotadd)
 {
-	unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
-	struct resource *ioapic_res;
-	int i;
+	unsigned long ioapic_phys, vaddr;
 
-	ioapic_res = ioapic_setup_resources(nr_ioapics);
-	for (i = 0; i < nr_ioapics; i++) {
-		if (smp_found_config) {
-			ioapic_phys = mpc_ioapic_addr(i);
+	if (hotadd) {
+		ioapic_phys = mpc_ioapic_addr(idx);
+	} else if (smp_found_config) {
+		ioapic_phys = mpc_ioapic_addr(idx);
 #ifdef CONFIG_X86_32
-			if (!ioapic_phys) {
-				printk(KERN_ERR
-				       "WARNING: bogus zero IO-APIC "
-				       "address found in MPTABLE, "
-				       "disabling IO/APIC support!\n");
-				smp_found_config = 0;
-				skip_ioapic_setup = 1;
-				goto fake_ioapic_page;
-			}
+		if (!ioapic_phys) {
+			printk(KERN_ERR
+			       "WARNING: bogus zero IO-APIC address found "
+			       "in MPTABLE, disabling IO/APIC support!\n");
+			smp_found_config = 0;
+			skip_ioapic_setup = 1;
+			goto fake_ioapic_page;
+		}
 #endif
-		} else {
+	} else {
 #ifdef CONFIG_X86_32
 fake_ioapic_page:
 #endif
-			ioapic_phys = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
-			ioapic_phys = __pa(ioapic_phys);
-		}
-		set_fixmap_nocache(idx, ioapic_phys);
-		apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
-			__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
-			ioapic_phys);
-		idx++;
-
-		ioapic_res->start = ioapic_phys;
-		ioapic_res->end = ioapic_phys + IO_APIC_SLOT_SIZE - 1;
-		ioapic_res++;
+		ioapic_phys = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
+		ioapic_phys = __pa(ioapic_phys);
+	}
+
+	vaddr = __fix_to_virt(FIX_IO_APIC_BASE_0 + idx);
+	vaddr += (ioapic_phys & ~PAGE_MASK);
+	apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
+		vaddr, ioapic_phys);
+
+	res->start = ioapic_phys;
+	res->end = ioapic_phys + IO_APIC_SLOT_SIZE - 1;
+}
+
+void __init ioapic_and_gsi_init(void)
+{
+	int i;
+
+	ioapic_alloc_resources(nr_ioapics);
+	for (i = 0; i < nr_ioapics; i++) {
+		ioapic_setup_resource(i, ioapics[i].resource, false);
 	}
 
 	probe_nr_irqs_gsi();
-- 
1.7.5.4

