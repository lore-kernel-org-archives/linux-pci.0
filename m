Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40526 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeH2UWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2018 16:22:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so2512780plp.7
        for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2018 09:25:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com
Cc: devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH net-next 1/2] PCI: hv: support reporting serial number as slot information
Date: Wed, 29 Aug 2018 09:24:51 -0700
Message-Id: <20180829162452.25805-2-sthemmin@microsoft.com>
In-Reply-To: <20180829162452.25805-1-sthemmin@microsoft.com>
References: <20180829162452.25805-1-sthemmin@microsoft.com>
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

There may be some cases where serial number is not unique such
as when using GPU's. But the PCI slot infrastructure will handle
that by adding suffix "2-1" etc.

This has a side effect which may also be useful. The common udev
network device naming policy uses the slot information (rather
than PCI address). This causes udev to give shorter network device
names for VF devices.  It does not break applications or startup
because the VF device must never be configured directly.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index c00f82cc54aa..e6a6c1146a41 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -89,6 +89,8 @@ static enum pci_protocol_version_t pci_protocol_version;
 
 #define STATUS_REVISION_MISMATCH 0xC0000059
 
+#define SLOT_NAME_SIZE 21
+
 /*
  * Message Types
  */
@@ -494,6 +496,7 @@ struct hv_pci_dev {
 	struct list_head list_entry;
 	refcount_t refs;
 	enum hv_pcichild_state state;
+	struct pci_slot *pci_slot;
 	struct pci_function_description desc;
 	bool reported_missing;
 	struct hv_pcibus_device *hbus;
@@ -1457,6 +1460,28 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
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
+		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+					  name, NULL);
+		if (!hpdev->pci_slot)
+			pr_warn("pci_create slot %s failed\n", name);
+	}
+	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -1480,6 +1505,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
+	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(hbus->pci_bus);
 	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
@@ -1742,6 +1768,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
+		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
 
@@ -1858,6 +1885,9 @@ static void hv_eject_device_work(struct work_struct *work)
 	list_del(&hpdev->list_entry);
 	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
 
+	if (hpdev->pci_slot)
+		pci_destroy_slot(hpdev->pci_slot);
+
 	memset(&ctxt, 0, sizeof(ctxt));
 	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
-- 
2.18.0
