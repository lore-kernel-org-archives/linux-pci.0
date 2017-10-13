Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v2 8/8] PCI: pciehp: Check that the device is really present before touching it
Date: Fri, 13 Oct 2017 21:35:48 +0300
Message-Id: <20171013183548.68283-9-mika.westerberg@linux.intel.com>
In-Reply-To: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
References: <20171013183548.68283-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During surprise hot-unplug the device is not there anymore. When that
happens we read 0xffffffff from the registers and pciehp_unconfigure_device()
inadvertently thinks the device is a display device because bridge
control register returns 0xff refusing to remove it:

  pciehp 0000:00:1c.0:pcie004: Slot(0): Link Down
  pciehp 0000:00:1c.0:pcie004: Slot(0): Card present
  pciehp 0000:00:1c.0:pcie004: Cannot remove display device 0000:01:00.0

This causes the hotplug functionality to leave the hierarcy untouched
preventing further hotplug operations.

To fix this verify presence of a device by calling pci_device_is_present()
for it before we touch it any further.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 2a1ca020cf5a..fb4333168e23 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -100,8 +100,14 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	 */
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
+		bool present;
+
 		pci_dev_get(dev);
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
+
+		/* Check if the device is really there anymore */
+		present = presence ? pci_device_is_present(dev) : false;
+
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && present) {
 			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
 			if (bctl & PCI_BRIDGE_CTL_VGA) {
 				ctrl_err(ctrl,
@@ -112,7 +118,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 				break;
 			}
 		}
-		if (!presence) {
+		if (!present) {
 			pci_dev_set_disconnected(dev, NULL);
 			if (pci_has_subordinate(dev))
 				pci_walk_bus(dev->subordinate,
@@ -123,7 +129,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 		 * Ensure that no new Requests will be generated from
 		 * the device.
 		 */
-		if (presence) {
+		if (present) {
 			pci_read_config_word(dev, PCI_COMMAND, &command);
 			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
 			command |= PCI_COMMAND_INTX_DISABLE;
-- 
2.14.2
