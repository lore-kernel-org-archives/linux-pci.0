Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:5661 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbdKJRxE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Nov 2017 12:53:04 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/2] powerpc/pci: Unroll two pass loop when scanning bridges
Date: Fri, 10 Nov 2017 19:52:30 +0200
Message-Id: <20171110175230.82522-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
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

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 741f47295188..cf47b1aec4c2 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -104,7 +104,7 @@ EXPORT_SYMBOL_GPL(pci_hp_remove_devices);
  */
 void pci_hp_add_devices(struct pci_bus *bus)
 {
-	int slotno, mode, pass, max;
+	int slotno, mode, max;
 	struct pci_dev *dev;
 	struct pci_controller *phb;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
@@ -133,10 +133,17 @@ void pci_hp_add_devices(struct pci_bus *bus)
 		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
 		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
-		for (pass = 0; pass < 2; pass++) {
-			for_each_pci_bridge(dev, bus)
-				max = pci_scan_bridge(bus, dev, max, pass);
-		}
+		/*
+		 * Scan bridges that are already configured. We don't touch
+		 * them unless they are misconfigured (which will be done in
+		 * the second scan below).
+		 */
+		for_each_pci_bridge(dev, bus)
+			max = pci_scan_bridge(bus, dev, max, 0);
+
+		/* Scan bridges that need to be reconfigured */
+		for_each_pci_bridge(dev, bus)
+			max = pci_scan_bridge(bus, dev, max, 1);
 	}
 	pcibios_finish_adding_to_bus(bus);
 }
-- 
2.14.2
