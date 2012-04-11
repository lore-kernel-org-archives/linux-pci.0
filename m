Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:57282 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab2DKAOw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 20:14:52 -0400
Received: by dake40 with SMTP id e40so395364dak.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 17:14:52 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH V4 5/6] PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root bridge hotplug
Date: Wed, 11 Apr 2012 08:11:02 +0800
Message-Id: <1334103063-2283-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_mmconfig_insert()/pci_mmconfig_delete(), which will be used to
update MMCFG information when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/include/asm/pci_x86.h |    2 +
 arch/x86/pci/mmconfig-shared.c |  104 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index df898ce..3252c97 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -137,6 +137,8 @@ extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
 extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
 extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+extern int __devinit pci_mmconfig_insert(int seg, int start, int end, u64 addr);
+extern int pci_mmconfig_delete(int seg, int start, int end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 3bcc361..ee1eaab 100644
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
@@ -676,3 +678,91 @@ static int __init pci_mmcfg_late_insert_resources(void)
  * with other system resources.
  */
 late_initcall(pci_mmcfg_late_insert_resources);
+
+static DEFINE_MUTEX(pci_mmcfg_lock);
+
+/* Add MMCFG information for hot-added host bridges at runtime */
+int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
+{
+	int rc = -EINVAL;
+	struct pci_mmcfg_region *cfg = NULL;
+
+	if (segment < 0 || segment > USHRT_MAX ||
+	    start < 0 || start > 255 || end < start || end > 255)
+		return rc;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg = pci_mmconfig_lookup(segment, start);
+	if (cfg) {
+		if (cfg->start_bus <= start && cfg->end_bus >= end) {
+			rc = -EEXIST;
+		} else {
+			printk(KERN_WARNING PREFIX
+			       "MMCONFIG for domain %04x [bus %02x-%02x] "
+			       "conflicts with domain %04x [bus %02x-%02x]\n",
+			       segment, start, end,
+			       cfg->segment, cfg->start_bus, cfg->end_bus);
+		}
+		goto out;
+	}
+	if (!addr)
+		goto out;
+
+	cfg = pci_mmconfig_alloc(segment, start, end, addr);
+	if (cfg == NULL) {
+		rc = -ENOMEM;
+	} else if (!pci_mmcfg_check_reserved(cfg, 0)) {
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
+int pci_mmconfig_delete(int segment, int start, int end)
+{
+	struct pci_mmcfg_region *cfg;
+
+	mutex_lock(&pci_mmcfg_lock);
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+		if (cfg->segment == segment && cfg->start_bus == start &&
+		    cfg->end_bus == end) {
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

