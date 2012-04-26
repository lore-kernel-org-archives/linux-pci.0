Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48178 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353Ab2DZKnB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 06:43:01 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7F58B3EE0B5
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:43:00 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 65B4145DE5A
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:43:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 48CE745DE52
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:43:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3426A1DB803F
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:43:00 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com [10.240.81.136])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D9C191DB8038
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:42:59 +0900 (JST)
Date: Thu, 26 Apr 2012 19:42:54 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: [PATCH 6/6] PCI, x86: change the way to add MMCFG region on x86
Message-Id: <20120426194254.3679abe0.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
References: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patch changes the way to add MMCFG region on x86.
MMCFG region information provided by ACPI MCFG table 
or _CBA method will be added at acpi_pci_root_add()
of pci_root driver.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 arch/x86/include/asm/pci_x86.h |    2 +
 arch/x86/pci/acpi.c            |   45 +++++++++++++++++++++++++++++++++++++
 arch/x86/pci/mmconfig-shared.c |   49 ++++++++++++++++++++++++++++++-----------
 arch/x86/pci/mmconfig_32.c     |    2 -
 arch/x86/pci/mmconfig_64.c     |    2 -
 drivers/acpi/pci_root.c        |   15 ++++++++++++
 include/acpi/acnames.h         |    1 
 include/linux/pci-acpi.h       |    3 ++
 8 files changed, 105 insertions(+), 14 deletions(-)

