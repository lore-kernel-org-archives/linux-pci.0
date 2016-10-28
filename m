Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:45277 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938588AbcJ1IyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2016 04:54:07 -0400
Message-Id: <3adde3ae2d6350fed9ad8b484bdd1344adce2cc5.1477611126.git.lukas@wunner.de>
In-Reply-To: <cover.1477611126.git.lukas@wunner.de>
References: <cover.1477611126.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 28 Oct 2016 10:52:06 +0200
Subject: [PATCH v2 5/9] PCI: Consolidate conditions to allow runtime PM on
 PCIe ports
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The conditions to allow runtime PM on PCIe ports are currently spread
across two different files:  The condition relating to hotplug ports is
located in portdrv_pci.c whereas all other conditions are located in
pci.c.

Consolidate all conditions in a single place in pci.c, thus making it
easier to follow the logic and amend conditions down the road.

Note that the condition relating to hotplug ports is inserted *before*
the condition relating to the "pcie_port_pm=force" command line option,
so runtime PM is not afforded to hotplug ports even if this option is
given.  That's exactly how the code behaved up until now.  If this is
not desired, the ordering of the conditions can simply be reversed.

No functional change intended.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c              | 11 +++++++++++
 drivers/pci/pcie/portdrv_pci.c | 12 ++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 854d185..a19056e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2239,6 +2239,17 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	case PCI_EXP_TYPE_DOWNSTREAM:
 		if (pci_bridge_d3_disable)
 			return false;
+
+		/*
+		 * Hotplug interrupts cannot be delivered if the link is down,
+		 * so parents of a hotplug port must stay awake. In addition,
+		 * Hotplug ports handled by firmware in System Management Mode
+		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
+		 * For simplicity, disallow in general for now.
+		 */
+		if (bridge->is_hotplug_bridge)
+			return false;
+
 		if (pci_bridge_d3_force)
 			return true;
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 1ae712c..8aa3f14 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -150,15 +150,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 	pci_save_state(dev);
 
-	/*
-	 * Prevent runtime PM if the port is advertising support for PCIe
-	 * hotplug.  Otherwise the BIOS hotplug SMI code might not be able
-	 * to enumerate devices behind this port properly (the port is
-	 * powered down preventing all config space accesses to the
-	 * subordinate devices).  We can't be sure for native PCIe hotplug
-	 * either so prevent that as well.
-	 */
-	if (pci_bridge_d3_possible(dev) && !dev->is_hotplug_bridge) {
+	if (pci_bridge_d3_possible(dev)) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -176,7 +168,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev) && !dev->is_hotplug_bridge) {
+	if (pci_bridge_d3_possible(dev)) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
-- 
2.9.3

