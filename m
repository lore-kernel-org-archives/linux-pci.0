Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([58.251.152.67]:50979 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107Ab2EZJyd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2012 05:54:33 -0400
Received: from huawei.com (szxga04-in [172.24.2.12])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M005O2JJTOV@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:05 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga04-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M00330JJT65@szxga04-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:55:05 +0800 (CST)
Date: Sat, 26 May 2012 17:54:02 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v7 09/10] PCI, x86: simplify pci_mmcfg_late_insert_resources()
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
Message-id: <1338026043-3968-10-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reduce redundant code to simplify pci_mmcfg_late_insert_resources().

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index e80b5c2..77f0db2 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -27,7 +27,6 @@
 #define PREFIX "PCI: "
 
 /* Indicate if the mmcfg resources have been placed into the resource table. */
-static int __initdata pci_mmcfg_resources_inserted;
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
@@ -374,18 +373,6 @@ static int __init pci_mmcfg_check_hostbridge(void)
 	return !list_empty(&pci_mmcfg_list);
 }
 
-static void __init pci_mmcfg_insert_resources(void)
-{
-	struct pci_mmcfg_region *cfg;
-
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		if (!cfg->res.parent)
-			insert_resource(&iomem_resource, &cfg->res);
-
-	/* Mark that the resources have been inserted. */
-	pci_mmcfg_resources_inserted = 1;
-}
-
 static acpi_status __devinit check_mcfg_resource(struct acpi_resource *res,
 						 void *data)
 {
@@ -686,11 +673,7 @@ static void __init __pci_mmcfg_init(int early)
 	if (pci_mmcfg_arch_init())
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 	else {
-		/*
-		 * Signal not to attempt to insert mmcfg resources because
-		 * the architecture mmcfg setup could not initialize.
-		 */
-		pci_mmcfg_resources_inserted = 1;
+		free_all_mmcfg();
 		pci_mmcfg_arch_init_failed = true;
 	}
 
@@ -715,15 +698,12 @@ void __init pci_mmcfg_late_init(void)
 
 static int __init pci_mmcfg_late_insert_resources(void)
 {
+	struct pci_mmcfg_region *cfg;
+
 	pci_mmcfg_running_state = true;
 
-	/*
-	 * If resources are already inserted or we are not using MMCONFIG,
-	 * don't insert the resources.
-	 */
-	if ((pci_mmcfg_resources_inserted == 1) ||
-	    (pci_probe & PCI_PROBE_MMCONF) == 0 ||
-	    list_empty(&pci_mmcfg_list))
+	/* If we are not using MMCONFIG, don't insert the resources. */
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 1;
 
 	/*
@@ -731,7 +711,9 @@ static int __init pci_mmcfg_late_insert_resources(void)
 	 * marked so it won't cause request errors when __request_region is
 	 * called.
 	 */
-	pci_mmcfg_insert_resources();
+	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+		if (!cfg->res.parent)
+			insert_resource(&iomem_resource, &cfg->res);
 
 	return 0;
 }
-- 
1.7.1


