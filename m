Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40501 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab2DIQ0H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 12:26:07 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2 5/6] PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root bridge hotplug
Date: Tue, 10 Apr 2012 00:22:47 +0800
Message-Id: <1333988568-11282-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_mmconfig_insert()/pci_mmconfig_delete(), which will be used to
update MMCFG information when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/include/asm/pci_x86.h |    2 +
 arch/x86/pci/mmconfig-shared.c |  105 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 4611294..ba8570c 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -137,6 +137,8 @@ extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
 extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
 extern void __devinit pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+extern int __devinit pci_mmconfig_insert(int seg, int start, int end, u64 addr);
+extern int __devinit pci_mmconfig_delete(int seg, int start, int end, u64 addr);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 3bcc361..dda9470 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -17,6 +17,7 @@
 #include <linux/bitmap.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/mutex.h>
 #include <linux/rculist.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
@@ -376,8 +377,8 @@ static void __init pci_mmcfg_insert_resources(void)
 	pci_mmcfg_resources_inserted = 1;
 }
 
-static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
-					      void *data)
+static acpi_status __devinit check_mcfg_resource(struct acpi_resource *res,
+						 void *data)
 {
 	struct resource *mcfg_res = data;
 	struct acpi_resource_address64 address;
@@ -413,8 +414,8 @@ static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
 	return AE_OK;
 }
 
-static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
-		void *context, void **rv)
+static acpi_status __devinit find_mboard_resource(acpi_handle handle, u32 lvl,
+						  void *context, void **rv)
 {
 	struct resource *mcfg_res = context;
 
@@ -427,7 +428,7 @@ static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static int __devinit is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 {
 	struct resource mcfg_res;
 
@@ -446,8 +447,9 @@ static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 
 typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
 
-static int __init is_mmconf_reserved(check_reserved_t is_reserved,
-				    struct pci_mmcfg_region *cfg, int with_e820)
+static int __devinit is_mmconf_reserved(check_reserved_t is_reserved,
+					struct pci_mmcfg_region *cfg,
+					int with_e820)
 {
 	u64 addr = cfg->res.start;
 	u64 size = resource_size(&cfg->res);
@@ -676,3 +678,92 @@ static int __init pci_mmcfg_late_insert_resources(void)
  * with other system resources.
  */
 late_initcall(pci_mmcfg_late_insert_resources);
+
+static DEFINE_MUTEX(pci_mmcfg_lock);
+
+/* Add MMCFG information for hot-added host bridges at runtime */
+int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
+{
+	int rc;
+	struct pci_mmcfg_region *cfg = NULL;
+
+	if (addr == 0 || segment < 0 || segment > USHRT_MAX ||
+	    start < 0 || start > 255 || end < start || end > 255)
+		return -EINVAL;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg = pci_mmconfig_lookup(segment, start);
+	if (cfg) {
+		if (cfg->start_bus == start && cfg->end_bus == end &&
+		    cfg->address == addr) {
+			rc = -EEXIST;
+		} else {
+			rc = -EINVAL;
+			printk(KERN_WARNING PREFIX
+			       "MMCONFIG for domain %04x [bus %02x-%02x] "
+			       "conflicts with domain %04x [bus %02x-%02x]\n",
+			       segment, start, end,
+			       cfg->segment, cfg->start_bus, cfg->end_bus);
+		}
+		goto out;
+	}
+
+	cfg = pci_mmconfig_alloc(segment, start, end, addr);
+	if (cfg == NULL) {
+		rc = -ENOMEM;
+	} else if (!pci_mmcfg_check_reserved(cfg, 0)) {
+		rc = -EINVAL;
+		printk(KERN_WARNING PREFIX
+		       "MMCONFIG for domain %04x [bus %02x-%02x] "
+		       "isn't reserved\n", segment, start, end);
+	} else if (insert_resource(&iomem_resource, &cfg->res)) {
+		rc = -EBUSY;
+		printk(KERN_WARNING PREFIX
+		       "failed to insert resource for domain "
+		       "%04x [bus %02x-%02x]\n", segment, start, end);
+	} else if (pci_mmcfg_arch_map(cfg)) {
+		rc = -EBUSY;
+		printk(KERN_WARNING PREFIX
+		       "failed to map resource for domain "
+		       "%04x [bus %02x-%02x]\n", segment, start, end);
+	} else {
+		list_add_sorted(cfg);
+		cfg = NULL;
+		rc = 0;
+	}
+
+	if (cfg) {
+		if (cfg->res.parent)
+			release_resource(&cfg->res);
+		kfree(cfg);
+	}
+
+out:
+	mutex_unlock(&pci_mmcfg_lock);
+
+	return rc;
+}
+
+/* Delete MMCFG information at runtime */
+int __devinit pci_mmconfig_delete(int segment, int start, int end, u64 addr)
+{
+	struct pci_mmcfg_region *cfg;
+
+	mutex_lock(&pci_mmcfg_lock);
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+		if (cfg->segment == segment && cfg->start_bus == start &&
+		    cfg->end_bus == end && cfg->address == addr) {
+			list_del_rcu(&cfg->list);
+			synchronize_rcu();
+			pci_mmcfg_arch_unmap(cfg);
+			if (cfg->res.parent)
+				release_resource(&cfg->res);
+			mutex_unlock(&pci_mmcfg_lock);
+			kfree(cfg);
+			return 0;
+		}
+	}
+	mutex_unlock(&pci_mmcfg_lock);
+
+	return -ENOENT;
+}
-- 
1.7.5.4

