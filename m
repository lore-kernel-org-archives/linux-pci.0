Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:34225 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932923AbeFPTfb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:35:31 -0400
Message-Id: <4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 03/32] PCI: pciehp: Fix deadlock on unplug
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When pciehp was conceived it apparently wasn't considered that one
hotplug port may be the parent of another, but with Thunderbolt this is
par for the course.

If the sysfs interface is used to initiate a simultaneous card removal
of two hotplug ports where one is a parent of the other, or if the two
ports simultaneously signal interrupts, e.g. because a link or presence
change was detected on both, a deadlock may occur if:

- The parent acquires pci_lock_rescan_remove(), starts removal of the
  child and waits for it to be unbound.
- The child waits to acquire pci_lock_rescan_remove() in order to
  service the pending sysfs command or interrupt before it can unbind.

Fix by using pci_dev_is_disconnected() as an indicator whether a parent
is removing the child, and avoid acquiring the lock in the child if so.
Should the child happen to acquire the lock first, there's no deadlock.

Testing or setting the disconnected flag needs to happen atomically with
acquisition of the lock, so introduce a mutex to protect that critical
section.

Previously the disconnected flag was only set if the slot was no longer
occupied.  That doesn't seem to make sense because the (logical) child
devices are going to be removed regardless of occupancy, so set the flag
unconditionally.  (Why is occupancy checked at all?  Because if the slot
was disabled via sysfs or a button press, the device remains physically
present for the time being, so the Command register is modified to
quiesce the device.)

The deadlock is probably rarely encountered in practice, but I can
easily reproduce it in poll mode:

    INFO: task pciehp_poll-4-2:102 blocked for more than 120 seconds.
    __schedule+0x291/0x880
    schedule+0x28/0x80
    schedule_timeout+0x1e3/0x370
    wait_for_completion+0x123/0x190
    kthread_stop+0x42/0xf0
    pciehp_release_ctrl+0xaa/0xb0
    pcie_port_remove_service+0x2f/0x40
    device_release_driver_internal+0x157/0x220
    bus_remove_device+0xe2/0x150
    device_del+0x124/0x340
    device_unregister+0x16/0x60
    remove_iter+0x1a/0x20
    device_for_each_child+0x4b/0x90
    pcie_port_device_remove+0x1e/0x30
    pci_device_remove+0x36/0xb0
    device_release_driver_internal+0x157/0x220
    pci_stop_bus_device+0x7d/0xa0
    pci_stop_bus_device+0x2b/0xa0
    pci_stop_and_remove_bus_device+0xe/0x20
    pciehp_unconfigure_device+0xb8/0x160
    pciehp_disable_slot+0x84/0x130
    pciehp_handle_card_not_present+0xd6/0x120
    pciehp_ist+0x111/0x150
    pciehp_poll+0x37/0x90
    kthread+0x111/0x130

    INFO: task pciehp_poll-9:104 blocked for more than 120 seconds.
    schedule+0x28/0x80
    schedule_preempt_disabled+0xa/0x10
    __mutex_lock.isra.1+0x1a0/0x4e0
    pciehp_configure_device+0x24/0x130
    pciehp_enable_slot+0x236/0x390
    pciehp_handle_card_present+0xe2/0x160
    pciehp_ist+0x11e/0x150
    pciehp_poll+0x37/0x90
    kthread+0x111/0x130

Cc: stable@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_pci.c | 38 ++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 3f518dea856d..242395389293 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -20,15 +20,27 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+static DEFINE_MUTEX(acquire_unless_disconnected);
+
 int pciehp_configure_device(struct slot *p_slot)
 {
 	struct pci_dev *dev;
-	struct pci_dev *bridge = p_slot->ctrl->pcie->port;
+	struct controller *ctrl = p_slot->ctrl;
+	struct pci_dev *bridge = ctrl->pcie->port;
 	struct pci_bus *parent = bridge->subordinate;
 	int num, ret = 0;
-	struct controller *ctrl = p_slot->ctrl;
 
+	/*
+	 * Avoid deadlock if an upstream hotplug port has already acquired
+	 * pci_lock_rescan_remove() in order to remove this hotplug port.
+	 */
+	mutex_lock(&acquire_unless_disconnected);
+	if (pci_dev_is_disconnected(bridge)) {
+		mutex_unlock(&acquire_unless_disconnected);
+		return -ENODEV;
+	}
 	pci_lock_rescan_remove();
+	mutex_unlock(&acquire_unless_disconnected);
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
 	if (dev) {
@@ -67,16 +79,24 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	int rc = 0;
 	u8 presence = 0;
 	struct pci_dev *dev, *temp;
-	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
-	u16 command;
 	struct controller *ctrl = p_slot->ctrl;
+	struct pci_dev *bridge = ctrl->pcie->port;
+	struct pci_bus *parent = bridge->subordinate;
+	u16 command;
+
+	mutex_lock(&acquire_unless_disconnected);
+	if (pci_dev_is_disconnected(bridge)) {
+		mutex_unlock(&acquire_unless_disconnected);
+		return -ENODEV;
+	}
+	pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+	pci_lock_rescan_remove();
+	mutex_unlock(&acquire_unless_disconnected);
 
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
 	pciehp_get_adapter_status(p_slot, &presence);
 
-	pci_lock_rescan_remove();
-
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
 	 * which will update the bus->devices list and confuse the
@@ -86,12 +106,6 @@ int pciehp_unconfigure_device(struct slot *p_slot)
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
2.17.1
