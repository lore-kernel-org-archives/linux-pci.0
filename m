Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:54985 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdJYLaq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Oct 2017 07:30:46 -0400
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
Subject: [PATCH v4] PCI: pciehp: Drop checking of PCI_BRIDGE_CONTROL in pciehp_unconfigure_device()
Date: Wed, 25 Oct 2017 14:29:40 +0300
Message-Id: <20171025112940.77890-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During surprise hot-unplug the device is not accessible anymore and
register reads return 0xffffffff. When that happens pciehp_unconfigure_device()
may inadvertently think the device below the bridge may be a display
device of somesort as reading PCI_BRIDGE_CONTROL register also returns
0xff. This results failure of the remove operation:

  pciehp 0000:00:1c.0:pcie004: Slot(0): Link Down
  pciehp 0000:00:1c.0:pcie004: Slot(0): Card present
  pciehp 0000:00:1c.0:pcie004: Cannot remove display device 0000:01:00.0

Because of this the hierarchy is left untouched preventing further
hotplug operations.

Now, it is not clear why the check is there in the first place and why
we would like to prevent removing a bridge if it has PCI_BRIDGE_CTL_VGA
set. In case of surprise hot-unplug, it would not even be possible to
prevent the removal. It may be due to the fact that pciehp_pci.c pretty
much copies similar implementation from shpchp_pci.c and this check was
just left there in the code without further thinking if it is actually
needed at all.

Given this and the issue described above, I think it makes sense to drop
the whole PCI_BRIDGE_CONTROL check from pciehp_unconfigure_device()
which is what this patch does.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
The previous version of the patch can be found here:

  https://patchwork.kernel.org/patch/10024145/

Changes from the previous version:

  * Drop the whole PCI_BRIDGE_CONTROL check
  * Update patch subject to reflect that

 drivers/pci/hotplug/pciehp_pci.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 2a1ca020cf5a..acc360d1a1fb 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -79,7 +79,6 @@ int pciehp_configure_device(struct slot *p_slot)
 int pciehp_unconfigure_device(struct slot *p_slot)
 {
 	int rc = 0;
-	u8 bctl = 0;
 	u8 presence = 0;
 	struct pci_dev *dev, *temp;
 	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
@@ -101,17 +100,6 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
-			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
-			if (bctl & PCI_BRIDGE_CTL_VGA) {
-				ctrl_err(ctrl,
-					 "Cannot remove display device %s\n",
-					 pci_name(dev));
-				pci_dev_put(dev);
-				rc = -EINVAL;
-				break;
-			}
-		}
 		if (!presence) {
 			pci_dev_set_disconnected(dev, NULL);
 			if (pci_has_subordinate(dev))
-- 
2.14.2
