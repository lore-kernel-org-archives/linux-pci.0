Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761253Ab2FVG6W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:58:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3169265pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:58:22 -0700 (PDT)
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
Subject: [PATCH v10 13/13] x86/PCI: use pr_level() to replace printk(KERN_LEVEL)
Date: Fri, 22 Jun 2012 14:55:22 +0800
Message-Id: <1340348122-29021-14-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

Script checkpatch.pl recommends to replace printk(KERN_LVL) with pr_lvl(),
so do it.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   21 +++++++++------------
 arch/x86/pci/mmconfig_64.c     |    3 +--
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index ffe72b9..937bcec 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -106,7 +106,7 @@ static __init struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
 		list_add_sorted(new);
 		mutex_unlock(&pci_mmcfg_lock);
 
-		printk(KERN_INFO PREFIX
+		pr_info(PREFIX
 		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
 		       "(base %#lx)\n",
 		       segment, start, end, &new->res, (unsigned long)addr);
@@ -362,8 +362,7 @@ static int __init pci_mmcfg_check_hostbridge(void)
 			name = pci_mmcfg_probes[i].probe();
 
 		if (name)
-			printk(KERN_INFO PREFIX "%s with MMCONFIG support\n",
-			       name);
+			pr_info(PREFIX "%s with MMCONFIG support\n", name);
 	}
 
 	/* some end_bus_number is crazy, fix it */
@@ -465,8 +464,7 @@ static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
 		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
 			 &cfg->res, method);
 	else
-		printk(KERN_INFO PREFIX
-		       "MMCONFIG at %pR reserved in %s\n",
+		pr_info(PREFIX "MMCONFIG at %pR reserved in %s\n",
 		       &cfg->res, method);
 
 	if (old_size != size) {
@@ -485,7 +483,7 @@ static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				"at %pR (base %#lx) (size reduced!)\n",
 				&cfg->res, (unsigned long) cfg->address);
 		else
-			printk(KERN_INFO PREFIX
+			pr_info(PREFIX
 				"MMCONFIG for %04x [bus%02x-%02x] "
 				"at %pR (base %#lx) (size reduced!)\n",
 				cfg->segment, cfg->start_bus, cfg->end_bus,
@@ -508,7 +506,7 @@ static int __ref pci_mmcfg_check_reserved(struct device *dev,
 				 "ACPI motherboard resources\n",
 				 &cfg->res);
 		else
-			printk(KERN_INFO FW_INFO PREFIX
+			pr_info(FW_INFO PREFIX
 			       "MMCONFIG at %pR not reserved in "
 			       "ACPI motherboard resources\n",
 			       &cfg->res);
@@ -537,7 +535,7 @@ static void __init pci_mmcfg_reject_broken(int early)
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
-			printk(KERN_INFO PREFIX "not using MMCONFIG\n");
+			pr_info(PREFIX "not using MMCONFIG\n");
 			free_all_mmcfg();
 			return;
 		}
@@ -562,7 +560,7 @@ static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 			return 0;
 	}
 
-	printk(KERN_ERR PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
+	pr_err(PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
 	       "is above 4GB, ignored\n", cfg->pci_segment,
 	       cfg->start_bus_number, cfg->end_bus_number, cfg->address);
 	return -EINVAL;
@@ -589,7 +587,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 		i -= sizeof(struct acpi_mcfg_allocation);
 	};
 	if (entries == 0) {
-		printk(KERN_ERR PREFIX "MMCONFIG has no entries\n");
+		pr_err(PREFIX "MMCONFIG has no entries\n");
 		return -ENODEV;
 	}
 
@@ -603,8 +601,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 
 		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
 				   cfg->end_bus_number, cfg->address) == NULL) {
-			printk(KERN_WARNING PREFIX
-			       "no memory for MCFG entries\n");
+			pr_warn(PREFIX "no memory for MCFG entries\n");
 			free_all_mmcfg();
 			return -ENOMEM;
 		}
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index c206521..d4ebd07 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -137,8 +137,7 @@ int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
 {
 	cfg->virt = mcfg_ioremap(cfg);
 	if (!cfg->virt) {
-		printk(KERN_ERR PREFIX "can't map MMCONFIG at %pR\n",
-		       &cfg->res);
+		pr_err(PREFIX "can't map MMCONFIG at %pR\n", &cfg->res);
 		return -ENOMEM;
 	}
 
-- 
1.7.9.5

