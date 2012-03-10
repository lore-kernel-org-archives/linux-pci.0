Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 06/37] PCI: Move back pci_rescan_bus()
Date: Fri,  9 Mar 2012 23:00:06 -0800
Message-Id: <1331362837-10740-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we have pci_assign_unassigned_bus_resources() in place.

So move back pci_rescan_bus to probe.c where it should be.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c     |   21 +++++++++++++++++++++
 drivers/pci/setup-bus.c |   22 ----------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 67071b0..0d779f6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2054,6 +2054,27 @@ unsigned int __ref pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+/**
+ * pci_rescan_bus - scan a PCI bus for devices.
+ * @bus: PCI bus to scan
+ *
+ * Scan a PCI bus and child buses for new devices, adds them,
+ * and enables them.
+ *
+ * Returns the max number of subordinate bus discovered.
+ */
+unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
+{
+	unsigned int max;
+
+	max = pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
+
+	return max;
+}
+EXPORT_SYMBOL_GPL(pci_rescan_bus);
+
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6443c81..f35a679 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1507,25 +1507,3 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 
 	pci_enable_bridges(bus);
 }
-#ifdef CONFIG_HOTPLUG
-/**
- * pci_rescan_bus - scan a PCI bus for devices.
- * @bus: PCI bus to scan
- *
- * Scan a PCI bus and child buses for new devices, adds them,
- * and enables them.
- *
- * Returns the max number of subordinate bus discovered.
- */
-unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
-{
-	unsigned int max;
-
-	max = pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
-	pci_bus_add_devices(bus);
-
-	return max;
-}
-EXPORT_SYMBOL_GPL(pci_rescan_bus);
-#endif
-- 
1.7.7

