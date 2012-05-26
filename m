Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:38505 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2EZJ4M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2012 05:56:12 -0400
Received: from huawei.com (szxga05-in [172.24.2.49])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M00L25JJOJS@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:00 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M000N2JJO8J@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:00 +0800 (CST)
Date: Sat, 26 May 2012 17:53:54 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v7 01/10] PCI, x86: split out pci_mmcfg_check_reserved() for
 code reuse
In-reply-to: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Message-id: <1338026043-3968-2-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split out pci_mmcfg_check_reserved() for code reuse, which will be used
when supporting PCI host bridge hotplug.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
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
1.7.1


