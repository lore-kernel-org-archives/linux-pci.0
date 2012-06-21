Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23897 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759198Ab2FUJum (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:50:42 -0400
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
Subject: [PATCH v9 05/11] x86/PCI: add pci_mmconfig_insert()/delete() for PCI root bridge hotplug
Date: Thu, 21 Jun 2012 17:36:57 +0800
Message-ID: <1340271423-4352-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_mmconfig_insert()/pci_mmconfig_delete(), which will be used
to update MMCFG information when supporting PCI root bridge hotplug.

[bhelgaas: KERN_INFO, not KERN_ERR, for missing ACPI PNP0C01/02 reservation]
Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/pci_x86.h |    4 +
 arch/x86/pci/mmconfig-shared.c |  213 ++++++++++++++++++++++++++++++++--------
 2 files changed, 177 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index df898ce..af5018f 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -137,6 +137,10 @@ extern int __init pci_mmcfg_arch_init(void);
 extern void __init pci_mmcfg_arch_free(void);
 extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
 extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+extern int __devinit pci_mmconfig_insert(struct device *dev,
+					 u16 seg, u8 start,
+					 u8 end, phys_addr_t addr);
+extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
 extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
 
 extern struct list_head pci_mmcfg_list;
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0ac97d5..19fc42b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -27,6 +27,8 @@
 
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static int __initdata pci_mmcfg_resources_inserted;
+static bool pci_mmcfg_running_state;
+static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
@@ -91,10 +93,6 @@ static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int segment,
 		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
 	res->name = new->name;
 
-	printk(KERN_INFO PREFIX "MMCONFIG for domain %04x [bus %02x-%02x] at "
-	       "%pR (base %#lx)\n", segment, start, end, &new->res,
-	       (unsigned long) addr);
-
 	return new;
 }
 
@@ -108,6 +106,11 @@ static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
 		mutex_lock(&pci_mmcfg_lock);
 		list_add_sorted(new);
 		mutex_unlock(&pci_mmcfg_lock);
+
+		printk(KERN_INFO PREFIX
+		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
+		       "(base %#lx)\n",
+		       segment, start, end, &new->res, (unsigned long)addr);
 	}
 
 	return new;
@@ -375,14 +378,15 @@ static void __init pci_mmcfg_insert_resources(void)
 	struct pci_mmcfg_region *cfg;
 
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
@@ -418,8 +422,8 @@ static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
 	return AE_OK;
 }
 
