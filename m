Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Message-Id: <10f51ea0e0a29b33a5f87e7eb98fe4cdf8cb681f.1534686485.git.lukas@wunner.de>
In-Reply-To: <cover.1534686484.git.lukas@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 19 Aug 2018 16:29:00 +0200
Subject: [PATCH 1/9] PCI: Simplify disconnected marking
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

Commit 89ee9f768003 ("PCI: Add device disconnected state") iterates over
the devices on a parent bus, marks each as disconnected, then marks
each device's children as disconnected using pci_walk_bus().

The same can be achieved more succinctly by calling pci_walk_bus() on
the parent bus.  Moreover, this does not need to wait until acquiring
pci_lock_rescan_remove(), so move it out of that critical section.

The critical section in err.c contains a pci_dev_get() / pci_dev_put()
pair which was apparently copy-pasted from pciehp_pci.c.  In the latter
it serves the purpose of holding the struct pci_dev in place until the
Command register is updated.  err.c doesn't do anything like that, hence
the pair is unnecessary.  Remove it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Oza Pawandeep <poza@codeaurora.org>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/hotplug/pciehp_pci.c | 9 +++------
 drivers/pci/pcie/err.c           | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 18f83e554c73..0322bd4f0a7a 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -91,6 +91,9 @@ void pciehp_unconfigure_device(struct slot *p_slot, bool presence)
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
 
+	if (!presence)
+		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+
 	pci_lock_rescan_remove();
 
 	/*
@@ -102,12 +105,6 @@ void pciehp_unconfigure_device(struct slot *p_slot, bool presence)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
-		if (!presence) {
-			pci_dev_set_disconnected(dev, NULL);
-			if (pci_has_subordinate(dev))
-				pci_walk_bus(dev->subordinate,
-					     pci_dev_set_disconnected, NULL);
-		}
 		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 708fd3a0d646..cac406b6e936 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -292,17 +292,13 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		udev = dev->bus->self;
 
 	parent = udev->subordinate;
+	pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+
 	pci_lock_rescan_remove();
 	pci_dev_get(dev);
 	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
 					 bus_list) {
-		pci_dev_get(pdev);
-		pci_dev_set_disconnected(pdev, NULL);
-		if (pci_has_subordinate(pdev))
-			pci_walk_bus(pdev->subordinate,
-				     pci_dev_set_disconnected, NULL);
 		pci_stop_and_remove_bus_device(pdev);
-		pci_dev_put(pdev);
 	}
 
 	result = reset_link(udev, service);
-- 
2.18.0
