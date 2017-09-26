Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56468 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030477AbdIZOR3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Sep 2017 10:17:29 -0400
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
Subject: [PATCH 5/7] PCI: pciehp: Fix race condition handling surprise link down
Date: Tue, 26 Sep 2017 17:17:18 +0300
Message-Id: <20170926141720.25067-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A surprise link down may retrain very quickly causing the same slot
generate a link up event before handling the link down event completes.

Since the link is active, the power off work queued from the first link
down will cause a second down event when power is disabled. However, the
link up event sets the slot state to POWERON_STATE before the event to
handle this is enqueued, making the second down event believe it needs
to do something.

This creates constant link up and down event cycle.

To prevent this it is better to handle each event at the time in order
it occurred, so change the driver to use ordered workqueue instead.

A normal device hotplug triggers two events (presense detect and link
up) that are already handled properly in the driver but we currently log
an error if we find an existing device in the slot. Since this is not an
error change the log level to be debug instead to avoid scaring users.

This is based on the original work by Ashok Raj.

Link: https://patchwork.kernel.org/patch/9469023
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 7 ++++---
 drivers/pci/hotplug/pciehp_hpc.c  | 2 +-
 drivers/pci/hotplug/pciehp_pci.c  | 6 +++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ec0b4c11ccd9..83f3d4af3677 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -113,10 +113,11 @@ static int board_added(struct slot *p_slot)
 
 	retval = pciehp_configure_device(p_slot);
 	if (retval) {
-		ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
-			 pci_domain_nr(parent), parent->number);
-		if (retval != -EEXIST)
+		if (retval != -EEXIST) {
+			ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
+				 pci_domain_nr(parent), parent->number);
 			goto err_exit;
+		}
 	}
 
 	pciehp_green_led_on(p_slot);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e5d5ce9e3010..83c93f9da65a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -795,7 +795,7 @@ static int pcie_init_slot(struct controller *ctrl)
 	if (!slot)
 		return -ENOMEM;
 
-	slot->wq = alloc_workqueue("pciehp-%u", 0, 0, PSN(ctrl));
+	slot->wq = alloc_ordered_workqueue("pciehp-%u", 0, PSN(ctrl));
 	if (!slot->wq)
 		goto abort;
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 19f30a9f461d..b31702f76149 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -46,7 +46,11 @@ int pciehp_configure_device(struct slot *p_slot)
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
 	if (dev) {
-		ctrl_err(ctrl, "Device %s already exists at %04x:%02x:00, cannot hot-add\n",
+		/*
+		 * The device is already there. Either configured by the
+		 * boot firmware or a previous hotplug event.
+		 */
+		ctrl_dbg(ctrl, "Device %s already exists at %04x:%02x:00, skipping hot-add\n",
 			 pci_name(dev), pci_domain_nr(parent), parent->number);
 		pci_dev_put(dev);
 		ret = -EEXIST;
-- 
2.14.1
