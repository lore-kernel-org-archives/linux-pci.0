Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:30415 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932282AbdJXLJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 07:09:49 -0400
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
Subject: [PATCH v3] PCI: pciehp: Check for valid PCI_BRIDGE_CONTROL in pciehp_unconfigure_device()
Date: Tue, 24 Oct 2017 14:09:14 +0300
Message-Id: <20171024110914.53612-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During surprise hot-unplug the device is not there anymore. When that
happens we read 0xffffffff from the registers and pciehp_unconfigure_device()
might inadvertently think the device is a display device because bridge
control register returns 0xff refusing to remove it:

  pciehp 0000:00:1c.0:pcie004: Slot(0): Link Down
  pciehp 0000:00:1c.0:pcie004: Slot(0): Card present
  pciehp 0000:00:1c.0:pcie004: Cannot remove display device 0000:01:00.0

This causes the hotplug functionality to leave the hierarcy untouched
preventing further hotplug operations.

Fix this so that we first compare the read bctl value against 0xffff
(device is not present anymore) before determining whether the device is
a display or not.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi Bjorn,

This is an updated version of the patch 8/8 in my "PCI: Improvements for
native PCIe hotplug" patch series and applies on top of pci.git/pci/hotplug.

We now just check bctl against 0xffff before preventing removal of the
"display" device.

I'm inclined to remove the whole check of "display" device because I don't
see any reason for it to be there in the first place. This code is pretty
much duplicated from shpchp_pci.c where it might make some sense.

 drivers/pci/hotplug/pciehp_pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 2a1ca020cf5a..5225b12c5a75 100644
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
@@ -102,8 +101,10 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 					 bus_list) {
 		pci_dev_get(dev);
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
-			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
-			if (bctl & PCI_BRIDGE_CTL_VGA) {
+			u16 bctl = 0;
+
+			pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
+			if (bctl != 0xffff && (bctl & PCI_BRIDGE_CTL_VGA)) {
 				ctrl_err(ctrl,
 					 "Cannot remove display device %s\n",
 					 pci_name(dev));
-- 
2.14.2
