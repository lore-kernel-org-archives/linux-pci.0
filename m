Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Colin King <colin.king@canonical.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: acpiphp_ibm: fix null dereferences on null ibm_slot
Date: Sat,  2 Jan 2016 00:27:01 +0000
Message-Id: <1451694421-5277-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

ibm_slot_from_id can return null if the des header signature is
not aPCI or if the kmalloc for the return acpi descriptore fails,
causing potential null pointer dereferences on the return null
descriptor.

Handle the null case with appropriate check and error return.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 6ca2399..9d16c9d 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -154,7 +154,8 @@ static union apci_descriptor *ibm_slot_from_id(int id)
 ibm_slot_done:
 	if (ret) {
 		ret = kmalloc(sizeof(union apci_descriptor), GFP_KERNEL);
-		memcpy(ret, des, sizeof(union apci_descriptor));
+		if (ret)
+			memcpy(ret, des, sizeof(union apci_descriptor));
 	}
 	kfree(table);
 	return ret;
@@ -175,8 +176,13 @@ static int ibm_set_attention_status(struct hotplug_slot *slot, u8 status)
 	acpi_status stat;
 	unsigned long long rc;
 	union apci_descriptor *ibm_slot;
+	int id = hpslot_to_sun(slot);
 
-	ibm_slot = ibm_slot_from_id(hpslot_to_sun(slot));
+	ibm_slot = ibm_slot_from_id(id);
+	if (!ibm_slot) {
+		pr_err("APLS null ACPI descriptor for slot %d\n", id);
+		return -ENODEV;
+	}
 
 	pr_debug("%s: set slot %d (%d) attention status to %d\n", __func__,
 			ibm_slot->slot.slot_num, ibm_slot->slot.slot_id,
@@ -215,8 +221,13 @@ static int ibm_set_attention_status(struct hotplug_slot *slot, u8 status)
 static int ibm_get_attention_status(struct hotplug_slot *slot, u8 *status)
 {
 	union apci_descriptor *ibm_slot;
+	int id = hpslot_to_sun(slot);
 
-	ibm_slot = ibm_slot_from_id(hpslot_to_sun(slot));
+	ibm_slot = ibm_slot_from_id(id);
+	if (!ibm_slot) {
+		pr_err("APLS null ACPI descriptor for slot %d\n", id);
+		return -ENODEV;
+	}
 
 	if (ibm_slot->slot.attn & 0xa0 || ibm_slot->slot.status[1] & 0x08)
 		*status = 1;
-- 
2.6.4

