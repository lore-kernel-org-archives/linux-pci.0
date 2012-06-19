Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:42886 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2FSNXY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 09:23:24 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v8 12/12] x86/PCI: add MMCFG information on demand
Date: Tue, 19 Jun 2012 21:15:32 +0800
Message-ID: <1340111732-6276-13-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch changes mmconfig logic on x86 platforms to add MMCFG
information on demand instead of adding all MMCFG entries from
the ACPI MCFG table at boot time. So only MMCFG address ranges
used by active PCI host bridges will be actually mapped.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

v8: this patch is just for RFC now, there still ongoing discussion
    about creating MMCONFIG information on demand

---
 arch/x86/include/asm/pci_x86.h |    5 +++
 arch/x86/pci/legacy.c          |    1 +
 arch/x86/pci/mmconfig-shared.c |   76 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index b2652e9..0c0c1a7 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -142,6 +142,11 @@ extern int __devinit pci_mmconfig_insert(struct device *dev,
 					 u16 seg, u8 start,
 					 u8 end, phys_addr_t addr);
 extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_MMCONFIG)
+extern void pci_mmconfig_probe(u8 start);
+#else
+static inline void pci_mmconfig_probe(u8 start) { }
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
index f8c967c..330831c 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -459,6 +459,14 @@ static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
 			break;
 	}
 
+	/*
+	 * For backward compatibility, we will adjust the MMCONFIG region
+	 * at boot time if it's only partially reserved by firmware.
+	 * For PCI host bridge hotplug at runtime, just reject it.
+	 */
+	if (pci_mmcfg_running_state && old_size != size)
+		return 0;
+
 	if (size < (16UL<<20) && size != old_size)
 		return 0;
 
@@ -602,6 +610,16 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
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
@@ -614,7 +632,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 	return 0;
 }
 
-static void __init __pci_mmcfg_init(int early)
+static void __init __pci_mmcfg_init(int early, bool create_on_demand)
 {
 	pci_mmcfg_reject_broken(early);
 	if (list_empty(&pci_mmcfg_list))
@@ -630,6 +648,13 @@ static void __init __pci_mmcfg_init(int early)
 		}
 	}
 
+	/*
+	 * Avoid redundant pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap() calls
+	 * for each MMCONFIG entry if they will be created on demand.
+	 */
+	if (create_on_demand)
+		free_all_mmcfg();
+
 	if (pci_mmcfg_arch_init())
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 	else {
@@ -647,28 +672,37 @@ void __init pci_mmcfg_early_init(void)
 			known_bridge = 1;
 		else
 			acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
-		__pci_mmcfg_init(1);
+		__pci_mmcfg_init(1, false);
 	}
 }
 
 void __init pci_mmcfg_late_init(void)
 {
+	bool create_on_demand;
+
 	/* MMCONFIG disabled */
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	/* MMCONFIG already enabled */
-	if (!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
-		return;
-
 	if (known_bridge)
 		return;
 
-	acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
-	__pci_mmcfg_init(0);
+	/*
+	 * MMCONFIG information will be created on demand by pci_root driver
+	 * when binding to ACPI host bridge deivces.
+	 */
+	create_on_demand = (!acpi_disabled && !acpi_pci_cache_mcfg());
 
-	if (!(pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF))
-		acpi_pci_cache_mcfg();
+	/* pci_mmcfg_early_init() fails to setup MMCONFIG, try again. */
+	if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF) {
+		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+		__pci_mmcfg_init(0, create_on_demand);
+	/*
+	 * Free MMCONFIG information created by pci_mmcfg_early_init()
+	 * if MMCONFIG information will be created on demand.
+	 */
+	} else if (create_on_demand)
+		free_all_mmcfg();
 }
 
 static int __init pci_mmcfg_late_insert_resources(void)
@@ -802,3 +836,25 @@ int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
 
 	return -ENOENT;
 }
+
+#ifdef	CONFIG_ACPI
+/* Probe MMCFG information for PCI bus blind probe */
+void __devinit pci_mmconfig_probe(u8 start)
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
+		pci_mmconfig_insert(NULL, 0, start, (u8) temp, addr);
+	}
+}
+#endif
-- 
1.7.1


