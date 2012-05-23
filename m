Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:34469 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab2EWDwJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 23:52:09 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G0053TIPVL6@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:32 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G00B7DIPPK7@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:31 +0800 (CST)
Date: Wed, 23 May 2012 11:50:26 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 9/9] PCI, x86: simplify pci_mmcfg_late_insert_resources()
In-reply-to: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <1337745026-1180-10-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

Reduce redundant code to simplify pci_mmcfg_late_insert_resources().

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/pci/mmconfig-shared.c |   32 +++++++-------------------------
 1 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index a7a2efd..01a775f 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -27,7 +27,6 @@
 #define PREFIX "PCI: "
 
 /* Indicate if the mmcfg resources have been placed into the resource table. */
-static int __initdata pci_mmcfg_resources_inserted;
 static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
 
@@ -372,22 +371,6 @@ static int __init pci_mmcfg_check_hostbridge(void)
 	return !list_empty(&pci_mmcfg_list);
 }
 
-static void __init pci_mmcfg_insert_resources(void)
-{
-	struct pci_mmcfg_region *cfg;
-
-	/*
-	 * Insert resources for MMCFG items if the resource hasn't been
-	 * inserted by pci_mmconfig_insert() yet.
-	 */
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
@@ -670,11 +653,7 @@ static void __init __pci_mmcfg_init(int early)
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
 
@@ -699,12 +678,13 @@ void __init pci_mmcfg_late_init(void)
 
 static int __init pci_mmcfg_late_insert_resources(void)
 {
+	struct pci_mmcfg_region *cfg;
+
 	/*
 	 * If resources are already inserted or we are not using MMCONFIG,
 	 * don't insert the resources.
 	 */
-	if ((pci_mmcfg_resources_inserted == 1) ||
-	    (pci_probe & PCI_PROBE_MMCONF) == 0 ||
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0 ||
 	    list_empty(&pci_mmcfg_list))
 		return 1;
 
@@ -713,7 +693,9 @@ static int __init pci_mmcfg_late_insert_resources(void)
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


