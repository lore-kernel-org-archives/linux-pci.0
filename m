Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24918 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154Ab3GVViG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:38:06 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 4/7] PCI: Introduce enable_local to prepare per root bus handling
Date: Mon, 22 Jul 2013 14:37:15 -0700
Message-Id: <1374529038-14311-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add enable_local to prepare assign unassigned resource
for per root bus.

Per Bjorn, separate it from big patch that handing assign_unssigned per root bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 87687a5..eddc6e1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1354,9 +1354,9 @@ void __init pci_realloc_get_opt(char *str)
 	else if (!strncmp(str, "on", 2))
 		pci_realloc_enable = user_enabled;
 }
-static bool __init pci_realloc_enabled(void)
+static bool __init pci_realloc_enabled(enum enable_type enable)
 {
-	return pci_realloc_enable >= user_enabled;
+	return enable >= user_enabled;
 }
 
 #if defined(CONFIG_PCI_IOV) && defined(CONFIG_PCI_REALLOC_ENABLE_AUTO)
@@ -1383,25 +1383,25 @@ static int __init check_unassigned_resources(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void  __init pci_realloc_detect(void)
+static enum enable_type __init pci_realloc_detect(struct pci_bus *bus,
+			 enum enable_type enable_local)
 {
 	int unassigned = 0;
-	struct pci_bus *bus;
 
-	if (pci_realloc_enable != undefined)
-		return;
+	if (enable_local != undefined)
+		return enable_local;
 
-	list_for_each_entry(bus, &pci_root_buses, node) {
-		pci_walk_bus(bus, check_unassigned_resources, &unassigned);
-		if (unassigned) {
-			pci_realloc_enable = auto_enabled;
-			return;
-		}
-	}
+	pci_walk_bus(bus, check_unassigned_resources, &unassigned);
+	if (unassigned)
+		return auto_enabled;
+
+	return enable_local;
 }
 #else
-static void __init pci_realloc_detect(void)
+static enum enable_type __init pci_realloc_detect(struct pci_bus *bus,
+			 enum enable_type enable_local)
 {
+	return enable_local;
 }
 #endif
 
@@ -1424,10 +1424,12 @@ pci_assign_unassigned_resources(void)
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
 				  IORESOURCE_PREFETCH;
 	int pci_try_num = 1;
+	enum enable_type enable_local = pci_realloc_enable;
+
+	list_for_each_entry(bus, &pci_root_buses, node)
+		enable_local = pci_realloc_detect(bus, enable_local);
 
-	/* don't realloc if asked to do so */
-	pci_realloc_detect();
-	if (pci_realloc_enabled()) {
+	if (pci_realloc_enabled(enable_local)) {
 		int max_depth = pci_get_max_depth();
 
 		pci_try_num = max_depth + 1;
@@ -1459,9 +1461,9 @@ again:
 		goto enable_and_dump;
 
 	if (tried_times >= pci_try_num) {
-		if (pci_realloc_enable == undefined)
+		if (enable_local == undefined)
 			printk(KERN_INFO "Some PCI device resources are unassigned, try booting with pci=realloc\n");
-		else if (pci_realloc_enable == auto_enabled)
+		else if (enable_local == auto_enabled)
 			printk(KERN_INFO "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
 
 		free_list(&fail_head);
-- 
1.8.1.4

