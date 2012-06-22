Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42860 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761373Ab2FVG5W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:57:22 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1941745dad.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:57:22 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@hauwei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v10 05/13] x86/PCI: prepare pci_mmcfg_check_reserved() to be called at runtime
Date: Fri, 22 Jun 2012 14:55:14 +0800
Message-Id: <1340348122-29021-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@hauwei.com>

From: Jiang Liu <jiang.liu@hauwei.com>

Prepare function pci_mmcfg_check_reserved() to be called at runtime
for PCI host bridge hot-plugging

[bhelgaas: KERN_INFO, not KERN_ERR, for missing ACPI PNP0C01/02 reservation]

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |  104 ++++++++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 36 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0ac97d5..15a7abf 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -27,6 +27,7 @@
 
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static int __initdata pci_mmcfg_resources_inserted;
+static bool pci_mmcfg_running_state;
 static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
@@ -375,14 +376,15 @@ static void __init pci_mmcfg_insert_resources(void)
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
@@ -418,8 +420,8 @@ static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
 	return AE_OK;
 }
 
-static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
-		void *context, void **rv)
+static acpi_status __devinit find_mboard_resource(acpi_handle handle, u32 lvl,
+						  void *context, void **rv)
 {
 	struct resource *mcfg_res = context;
 
@@ -432,7 +434,7 @@ static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static int __devinit is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 {
 	struct resource mcfg_res;
 
@@ -451,13 +453,15 @@ static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 
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
@@ -465,49 +469,75 @@ static int __init is_mmconf_reserved(check_reserved_t is_reserved,
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
@@ -517,7 +547,7 @@ static void __init pci_mmcfg_reject_broken(int early)
 	struct pci_mmcfg_region *cfg;
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		if (pci_mmcfg_check_reserved(cfg, early) == 0) {
+		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
 			printk(KERN_INFO PREFIX "not using MMCONFIG\n");
 			free_all_mmcfg();
 			return;
@@ -656,6 +686,8 @@ void __init pci_mmcfg_late_init(void)
 
 static int __init pci_mmcfg_late_insert_resources(void)
 {
+	pci_mmcfg_running_state = true;
+
 	/*
 	 * If resources are already inserted or we are not using MMCONFIG,
 	 * don't insert the resources.
-- 
1.7.9.5