-static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
-		void *context, void **rv)
+static acpi_status __devinit find_mboard_resource(acpi_handle handle, u32 lvl,
+						  void *context, void **rv)
 {
 	struct resource *mcfg_res = context;
 
@@ -432,7 +436,7 @@ static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static int __devinit is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 {
 	struct resource mcfg_res;
 
@@ -451,13 +455,15 @@ static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 
 typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
 
-static int __init is_mmconf_reserved(check_reserved_t is_reserved,
-				    struct pci_mmcfg_region *cfg, int with_e820)
+static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
+				    struct pci_mmcfg_region *cfg,
+				    struct device *dev, int with_e820)
 {
 	u64 addr = cfg->res.start;
 	u64 size = resource_size(&cfg->res);
 	u64 old_size = size;
-	int valid = 0, num_buses;
+	int num_buses;
+	char *method = with_e820 ? "E820" : "ACPI motherboard resources";
 
 	while (!is_reserved(addr, addr + size, E820_RESERVED)) {
 		size >>= 1;
@@ -465,49 +471,75 @@ static int __init is_mmconf_reserved(check_reserved_t is_reserved,
 			break;
 	}
 
-	if (size >= (16UL<<20) || size == old_size) {
-		printk(KERN_INFO PREFIX "MMCONFIG at %pR reserved in %s\n",
-		       &cfg->res,
-		       with_e820 ? "E820" : "ACPI motherboard resources");
-		valid = 1;
-
-		if (old_size != size) {
-			/* update end_bus */
-			cfg->end_bus = cfg->start_bus + ((size>>20) - 1);
-			num_buses = cfg->end_bus - cfg->start_bus + 1;
-			cfg->res.end = cfg->res.start +
-			    PCI_MMCFG_BUS_OFFSET(num_buses) - 1;
-			snprintf(cfg->name, PCI_MMCFG_RESOURCE_NAME_LEN,
-				 "PCI MMCONFIG %04x [bus %02x-%02x]",
-				 cfg->segment, cfg->start_bus, cfg->end_bus);
+	if (size < (16UL<<20) && size != old_size)
+		return 0;
+
+	if (dev)
+		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
+			 &cfg->res, method);
+	else
+		printk(KERN_INFO PREFIX
+		       "MMCONFIG at %pR reserved in %s\n",
+		       &cfg->res, method);
+
+	if (old_size != size) {
+		/* update end_bus */
+		cfg->end_bus = cfg->start_bus + ((size>>20) - 1);
+		num_buses = cfg->end_bus - cfg->start_bus + 1;
+		cfg->res.end = cfg->res.start +
+		    PCI_MMCFG_BUS_OFFSET(num_buses) - 1;
+		snprintf(cfg->name, PCI_MMCFG_RESOURCE_NAME_LEN,
+			 "PCI MMCONFIG %04x [bus %02x-%02x]",
+			 cfg->segment, cfg->start_bus, cfg->end_bus);
+
+		if (dev)
+			dev_info(dev,
+				"MMCONFIG "
+				"at %pR (base %#lx) (size reduced!)\n",
+				&cfg->res, (unsigned long) cfg->address);
+		else
 			printk(KERN_INFO PREFIX
-			       "MMCONFIG for %04x [bus%02x-%02x] "
-			       "at %pR (base %#lx) (size reduced!)\n",
-			       cfg->segment, cfg->start_bus, cfg->end_bus,
-			       &cfg->res, (unsigned long) cfg->address);
-		}
+				"MMCONFIG for %04x [bus%02x-%02x] "
+				"at %pR (base %#lx) (size reduced!)\n",
+				cfg->segment, cfg->start_bus, cfg->end_bus,
+				&cfg->res, (unsigned long) cfg->address);
 	}
 
-	return valid;
+	return 1;
 }
 
-static int __devinit pci_mmcfg_check_reserved(struct pci_mmcfg_region *cfg,
-					      int early)
+static int __ref pci_mmcfg_check_reserved(struct device *dev,
+		  struct pci_mmcfg_region *cfg, int early)
 {
 	if (!early && !acpi_disabled) {
-		if (is_mmconf_reserved(is_acpi_reserved, cfg, 0))
+		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
 			return 1;
+
+		if (dev)
+			dev_info(dev, FW_INFO
+				 "MMCONFIG at %pR not reserved in "
+				 "ACPI motherboard resources\n",
+				 &cfg->res);
 		else
-			printk(KERN_ERR FW_BUG PREFIX
+			printk(KERN_INFO FW_INFO PREFIX
 			       "MMCONFIG at %pR not reserved in "
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
 	}
 
+	/*
+	 * e820_all_mapped() is marked as __init.
+	 * All entries from ACPI MCFG table have been checked at boot time.
+	 * For MCFG information constructed from hotpluggable host bridge's
+	 * _CBA method, just assume it's reserved.
+	 */
+	if (pci_mmcfg_running_state)
+		return 1;
+
 	/* Don't try to do this check unless configuration
 	   type 1 is available. how about type 2 ?*/
 	if (raw_pci_ops)
-		return is_mmconf_reserved(e820_all_mapped, cfg, 1);
+		return is_mmconf_reserved(e820_all_mapped, cfg, dev, 1);
 
 	return 0;
 }
@@ -517,7 +549,7 @@ static void __init pci_mmcfg_reject_broken(int early)
 	struct pci_mmcfg_region *cfg;
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		if (pci_mmcfg_check_reserved(cfg, early) == 0) {
+		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
 			printk(KERN_INFO PREFIX "not using MMCONFIG\n");
 			free_all_mmcfg();
 			return;
@@ -641,6 +673,7 @@ static void __init __pci_mmcfg_init(int early)
 		 * the architecture mmcfg setup could not initialize.
 		 */
 		pci_mmcfg_resources_inserted = 1;
+		pci_mmcfg_arch_init_failed = true;
 	}
 }
 
@@ -656,6 +689,8 @@ void __init pci_mmcfg_late_init(void)
 
 static int __init pci_mmcfg_late_insert_resources(void)
 {
+	pci_mmcfg_running_state = true;
+
 	/*
 	 * If resources are already inserted or we are not using MMCONFIG,
 	 * don't insert the resources.
@@ -681,3 +716,101 @@ static int __init pci_mmcfg_late_insert_resources(void)
  * with other system resources.
  */
 late_initcall(pci_mmcfg_late_insert_resources);
+
+/* Add MMCFG information for host bridges */
+int __devinit pci_mmconfig_insert(struct device *dev,
+				  u16 seg, u8 start, u8 end,
+				  phys_addr_t addr)
+{
+	int rc;
+	struct resource *tmp = NULL;
+	struct pci_mmcfg_region *cfg;
+
+	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
+		return -ENODEV;
+
+	if (start > end)
+		return -EINVAL;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg = pci_mmconfig_lookup(seg, start);
+	if (cfg) {
+		if (cfg->end_bus < end)
+			dev_info(dev, FW_INFO
+				 "MMCONFIG for "
+				 "domain %04x [bus %02x-%02x] "
+				 "only partially covers this bridge\n",
+				  cfg->segment, cfg->start_bus, cfg->end_bus);
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
+		dev_warn(dev, "fail to add MMCONFIG (out of memory)\n");
+		rc = -ENOMEM;
+	} else if (!pci_mmcfg_check_reserved(dev, cfg, 0)) {
+		dev_warn(dev, FW_BUG "MMCONFIG %pR isn't reserved\n",
+			 &cfg->res);
+	} else {
+		/* Insert resource if it's not in boot stage */
+		if (pci_mmcfg_running_state)
+			tmp = insert_resource_conflict(&iomem_resource,
+						       &cfg->res);
+
+		if (tmp) {
+			dev_warn(dev,
+				 "MMCONFIG %pR conflicts with "
+				 "%s %pR\n",
+				 &cfg->res, tmp->name, tmp);
+		} else if (pci_mmcfg_arch_map(cfg)) {
+			dev_warn(dev, "fail to map MMCONFIG %pR.\n",
+				 &cfg->res);
+		} else {
+			list_add_sorted(cfg);
+			dev_info(dev, "MMCONFIG at %pR (base %#lx)\n",
+				 &cfg->res, (unsigned long)addr);
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
+int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
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


