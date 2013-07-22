Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20812 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab3GVVhx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 17:37:53 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 2/7] PCI: Use pci_walk_bus to detect unassigned resources
Date: Mon, 22 Jul 2013 14:37:13 -0700
Message-Id: <1374529038-14311-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
References: <1374529038-14311-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per Bjorn, use pci_walk_bus instead of for_each_pci_dev or
calling pci_realloc_detect() recursively, that will make code more readable.

Per Bjorn, separate it from big patch that handing assign_unssigned per root bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7de30e3..ec93aa0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1359,30 +1359,46 @@ static bool __init pci_realloc_enabled(void)
 	return pci_realloc_enable >= user_enabled;
 }
 
-static void __init pci_realloc_detect(void)
-{
 #if defined(CONFIG_PCI_IOV) && defined(CONFIG_PCI_REALLOC_ENABLE_AUTO)
-	struct pci_dev *dev = NULL;
+static int __init check_unassigned_resources(struct pci_dev *dev, void *data)
+{
+	int i;
+	int *unassigned = data;
 
-	if (pci_realloc_enable != undefined)
-		return;
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		struct resource *r = &dev->resource[i];
 
-	for_each_pci_dev(dev) {
-		int i;
+		/* Not assigned, or rejected by kernel ? */
+		if (r->flags && !r->start) {
+			(*unassigned)++;
+			return 1; /* return early from pci_walk_bus */
+		}
+	}
 
-		for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
-			struct resource *r = &dev->resource[i];
+	return 0;
+}
 
-			/* Not assigned, or rejected by kernel ? */
-			if (r->flags && !r->start) {
-				pci_realloc_enable = auto_enabled;
+static void  __init pci_realloc_detect(void)
+{
+	int unassigned = 0;
+	struct pci_bus *bus;
 
-				return;
-			}
+	if (pci_realloc_enable != undefined)
+		return;
+
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		pci_walk_bus(bus, check_unassigned_resources, &unassigned);
+		if (unassigned) {
+			pci_realloc_enable = auto_enabled;
+			return;
 		}
 	}
-#endif
 }
+#else
+static void __init pci_realloc_detect(void)
+{
+}
+#endif
 
 /*
  * first try will not touch pci bridge res
-- 
1.8.1.4

