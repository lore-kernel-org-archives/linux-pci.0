Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5357 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbdJMSfx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Oct 2017 14:35:53 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] PCI: Move pci_hp_add_bridge() to drivers/pci/probe.c
Date: Fri, 13 Oct 2017 21:35:41 +0300
Message-Id: <20171013183548.68283-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is not much point of having a file with a single function in it.
Instead we can just move pci_hp_add_bridge() to drivers/pci/probe.c and
make it available always when PCI core is enabled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/Makefile      |  3 ---
 drivers/pci/hotplug-pci.c | 29 -----------------------------
 drivers/pci/probe.c       | 24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 32 deletions(-)
 delete mode 100644 drivers/pci/hotplug-pci.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 66a21acad952..fa56267fa2c0 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -16,9 +16,6 @@ obj-$(CONFIG_PCIEPORTBUS) += pcie/
 
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
-ifdef CONFIG_HOTPLUG_PCI
-obj-y += hotplug-pci.o
-endif
 
 # Build the PCI MSI interrupt support
 obj-$(CONFIG_PCI_MSI) += msi.o
diff --git a/drivers/pci/hotplug-pci.c b/drivers/pci/hotplug-pci.c
deleted file mode 100644
index c68366cee6b7..000000000000
--- a/drivers/pci/hotplug-pci.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/* Core PCI functionality used only by PCI hotplug */
-
-#include <linux/pci.h>
-#include <linux/export.h>
-#include "pci.h"
-
-int pci_hp_add_bridge(struct pci_dev *dev)
-{
-	struct pci_bus *parent = dev->bus;
-	int pass, busnr, start = parent->busn_res.start;
-	int end = parent->busn_res.end;
-
-	for (busnr = start; busnr <= end; busnr++) {
-		if (!pci_find_bus(pci_domain_nr(parent), busnr))
-			break;
-	}
-	if (busnr-- > end) {
-		printk(KERN_ERR "No bus number available for hot-added bridge %s\n",
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
-EXPORT_SYMBOL_GPL(pci_hp_add_bridge);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cdc2f83c11c5..7302cef51d3f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2735,3 +2735,27 @@ void __init pci_sort_breadthfirst(void)
 {
 	bus_sort_breadthfirst(&pci_bus_type, &pci_sort_bf_cmp);
 }
+
+int pci_hp_add_bridge(struct pci_dev *dev)
+{
+	struct pci_bus *parent = dev->bus;
+	int pass, busnr, start = parent->busn_res.start;
+	int end = parent->busn_res.end;
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
-- 
2.14.2
