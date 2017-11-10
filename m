Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2696 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753054AbdKJRxE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Nov 2017 12:53:04 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge() helper
Date: Fri, 10 Nov 2017 19:52:29 +0200
Message-Id: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

...which makes code slightly cleaner.

Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 7 ++-----
 arch/powerpc/kernel/pci_of_scan.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 2d71269e7dc1..741f47295188 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -134,11 +134,8 @@ void pci_hp_add_devices(struct pci_bus *bus)
 		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		for (pass = 0; pass < 2; pass++) {
-			list_for_each_entry(dev, &bus->devices, bus_list) {
-				if (pci_is_bridge(dev))
-					max = pci_scan_bridge(bus, dev,
-							      max, pass);
-			}
+			for_each_pci_bridge(dev, bus)
+				max = pci_scan_bridge(bus, dev, max, pass);
 		}
 	}
 	pcibios_finish_adding_to_bus(bus);
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 0d790f8432d2..8bdaa2a6fa62 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -369,11 +369,8 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (pci_is_bridge(dev)) {
-			of_scan_pci_bridge(dev);
-		}
-	}
+	for_each_pci_bridge(dev, bus)
+		of_scan_pci_bridge(dev);
 }
 
 /**
-- 
2.14.2
