Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([58.251.152.67]:50979 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752160Ab2EZJyi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2012 05:54:38 -0400
Received: from huawei.com (szxga04-in [172.24.2.12])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M00AHMJJT9I@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:05 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M00JJ6JJT8P@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:05 +0800 (CST)
Date: Sat, 26 May 2012 17:54:01 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
In-reply-to: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Message-id: <1338026043-3968-9-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch changes mmconfig logic on x86 platforms to add MMCFG
information on demand instead of adding all MMCFG entries from
the ACPI MCFG table at boot time. So only MMCFG address ranges
used by active PCI host bridges will be actually mapped.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/include/asm/pci_x86.h |    5 +++
 arch/x86/pci/legacy.c          |    1 +
 arch/x86/pci/mmconfig-shared.c |   54 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 3e5f43c..4a1a9aa 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -142,6 +142,11 @@ extern int __devinit pci_mmconfig_insert(struct device *dev,
 					 uint16_t seg, uint8_t start,
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
index fa0aa90..e80b5c2 100644
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
@@ -616,6 +617,16 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
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
@@ -625,6 +636,13 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
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
 
@@ -634,14 +652,14 @@ static void __init __pci_mmcfg_init(int early)
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
@@ -675,6 +693,14 @@ static void __init __pci_mmcfg_init(int early)
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
@@ -809,3 +835,23 @@ int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end)
 
 	return -ENOENT;
 }
+
+/* Probe MMCFG information for PCI bus blind probe */
+void __devinit pci_mmconfig_probe(uint8_t start)
+{
+	int end_bus, temp;
+	phys_addr_t addr;
+
+	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
+		return;
+
+	addr = acpi_pci_root_get_mcfg_addr(NULL, 0, start, &end_bus);
+	if (addr && end_bus >= 0 && end_bus <= 255) {
+		for (temp = start + 1; temp <= end_bus; temp++)
+			if (pci_find_bus(0, temp))
+				break;
+
+		temp--;
+		pci_mmconfig_insert(NULL, 0, start, (uint8_t)temp, addr);
+	}
+}
-- 
1.7.1


