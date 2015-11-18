Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jordan Hargrave <Jordan_Hargrave@dell.com>
To: jharg93@gmail.com, jdelvare@suse.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: [PATCH 2/2] Create sysfs attribute 'slot' for mapping PCI device to SMBIOS slot
Date: Wed, 18 Nov 2015 16:03:23 -0600
Message-Id: <1447884203-31547-1-git-send-email-Jordan_Hargrave@dell.com>
To: Jordan_Hargrave@dell.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch will use the saved SMBIOS Type 9 values to map a PCI
device to a system slot.  This includes devices under a bridge/switch
on an add-in card.

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 drivers/pci/pci-label.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 2 files changed, 95 insertions(+)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 024b5c1..0b0954b 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -125,14 +125,107 @@ static struct attribute_group smbios_attr_group = {
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
+	for(;;) {
+		found = 0;
+		dmi = dmi_find_device(DMI_DEV_TYPE_SYSTEM_SLOT, NULL, dmi);
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
+		     bus >= sdev->subordinate->busn_res.start &&
+		     bus <= sdev->subordinate->busn_res.end) {
+			/* device is child of bridge */
+			found = 1;
+		}
+		if (sdev->bus->number == bus &&
+		    PCI_SLOT(sdev->devfn) == PCI_SLOT(pdev->devfn)) {
+			/* If slot points to PCIE root on a multifunction device,
+			 * match exact Bus:Dev:Func.  Otherwise match Bus:Dev */
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
+	if (slot > 0) {
+		return scnprintf(buf, PAGE_SIZE, "%d\n", slot);
+	}
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
index e828e7b..b4c26cb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1972,4 +1972,6 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
 	return bus->self && bus->self->ari_enabled;
 }
+
+int pci_get_smbios_slot(struct pci_dev *pdev);
 #endif /* LINUX_PCI_H */
-- 
2.5.0

