Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:39623 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPTaL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:30:11 -0400
Message-Id: <d68814c62c1c2cb62d6880844b285990f25f1cb5.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 15/32] PCI: pciehp: Publish to user space last on probe
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI hotplug core has just been refactored to separate slot
initialization for in-kernel use from publication to user space.

Take advantage of it in pciehp by publishing to user space last on
probe.  This will allow enable/disablement of the slot exclusively from
the IRQ thread because the IRQ is requested after initialization for
in-kernel use (thereby getting its unique name needed by the IRQ thread)
but before user space is able to submit enable/disable requests.

On teardown, the order is the same in reverse:  The user space interface
is removed prior to freeing the IRQ and destroying the slot.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 37d8f81e548f..cde32e137f6c 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -100,10 +100,10 @@ static int init_slot(struct controller *ctrl)
 	slot->hotplug_slot = hotplug;
 	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
 
-	retval = pci_hp_register(hotplug,
-				 ctrl->pcie->port->subordinate, 0, name);
+	retval = pci_hp_initialize(hotplug,
+				   ctrl->pcie->port->subordinate, 0, name);
 	if (retval)
-		ctrl_err(ctrl, "pci_hp_register failed: error %d\n", retval);
+		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
 out:
 	if (retval) {
 		kfree(ops);
@@ -117,7 +117,7 @@ static void cleanup_slot(struct controller *ctrl)
 {
 	struct hotplug_slot *hotplug_slot = ctrl->slot->hotplug_slot;
 
-	pci_hp_deregister(hotplug_slot);
+	pci_hp_destroy(hotplug_slot);
 	kfree(hotplug_slot->ops);
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
@@ -231,8 +231,15 @@ static int pciehp_probe(struct pcie_device *dev)
 		goto err_out_free_ctrl_slot;
 	}
 
-	/* Check if slot is occupied */
+	/* Publish to user space */
 	slot = ctrl->slot;
+	rc = pci_hp_add(slot->hotplug_slot);
+	if (rc) {
+		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
+		goto err_out_shutdown_notification;
+	}
+
+	/* Check if slot is occupied */
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
 	if (occupied && pciehp_force)
@@ -243,6 +250,8 @@ static int pciehp_probe(struct pcie_device *dev)
 
 	return 0;
 
+err_out_shutdown_notification:
+	pcie_shutdown_notification(ctrl);
 err_out_free_ctrl_slot:
 	cleanup_slot(ctrl);
 err_out_release_ctlr:
@@ -254,6 +263,7 @@ static void pciehp_remove(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
 
+	pci_hp_del(ctrl->slot->hotplug_slot);
 	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
-- 
2.17.1
