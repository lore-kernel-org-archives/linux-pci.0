Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:18058 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757668Ab2EGU3j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:39 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/7] PCI, pciehp: Separate pci_hp_add_bridge()
Date: Mon,  7 May 2012 13:29:10 -0700
Message-Id: <1336422556-4124-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
References: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Will use it for other pci hp hotplug support

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug-pci.c        |   23 +++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_pci.c |   28 ++--------------------------
 drivers/pci/pci.h                |    1 +
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug-pci.c b/drivers/pci/hotplug-pci.c
index d3509cd..1da0cae 100644
--- a/drivers/pci/hotplug-pci.c
+++ b/drivers/pci/hotplug-pci.c
@@ -4,6 +4,29 @@
 #include <linux/export.h>
 #include "pci.h"
 
+int __ref pci_hp_add_bridge(struct pci_dev *dev)
+{
+	struct pci_bus *parent = dev->bus;
+	int pass, busnr, start = parent->secondary;
+	int end = parent->subordinate;
+
+	for (busnr = start; busnr <= end; busnr++) {
+		if (!pci_find_bus(pci_domain_nr(parent), busnr))
+			break;
+	}
+	if (busnr-- > end) {
+		printk(KERN_ERR "No bus number available for hot-added bridge %s\n",
+				pci_name(dev));
+		return -1;
+	}
+	for (pass = 0; pass < 2; pass++)
+		busnr = pci_scan_bridge(parent, dev, busnr, pass);
+	if (!dev->subordinate)
+		return -1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
 
 unsigned int __devinit pci_do_scan_bus(struct pci_bus *bus)
 {
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 47d9dc0..09cecaf 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -34,29 +34,6 @@
 #include "../pci.h"
 #include "pciehp.h"
 
-static int __ref pciehp_add_bridge(struct pci_dev *dev)
-{
-	struct pci_bus *parent = dev->bus;
-	int pass, busnr, start = parent->secondary;
-	int end = parent->subordinate;
-
-	for (busnr = start; busnr <= end; busnr++) {
-		if (!pci_find_bus(pci_domain_nr(parent), busnr))
-			break;
-	}
-	if (busnr-- > end) {
-		err("No bus number available for hot-added bridge %s\n",
-				pci_name(dev));
-		return -1;
-	}
-	for (pass = 0; pass < 2; pass++)
-		busnr = pci_scan_bridge(parent, dev, busnr, pass);
-	if (!dev->subordinate)
-		return -1;
-
-	return 0;
-}
-
 int pciehp_configure_device(struct slot *p_slot)
 {
 	struct pci_dev *dev;
@@ -85,9 +62,8 @@ int pciehp_configure_device(struct slot *p_slot)
 		if (!dev)
 			continue;
 		if ((dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) ||
-				(dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)) {
-			pciehp_add_bridge(dev);
-		}
+				(dev->hdr_type == PCI_HEADER_TYPE_CARDBUS))
+			pci_hp_add_bridge(dev);
 		pci_dev_put(dev);
 	}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e494347..f3e14ce 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -124,6 +124,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 #endif
 
 /* Functions for PCI Hotplug drivers to use */
+int pci_hp_add_bridge(struct pci_dev *dev);
 extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
 
 #ifdef HAVE_PCI_LEGACY
-- 
1.7.7

