Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26317 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbeIFBGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:06:34 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 01/20] PCI: Simplify disconnected marking
Date: Wed,  5 Sep 2018 14:35:27 -0600
Message-Id: <20180905203546.21921-2-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lukas Wunner <lukas@wunner.de>

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
Reviewed-by: Keith Busch <keith.busch@intel.com>
Cc: Oza Pawandeep <poza@codeaurora.org>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/hotplug/pciehp_pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

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
-- 
2.14.4
