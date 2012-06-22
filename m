Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761236Ab2FVG5b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:57:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3169265pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:57:31 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v10 06/13] x86/PCI: add pci_mmconfig_insert()/delete() for PCI root bridge hotplug
Date: Fri, 22 Jun 2012 14:55:15 +0800
Message-Id: <1340348122-29021-7-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

Introduce pci_mmconfig_insert()/pci_mmconfig_delete(), which will be used
to update MMCFG information when supporting PCI root bridge hotplug.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/pci_x86.h |    4 ++
 arch/x86/pci/mmconfig-shared.c |  109 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 4 deletions(-)

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
index 15a7abf..19fc42b 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -28,6 +28,7 @@
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static int __initdata pci_mmcfg_resources_inserted;
 static bool pci_mmcfg_running_state;
+static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
@@ -92,10 +93,6 @@ static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int segment,
 		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
 	res->name = new->name;
 
-	printk(KERN_INFO PREFIX "MMCONFIG for domain %04x [bus %02x-%02x] at "
-	       "%pR (base %#lx)\n", segment, start, end, &new->res,
-	       (unsigned long) addr);
-
 	return new;
 }
 
@@ -109,6 +106,11 @@ static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
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
@@ -671,6 +673,7 @@ static void __init __pci_mmcfg_init(int early)
 		 * the architecture mmcfg setup could not initialize.
 		 */
 		pci_mmcfg_resources_inserted = 1;
+		pci_mmcfg_arch_init_failed = true;
 	}
 }
 
@@ -713,3 +716,101 @@ static int __init pci_mmcfg_late_insert_resources(void)
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
1.7.9.5

