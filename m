Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35180 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966424AbeEXVan (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2018 17:30:43 -0400
Received: by mail-pl0-f66.google.com with SMTP id i5-v6so1822951plt.2
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2018 14:30:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [RFC] PCI: hv: support reporting serial number as slot information
Date: Thu, 24 May 2018 14:30:39 -0700
Message-Id: <20180524213039.27841-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Hyper-V host API for PCI provides a unique "serial number" which
can be used as basis for sysfs PCI slot table. This can be useful
for cases where userspace wants to find the PCI device based on
serial number.

When an SR-IOV NIC is added, the host sends an attach message
with serial number. The kernel doesn't use the serial number, but
it is useful when doing the same thing in a userspace driver such
as the DPDK. By having /sys/bus/pci/slots/N it provides a direct
way to find the matching PCI device.

There maybe some cases where serial number is not unique such
as when using GPU's. But the PCI slot infrastructure will handle
that.

This has a side effect which may also be useful. The common udev
network device naming policy uses the slot information (rather
than PCI address).

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 50cdefe3f6d3..42656ebadd5b 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -88,6 +88,8 @@ static enum pci_protocol_version_t pci_protocol_version;
 
 #define STATUS_REVISION_MISMATCH 0xC0000059
 
+#define SLOT_NAME_SIZE	16
+
 /*
  * Message Types
  */
@@ -504,6 +506,7 @@ struct hv_pci_dev {
 	struct list_head list_entry;
 	refcount_t refs;
 	enum hv_pcichild_state state;
+	struct pci_slot *pci_slot;
 	struct pci_function_description desc;
 	bool reported_missing;
 	struct hv_pcibus_device *hbus;
@@ -1443,6 +1446,29 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 }
 
+static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
+{
+	struct hv_pci_dev *hpdev;
+	char name[SLOT_NAME_SIZE];
+	unsigned long flags;
+	int slot_nr;
+
+	spin_lock_irqsave(&hbus->device_list_lock, flags);
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		if (hpdev->pci_slot)
+			continue;
+
+		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
+		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
+		pr_info("%s slot %u name '%s'\n", __func__, slot_nr, name);
+		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+					  name, NULL);
+		if (!hpdev->pci_slot)
+			pr_warn("pci_create slot failed\n");
+	}
+	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1466,6 +1492,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
+	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(hbus->pci_bus);
 	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
@@ -1759,6 +1786,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
+		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
 
@@ -1875,6 +1903,9 @@ static void hv_eject_device_work(struct work_struct *work)
 	list_del(&hpdev->list_entry);
 	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
 
+	if (hpdev->pci_slot)
+		pci_destroy_slot(hpdev->pci_slot);
+
 	memset(&ctxt, 0, sizeof(ctxt));
 	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
-- 
2.17.0
