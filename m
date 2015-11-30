Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35888 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbK3T3n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2015 14:29:43 -0500
From: Jordan Hargrave <jharg93@gmail.com>
To: bhelgaas@google.com, jordan_hargrave@dell.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] Create sysfs attribute 'slot' for mapping PCI device to SMBIOS slot
Date: Mon, 30 Nov 2015 13:29:33 -0600
Message-Id: <1448911773-18296-1-git-send-email-jordan_hargrave@dell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch will use the saved SMBIOS Type 9 values to map a PCI
device to a system slot.  This includes devices under a bridge/switch
on an add-in card.  Creates a new global function to retrieve smbios
slot for a PCI device.

Fixed up spacing and braces.
Fixed up enum name for slot to match related patch

Signed-off-by: Jordan Hargrave <jordan_hargrave@dell.com>
---
 drivers/pci/pci-label.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h     |  2 ++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 024b5c1..45ead2a 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -54,7 +54,7 @@ static size_t find_smbios_instance_string(struct pci_dev *pdev, char *buf,
 				      NULL, dmi)) != NULL) {
 		donboard = dmi->device_data;
 		if (donboard && donboard->bus == bus &&
-					donboard->devfn == devfn) {
+		    donboard->devfn == devfn) {
 			if (buf) {
 				if (attribute == SMBIOS_ATTR_INSTANCE_SHOW)
 					return scnprintf(buf, PAGE_SIZE,
@@ -125,14 +125,108 @@ static struct attribute_group smbios_attr_group = {
 	.is_visible = smbios_instance_string_exist,
 };
 
+int pci_get_smbios_slot(struct pci_dev *pdev)
+{
+	struct pci_dev *sdev;
+	struct dmi_dev_onboard *dslot;
+	const struct dmi_device *dmi;
+	u8 bus, found;
+
+	dmi = NULL;
+	pdev = pci_physfn(pdev);
+	bus = pdev->bus->number;
+	while (1) {
+		found = 0;
+		dmi = dmi_find_device(DMI_DEV_TYPE_DEV_SLOT, NULL, dmi);
+		if (dmi == NULL)
+			break;
+		dslot = dmi->device_data;
+		if (pci_domain_nr(pdev->bus) != dslot->segment)
+			continue;
+		sdev = pci_get_domain_bus_and_slot(dslot->segment, dslot->bus,
+						   dslot->devfn);
+		if (sdev == NULL)
+			continue;
+
+		if (sdev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
+		    bus >= sdev->subordinate->busn_res.start &&
+		    bus <= sdev->subordinate->busn_res.end) {
+			/* device is child of bridge */
+			found = 1;
+		}
+		if (sdev->bus->number == bus &&
+		    PCI_SLOT(sdev->devfn) == PCI_SLOT(pdev->devfn)) {
+			/* If slot points to PCIE root on a multifunction
+			 * device, match exact Bus:Dev:Func.  Otherwise
+			 * match Bus:Dev
+			 */
+			if (pci_pcie_type(sdev) != PCI_EXP_TYPE_ROOT_PORT ||
+			    PCI_FUNC(sdev->devfn) == PCI_FUNC(pdev->devfn)) {
+				found = 1;
+			}
+		}
+		pci_dev_put(sdev);
+		if (found)
+			return dslot->instance;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL(pci_get_smbios_slot);
+
+static ssize_t smbiosslot_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev;
+	int slot;
+
+	pdev = to_pci_dev(dev);
+	slot = pci_get_smbios_slot(pdev);
+	if (slot > 0)
+		return scnprintf(buf, PAGE_SIZE, "%d\n", slot);
+	return 0;
+}
+
+static umode_t smbios_slot_exist(struct kobject *kobj, struct attribute *attr,
+				 int n)
+{
+	struct device *dev;
+	struct pci_dev *pdev;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdev = to_pci_dev(dev);
+
+	return (pci_get_smbios_slot(pdev) > 0) ? S_IRUGO : 0;
+}
+
+static struct device_attribute smbios_attr_slot = {
+	.attr = {.name = "slot", .mode = 0444},
+	.show = smbiosslot_show,
+};
+
+static struct attribute *smbios_slot_attributes[] = {
+	&smbios_attr_slot.attr,
+	NULL,
+};
+
+static struct attribute_group smbios_slot_attr_group = {
+	.attrs = smbios_slot_attributes,
+	.is_visible = smbios_slot_exist,
+};
+
 static int pci_create_smbiosname_file(struct pci_dev *pdev)
 {
+	int rc;
+
+	rc = sysfs_create_group(&pdev->dev.kobj, &smbios_slot_attr_group);
+	if (rc != 0)
+		return rc;
 	return sysfs_create_group(&pdev->dev.kobj, &smbios_attr_group);
 }
 
 static void pci_remove_smbiosname_file(struct pci_dev *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &smbios_attr_group);
+	sysfs_remove_group(&pdev->dev.kobj, &smbios_slot_attr_group);
 }
 #else
 static inline int pci_create_smbiosname_file(struct pci_dev *pdev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..4b444e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1981,4 +1981,6 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
 	return bus->self && bus->self->ari_enabled;
 }
+
+int pci_get_smbios_slot(struct pci_dev *pdev);
 #endif /* LINUX_PCI_H */
-- 
1.9.1

