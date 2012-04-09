Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40501 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab2DIQZd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 12:25:33 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2 1/6] PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
Date: Tue, 10 Apr 2012 00:22:43 +0800
Message-Id: <1333988568-11282-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split out pci_mmcfg_check_reserved() for code reuse, which will be used
when supporting PCI host bridge hotplug.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 arch/x86/pci/mmconfig-shared.c |   51 +++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 301e325..f799949 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -474,39 +474,38 @@ static int __init is_mmconf_reserved(check_reserved_t is_reserved,
 	return valid;
 }
 
+static int __devinit pci_mmcfg_check_reserved(struct pci_mmcfg_region *cfg,
+					      int early)
+{
+	if (!early && !acpi_disabled) {
+		if (is_mmconf_reserved(is_acpi_reserved, cfg, 0))
+			return 1;
+		else
+			printk(KERN_ERR FW_BUG PREFIX
+			       "MMCONFIG at %pR not reserved in "
+			       "ACPI motherboard resources\n",
+			       &cfg->res);
+	}
+
+	/* Don't try to do this check unless configuration
+	   type 1 is available. how about type 2 ?*/
+	if (raw_pci_ops)
+		return is_mmconf_reserved(e820_all_mapped, cfg, 1);
+
+	return 0;
+}
+
 static void __init pci_mmcfg_reject_broken(int early)
 {
 	struct pci_mmcfg_region *cfg;
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		int valid = 0;
-
-		if (!early && !acpi_disabled) {
-			valid = is_mmconf_reserved(is_acpi_reserved, cfg, 0);
-
-			if (valid)
-				continue;
-			else
-				printk(KERN_ERR FW_BUG PREFIX
-				       "MMCONFIG at %pR not reserved in "
-				       "ACPI motherboard resources\n",
-				       &cfg->res);
+		if (pci_mmcfg_check_reserved(cfg, early) == 0) {
+			printk(KERN_INFO PREFIX "not using MMCONFIG\n");
+			free_all_mmcfg();
+			return;
 		}
-
-		/* Don't try to do this check unless configuration
-		   type 1 is available. how about type 2 ?*/
-		if (raw_pci_ops)
-			valid = is_mmconf_reserved(e820_all_mapped, cfg, 1);
-
-		if (!valid)
-			goto reject;
 	}
-
-	return;
-
-reject:
-	printk(KERN_INFO PREFIX "not using MMCONFIG\n");
-	free_all_mmcfg();
 }
 
 static int __initdata known_bridge;
-- 
1.7.5.4