Index: bjorn-next/arch/x86/include/asm/pci_x86.h
===================================================================
--- bjorn-next.orig/arch/x86/include/asm/pci_x86.h
+++ bjorn-next/arch/x86/include/asm/pci_x86.h
@@ -100,6 +100,7 @@ struct pci_raw_ops {
 extern const struct pci_raw_ops *raw_pci_ops;
 extern const struct pci_raw_ops *raw_pci_ext_ops;
 
+extern const struct pci_raw_ops pci_mmcfg;
 extern const struct pci_raw_ops pci_direct_conf1;
 extern bool port_cf9_safe;
 
@@ -140,6 +141,7 @@ extern void pci_mmcfg_arch_unmap(struct 
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 extern int __devinit pci_mmconfig_add(int seg, int start, int end, u64 addr);
 extern int pci_mmconfig_delete(int seg, int start, int end);
+extern u64 query_acpi_mcfg_table(int segment, int start);
 extern struct list_head pci_mmcfg_list;
 
 #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
Index: bjorn-next/arch/x86/pci/acpi.c
===================================================================
--- bjorn-next.orig/arch/x86/pci/acpi.c
+++ bjorn-next/arch/x86/pci/acpi.c
@@ -4,6 +4,7 @@
 #include <linux/irq.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/pci-acpi.h>
 #include <asm/numa.h>
 #include <asm/pci_x86.h>
 
@@ -461,6 +462,50 @@ struct pci_bus * __devinit pci_acpi_scan
 	return bus;
 }
 
+
+int __devinit arch_acpi_pci_root_add(struct acpi_pci_root *root)
+{
+	int result = 0;
+	acpi_status status;
+	unsigned long long base_addr = 0;
+
+	/* MMCFG not in use */
+	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
+		return result;
+
+	/* Evaluate _CBA */
+	status = acpi_evaluate_integer(root->device->handle, METHOD_NAME__CBA,
+				       NULL, &base_addr);
+	if (ACPI_FAILURE(status)) {
+		/* search MCFG table */
+		base_addr = query_acpi_mcfg_table(root->segment,
+						  root->secondary.start);
+
+	}
+
+	/* add MMCFG region */
+	if (base_addr) {
+		if (pci_mmconfig_add(root->segment, root->secondary.start,
+					root->secondary.end, base_addr)) {
+			printk(KERN_ERR
+				"can't add MMCFG information for Bus "
+				"%04x:%02x\n",
+				root->segment,
+				(unsigned int)root->secondary.start);
+		}
+	} else {
+		result = -ENODEV;
+	}
+
+	return result;
+}
+
+void arch_acpi_pci_root_remove(struct acpi_pci_root *root)
+{
+	pci_mmconfig_delete(root->segment, root->secondary.start,
+				root->secondary.end);
+}
+
 int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
Index: bjorn-next/arch/x86/pci/mmconfig_32.c
===================================================================
--- bjorn-next.orig/arch/x86/pci/mmconfig_32.c
+++ bjorn-next/arch/x86/pci/mmconfig_32.c
@@ -126,7 +126,7 @@ static int pci_mmcfg_write(unsigned int 
 	return 0;
 }
 
-static const struct pci_raw_ops pci_mmcfg = {
+const struct pci_raw_ops pci_mmcfg = {
 	.read =		pci_mmcfg_read,
 	.write =	pci_mmcfg_write,
 };
Index: bjorn-next/arch/x86/pci/mmconfig_64.c
===================================================================
--- bjorn-next.orig/arch/x86/pci/mmconfig_64.c
+++ bjorn-next/arch/x86/pci/mmconfig_64.c
@@ -90,7 +90,7 @@ static int pci_mmcfg_write(unsigned int 
 	return 0;
 }
 
-static const struct pci_raw_ops pci_mmcfg = {
+const struct pci_raw_ops pci_mmcfg = {
 	.read =		pci_mmcfg_read,
 	.write =	pci_mmcfg_write,
 };
Index: bjorn-next/drivers/acpi/pci_root.c
===================================================================
--- bjorn-next.orig/drivers/acpi/pci_root.c
+++ bjorn-next/drivers/acpi/pci_root.c
@@ -449,6 +449,15 @@ out:
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
+int __weak arch_acpi_pci_root_add(struct acpi_pci_root *root)
+{
+	return 0;
+}
+
+void __weak arch_acpi_pci_root_remove(struct acpi_pci_root *root)
+{
+}
+
 static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
 	unsigned long long segment, bus;
@@ -505,6 +514,11 @@ static int __devinit acpi_pci_root_add(s
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
+	if (arch_acpi_pci_root_add(root)) {
+		result = -ENODEV;
+		goto end;
+	}
+
 	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
@@ -627,6 +641,7 @@ static int __devinit acpi_pci_root_add(s
 end:
 	if (!list_empty(&root->node))
 		list_del(&root->node);
+	arch_acpi_pci_root_remove(root);
 	kfree(root);
 	return result;
 }
Index: bjorn-next/include/acpi/acnames.h
===================================================================
--- bjorn-next.orig/include/acpi/acnames.h
+++ bjorn-next/include/acpi/acnames.h
@@ -62,6 +62,7 @@
 #define METHOD_NAME__AEI        "_AEI"
 #define METHOD_NAME__PRW        "_PRW"
 #define METHOD_NAME__SRS        "_SRS"
+#define METHOD_NAME__CBA	"_CBA"
 
 /* Method names - these methods must appear at the namespace root */
 
Index: bjorn-next/include/linux/pci-acpi.h
===================================================================
--- bjorn-next.orig/include/linux/pci-acpi.h
+++ bjorn-next/include/linux/pci-acpi.h
@@ -18,6 +18,9 @@ extern acpi_status pci_acpi_add_pm_notif
 					     struct pci_dev *pci_dev);
 extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
 
+int arch_acpi_pci_root_add(struct acpi_pci_root *root);
+void arch_acpi_pci_root_remove(struct acpi_pci_root *root);
+
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	struct pci_bus *pbus = pdev->bus;
Index: bjorn-next/arch/x86/pci/mmconfig-shared.c
===================================================================
--- bjorn-next.orig/arch/x86/pci/mmconfig-shared.c
+++ bjorn-next/arch/x86/pci/mmconfig-shared.c
@@ -28,6 +28,9 @@
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static int __initdata pci_mmcfg_resources_inserted;
 
+static struct acpi_mcfg_allocation __initdata *mcfg_table;
+static int __initdata mcfg_table_entry_size;
+
 LIST_HEAD(pci_mmcfg_list);
 
 static __init void pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
@@ -522,6 +525,25 @@ static int __init acpi_mcfg_check_entry(
 	return -EINVAL;
 }
 
+u64 query_acpi_mcfg_table(int segment, int start)
+{
+	u64 base_addr = 0;
+	int i;
+
+	if (!mcfg_table)
+		return 0;
+
+	for (i = 0; i < mcfg_table_entry_size; i++) {
+		if (segment == mcfg_table[i].pci_segment &&
+			start == mcfg_table[i].start_bus_number) {
+			base_addr = mcfg_table[i].address;
+			break;
+		}
+	}
+
+	return base_addr;
+}
+
 static int __init pci_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
@@ -551,19 +573,19 @@ static int __init pci_parse_mcfg(struct 
 	for (i = 0; i < entries; i++) {
 		cfg = &cfg_table[i];
 		if (acpi_mcfg_check_entry(mcfg, cfg)) {
-			free_all_mmcfg();
 			return -ENODEV;
 		}
-
-		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
-				   cfg->end_bus_number, cfg->address) == NULL) {
-			printk(KERN_WARNING PREFIX
-			       "no memory for MCFG entries\n");
-			free_all_mmcfg();
-			return -ENOMEM;
-		}
 	}
 
+	/* populate mcfg_table */
+	mcfg_table = kzalloc(sizeof(struct acpi_mcfg_allocation) * entries,
+			     GFP_KERNEL);
+	if (!mcfg_table)
+		return -ENOMEM;
+	memcpy(mcfg_table, cfg_table,
+	sizeof(struct acpi_mcfg_allocation) * entries);
+	mcfg_table_entry_size = entries;
+
 	return 0;
 }
 
@@ -589,9 +611,6 @@ static void __init __pci_mmcfg_init(int 
 	if (!known_bridge)
 		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 
-	if (list_empty(&pci_mmcfg_list))
-		return;
-
 	if (pcibios_last_bus < 0) {
 		const struct pci_mmcfg_region *cfg;
 
@@ -641,6 +660,12 @@ static int __init pci_mmcfg_late_insert_
 	 */
 	pci_mmcfg_insert_resources();
 
+	/*
+	 * MCFG table should not be reffered to any longer
+	 */
+	kfree(mcfg_table);
+	mcfg_table = NULL;
+
 	return 0;
 }
 

