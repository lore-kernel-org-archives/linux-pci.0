Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758476Ab3GaDb7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Jul 2013 23:31:59 -0400
Subject: [RFC PATCH 4/7] pci: Add slot reset option to pci_dev_reset
To: linux-pci@vger.kernel.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, indou.takao@jp.fujitsu.com
Date: Tue, 30 Jul 2013 21:31:54 -0600
Message-ID: <20130731033154.31931.36203.stgit@bling.home>
In-Reply-To: <20130731031316.31931.56751.stgit@bling.home>
References: <20130731031316.31931.56751.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the hotplug controller provides a way to reset a slot, use that
before a direct parent bus reset.  Like the bus reset option, this is
only available when a single pci_dev occupies the slot.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bfd629c..db90692 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pci_hotplug.h>
 #include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
 #include "pci.h"
@@ -3317,6 +3318,35 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
+{
+	int rc = -ENOTTY;
+
+	if (!hotplug || !try_module_get(hotplug->ops->owner))
+		return rc;
+
+	if (hotplug->ops->reset_slot)
+		rc = hotplug->ops->reset_slot(hotplug, probe);
+
+	module_put(hotplug->ops->owner);
+
+	return rc;
+}
+
+static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
+{
+	struct pci_dev *pdev;
+
+	if (dev->subordinate || !dev->slot)
+		return -ENOTTY;
+
+	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
+		if (pdev != dev && pdev->slot == dev->slot)
+			return -ENOTTY;
+
+	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
+}
+
 static int __pci_dev_reset(struct pci_dev *dev, int probe)
 {
 	int rc;
@@ -3339,6 +3369,10 @@ static int __pci_dev_reset(struct pci_dev *dev, int probe)
 	if (rc != -ENOTTY)
 		goto done;
 
+	rc = pci_dev_reset_slot_function(dev, probe);
+	if (rc != -ENOTTY)
+		goto done;
+
 	rc = pci_parent_bus_reset(dev, probe);
 done:
 	return rc;

