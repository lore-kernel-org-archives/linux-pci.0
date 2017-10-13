Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12752 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbdJMSgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Oct 2017 14:36:54 -0400
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
Subject: [PATCH v2 2/8] PCI: Open-code the two pass loop when scanning bridges
Date: Fri, 13 Oct 2017 21:35:42 +0300
Message-Id: <20171013183548.68283-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current scanning code is really hard to understand because it calls
the same function in a loop where pass value is changed without any
comments explaining it:

  for (pass = 0; pass < 2; pass++)
  	for_each_pci_bridge(dev, bus)
  		max = pci_scan_bridge(bus, dev, max, pass);

Unfamiliar reader cannot tell easily what is the purpose of this loop
without looking at internals of pci_scan_bridge().

In order to make this bit easier to understand, open-code the loop in
pci_scan_child_bus() and pci_hp_add_bridge() with added comments.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7302cef51d3f..107052f1dad9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2398,7 +2398,7 @@ void __weak pcibios_fixup_bus(struct pci_bus *bus)
 
 unsigned int pci_scan_child_bus(struct pci_bus *bus)
 {
-	unsigned int devfn, pass, max = bus->busn_res.start;
+	unsigned int devfn, max = bus->busn_res.start;
 	struct pci_dev *dev;
 
 	dev_dbg(&bus->dev, "scanning bus\n");
@@ -2420,9 +2420,17 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		bus->is_added = 1;
 	}
 
-	for (pass = 0; pass < 2; pass++)
-		for_each_pci_bridge(dev, bus)
-			max = pci_scan_bridge(bus, dev, max, pass);
+	/*
+	 * Scan bridges that are already configured. We don't touch them
+	 * unless they are misconfigured (which will be done in the second
+	 * scan below).
+	 */
+	for_each_pci_bridge(dev, bus)
+		max = pci_scan_bridge(bus, dev, max, 0);
+
+	/* Scan bridges that need to be reconfigured */
+	for_each_pci_bridge(dev, bus)
+		max = pci_scan_bridge(bus, dev, max, 1);
 
 	/*
 	 * Make sure a hotplug bridge has at least the minimum requested
@@ -2739,7 +2747,7 @@ void __init pci_sort_breadthfirst(void)
 int pci_hp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
-	int pass, busnr, start = parent->busn_res.start;
+	int busnr, start = parent->busn_res.start;
 	int end = parent->busn_res.end;
 
 	for (busnr = start; busnr <= end; busnr++) {
@@ -2751,8 +2759,13 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 				pci_name(dev));
 		return -1;
 	}
-	for (pass = 0; pass < 2; pass++)
-		busnr = pci_scan_bridge(parent, dev, busnr, pass);
+
+	/* Scan bridges that are already configured */
+	busnr = pci_scan_bridge(parent, dev, busnr, 0);
+
+	/* Scan bridges that need to be reconfigured */
+	pci_scan_bridge(parent, dev, busnr, 1);
+
 	if (!dev->subordinate)
 		return -1;
 
-- 
2.14.2
