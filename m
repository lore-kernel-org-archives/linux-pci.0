Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:34469 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964805Ab2EWDwK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 23:52:10 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G0053TIPVL6@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:32 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G00B7DIPPK7@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:32 +0800 (CST)
Date: Wed, 23 May 2012 11:50:25 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 8/9] PCI, x86: add MMCFG information on demand
In-reply-to: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <1337745026-1180-9-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

This patch changes mmconfig logic on x86 platforms to add MMCFG
information on demand instead of adding all MMCFG entries from
the ACPI MCFG table at boot time. So only MMCFG address ranges
used by active PCI host bridges will be actually mapped.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/include/asm/pci_x86.h |    5 ++++
 arch/x86/pci/legacy.c          |    1 +
 arch/x86/pci/mmconfig-shared.c |   51 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index a50e783..dcf5d3e 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -141,6 +141,11 @@ extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
 extern int __devinit pci_mmconfig_insert(uint16_t seg, uint8_t start,
 					 uint8_t end, phys_addr_t addr);
 extern int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end);
+#ifdef	CONFIG_ACPI
+extern void pci_mmconfig_probe(uint8_t start);
+#else
+static inline void pci_mmconfig_probe(uint8_t start) { }
+#endif
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index a1df191..e9a2384 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -49,6 +49,7 @@ void __devinit pcibios_scan_specific_bus(int busn)
 		    l != 0x0000 && l != 0xffff) {
 			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
 			printk(KERN_INFO "PCI: Discovered peer bus %02x\n", busn);
+			pci_mmconfig_probe(busn);
 			pci_scan_bus_on_node(busn, &pci_root_ops, node);
 			return;
 		}
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 4d0600b..a7a2efd 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
+#include <linux/pci-acpi.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 #include <asm/acpi.h>
@@ -600,6 +601,16 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 			return -ENODEV;
 		}
 
+		/*
+		 * MMCFG information for host brideges will be added on demand
+		 * by pci_root driver if ACPI is enabled. But there are special
+		 * requirements for devices on segment 0, MMCFG information may
+		 * be needed for fixing hardware quirks and probing for hidden
+		 * buses.
+		 */
+		if (!acpi_disabled && cfg->pci_segment)
+			continue;
+
 		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
 				   cfg->end_bus_number, cfg->address) == NULL) {
 			printk(KERN_WARNING PREFIX
@@ -609,6 +620,13 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 		}
 	}
 
+	i = entries * sizeof(*cfg_table);
+	pci_acpi_mcfg_array = kmalloc(i, GFP_KERNEL);
+	if (pci_acpi_mcfg_array) {
+		memcpy(pci_acpi_mcfg_array, cfg_table, i);
+		pci_acpi_mcfg_entries = entries;
+	}
+
 	return 0;
 }
 
@@ -618,14 +636,14 @@ static void __init __pci_mmcfg_init(int early)
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	/* MMCONFIG already enabled */
-	if (!early && !(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
-		return;
-
 	/* for late to exit */
 	if (known_bridge)
 		return;
 
+	/* MMCONFIG already enabled */
+	if (!early && !(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
+		goto out;
+
 	if (early) {
 		if (pci_mmcfg_check_hostbridge())
 			known_bridge = 1;
@@ -659,6 +677,14 @@ static void __init __pci_mmcfg_init(int early)
 		pci_mmcfg_resources_inserted = 1;
 		pci_mmcfg_arch_init_failed = true;
 	}
+
+out:
+	/*
+	 * Free all MCFG entries if ACPI is enabled. MCFG information will
+	 * be added back on demand by the pci_root driver later.
+	 */
+	if (!early && !acpi_disabled && !known_bridge && pci_acpi_mcfg_array)
+		free_all_mmcfg();
 }
 
 void __init pci_mmcfg_early_init(void)
@@ -788,3 +814,20 @@ int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end)
 
 	return -ENOENT;
 }
+
+/* Probe MMCFG information for PCI bus blind probe */
+void __devinit pci_mmconfig_probe(uint8_t start)
+{
+	int end_bus, temp;
+	phys_addr_t addr;
+
+	addr = acpi_pci_root_get_mcfg_addr(NULL, 0, start, &end_bus);
+	if (addr && end_bus >= 0 && end_bus <= 255) {
+		for (temp = start + 1; temp <= end_bus; temp++)
+			if (pci_find_bus(0, temp))
+				break;
+
+		temp--;
+		pci_mmconfig_insert(0, start, (uint8_t)temp, addr);
+	}
+}
-- 
1.7.1


