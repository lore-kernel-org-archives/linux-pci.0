Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:50549 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663Ab2EGU3m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 16:29:42 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 7/7] PCI, hotplug: remove pci_do_scan_bus()
Date: Mon,  7 May 2012 13:29:16 -0700
Message-Id: <1336422556-4124-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
References: <1336422556-4124-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now alll open code calling with that are gone.

So could get rid of pci_do_scan_bus()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug-pci.c |   15 ---------------
 drivers/pci/pci.h         |    1 -
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug-pci.c b/drivers/pci/hotplug-pci.c
index 1da0cae..01eae34 100644
--- a/drivers/pci/hotplug-pci.c
+++ b/drivers/pci/hotplug-pci.c
@@ -27,18 +27,3 @@ int __ref pci_hp_add_bridge(struct pci_dev *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
-
-unsigned int __devinit pci_do_scan_bus(struct pci_bus *bus)
-{
-	unsigned int max;
-
-	max = pci_scan_child_bus(bus);
-
-	/*
-	 * Make the discovered devices available.
-	 */
-	pci_bus_add_devices(bus);
-
-	return max;
-}
-EXPORT_SYMBOL(pci_do_scan_bus);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f3e14ce..1c56ea8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -125,7 +125,6 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
-extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
 
 #ifdef HAVE_PCI_LEGACY
 extern void pci_create_legacy_files(struct pci_bus *bus);
-- 
1.7.7

