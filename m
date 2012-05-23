Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([58.251.152.67]:62768 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932160Ab2EWDwB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 23:52:01 -0400
Received: from huawei.com (szxga04-in [172.24.2.12])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G005XVIPNAW@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:23 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G00H21IP7RA@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:23 +0800 (CST)
Date: Wed, 23 May 2012 11:50:22 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 5/9] PCI, x86: introduce pci_mmconfig_insert()/delete() for
 PCI root bridge hotplug
In-reply-to: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <1337745026-1180-6-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

Introduce pci_mmconfig_insert()/pci_mmconfig_delete(), which will be used to
update MMCFG information when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/include/asm/pci_x86.h |    3 +
 arch/x86/pci/mmconfig-shared.c |  130 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index df898ce..1a3c12f 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -137,6 +137,9 @@ extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
 extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
 extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+extern int __devinit pci_mmconfig_insert(uint16_t seg, uint8_t start,
+					 uint8_t end, phys_addr_t addr);
+extern int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0ac97d5..8d0c287 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -27,6 +27,7 @@
 
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static int __initdata pci_mmcfg_resources_inserted;
+static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
@@ -374,15 +375,20 @@ static void __init pci_mmcfg_insert_resources(void)
 {
 	struct pci_mmcfg_region *cfg;
 
+	/*
+	 * Insert resources for MMCFG items if the resource hasn't been
+	 * inserted by pci_mmconfig_insert() yet.
+	 */
 	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		insert_resource(&iomem_resource, &cfg->res);
+		if (!cfg->res.parent)
+			insert_resource(&iomem_resource, &cfg->res);
 
 	/* Mark that the resources have been inserted. */
 	pci_mmcfg_resources_inserted = 1;
 }
 
-static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
-					      void *data)
+static acpi_status __devinit check_mcfg_resource(struct acpi_resource *res,
+						 void *data)
 {
 	struct resource *mcfg_res = data;
 	struct acpi_resource_address64 address;
@@ -418,8 +424,8 @@ static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
 	return AE_OK;
 }
 
-static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
-		void *context, void **rv)
+static acpi_status __devinit find_mboard_resource(acpi_handle handle, u32 lvl,
+						  void *context, void **rv)
 {
 	struct resource *mcfg_res = context;
 
@@ -432,7 +438,7 @@ static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static int __devinit is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 {
 	struct resource mcfg_res;
 
@@ -451,8 +457,9 @@ static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 
 typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
 
-static int __init is_mmconf_reserved(check_reserved_t is_reserved,
-				    struct pci_mmcfg_region *cfg, int with_e820)
+static int __devinit is_mmconf_reserved(check_reserved_t is_reserved,
+					struct pci_mmcfg_region *cfg,
+					int with_e820)
 {
 	u64 addr = cfg->res.start;
 	u64 size = resource_size(&cfg->res);
@@ -491,7 +498,7 @@ static int __init is_mmconf_reserved(check_reserved_t is_reserved,
 	return valid;
 }
 
-static int __devinit pci_mmcfg_check_reserved(struct pci_mmcfg_region *cfg,
+static int __ref pci_mmcfg_check_reserved(struct pci_mmcfg_region *cfg,
 					      int early)
 {
 	if (!early && !acpi_disabled) {
@@ -504,6 +511,15 @@ static int __devinit pci_mmcfg_check_reserved(struct pci_mmcfg_region *cfg,
 			       &cfg->res);
 	}
 
+	/*
+	 * e820_all_mapped() is marked as __init.
+	 * All entries from ACPI MCFG table have been checked at boot time.
+	 * For MCFG information constructed from hotpluggable host bridge's
+	 * _CBA method, just assume it's reserved.
+	 */
+	if (system_state == SYSTEM_RUNNING)
+		return 1;
+
 	/* Don't try to do this check unless configuration
 	   type 1 is available. how about type 2 ?*/
 	if (raw_pci_ops)
@@ -641,6 +657,7 @@ static void __init __pci_mmcfg_init(int early)
 		 * the architecture mmcfg setup could not initialize.
 		 */
 		pci_mmcfg_resources_inserted = 1;
+		pci_mmcfg_arch_init_failed = true;
 	}
 }
 
@@ -681,3 +698,98 @@ static int __init pci_mmcfg_late_insert_resources(void)
  * with other system resources.
  */
 late_initcall(pci_mmcfg_late_insert_resources);
+
+/* Add MMCFG information for host bridges */
+int __devinit pci_mmconfig_insert(uint16_t seg, uint8_t start, uint8_t end,
+				  phys_addr_t addr)
+{
+	int rc;
+	struct resource *tmp;
+	struct pci_mmcfg_region *cfg;
+
+	if (start > end)
+		return -EINVAL;
+
+	if (pci_mmcfg_arch_init_failed)
+		return -ENODEV;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg = pci_mmconfig_lookup(seg, start);
+	if (cfg) {
+		if (cfg->end_bus < end)
+			printk(KERN_WARNING FW_BUG PREFIX
+			       "MMCONFIG entry for domain %04x [bus %02x-%02x] "
+			       "partially covers domain %04x [bus %02x-%02x]\n",
+			       seg, start, end,
+			       cfg->segment, cfg->start_bus, cfg->end_bus);
+		mutex_unlock(&pci_mmcfg_lock);
+		return -EEXIST;
+	}
+
+	if (!addr) {
+		mutex_unlock(&pci_mmcfg_lock);
+		return -EINVAL;
+	}
+
+	rc = -EBUSY;
+	cfg = pci_mmconfig_alloc(seg, start, end, addr);
+	if (cfg == NULL) {
+		rc = -ENOMEM;
+	} else if (!pci_mmcfg_check_reserved(cfg, 0)) {
+		printk(KERN_WARNING FW_BUG PREFIX
+		       "MMCONFIG entry for domain %04x [bus %02x-%02x] "
+		       "isn't reserved by firmware\n",
+			seg, start, end);
+	} else {
+		tmp = insert_resource_conflict(&iomem_resource, &cfg->res);
+		if (tmp) {
+			printk(KERN_WARNING PREFIX
+				"MMCONFIG resource %pR for domain %04x "
+				"[bus %02x-%02x] conflicts with resource "
+				"%s %pR\n",
+				&cfg->res, seg, start, end, tmp->name, tmp);
+		} else if (pci_mmcfg_arch_map(cfg)) {
+			printk(KERN_WARNING PREFIX
+				"MMCONFIG fail to map resource %pR for "
+				"domain %04x [bus %02x-%02x]\n",
+				&cfg->res, seg, start, end);
+		} else {
+			list_add_sorted(cfg);
+			cfg = NULL;
+			rc = 0;
+		}
+	}
+
+	if (cfg) {
+		if (cfg->res.parent)
+			release_resource(&cfg->res);
+		kfree(cfg);
+	}
+
+	mutex_unlock(&pci_mmcfg_lock);
+
+	return rc;
+}
+
+/* Delete MMCFG information for host bridges */
+int pci_mmconfig_delete(uint16_t seg, uint8_t start, uint8_t end)
+{
+	struct pci_mmcfg_region *cfg;
+
+	mutex_lock(&pci_mmcfg_lock);
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+		if (cfg->segment == seg && cfg->start_bus == start &&
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
+	mutex_unlock(&pci_mmcfg_lock);
+
+	return -ENOENT;
+}
-- 
1.7.1


