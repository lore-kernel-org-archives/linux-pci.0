Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23446 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab2FUJuG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:50:06 -0400
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
Subject: [PATCH v9 08/11] x86/PCI: simplify pci_mmcfg_late_insert_resources()
Date: Thu, 21 Jun 2012 17:37:00 +0800
Message-ID: <1340271423-4352-9-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reduce redundant code to simplify pci_mmcfg_late_insert_resources().

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 19fc42b..332fabd 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -26,7 +26,6 @@
 #define PREFIX "PCI: "
 
 /* Indicate if the mmcfg resources have been placed into the resource table. */
-static int __initdata pci_mmcfg_resources_inserted;
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
@@ -373,18 +372,6 @@ static int __init pci_mmcfg_check_hostbridge(void)
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
@@ -668,11 +655,7 @@ static void __init __pci_mmcfg_init(int early)
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
 }
@@ -689,15 +672,12 @@ void __init pci_mmcfg_late_init(void)
 
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
@@ -705,7 +685,9 @@ static int __init pci_mmcfg_late_insert_resources(void)
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


