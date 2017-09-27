Return-Path: <SRS0=Xovj=A4=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=Xovj=A4=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Alan Cox <alan@linux.intel.com>,
	Dan J Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 1/3] PCI: pci-driver: Introduce pci device delete list
Date: Wed, 27 Sep 2017 16:40:20 -0400
Message-Id: <1506544822-2632-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

This patch introduces a new kernel command line parameter to mask pci
device ids from pci driver id tables. This prevents masked devices from
automatically binding to both built-in and module drivers.

Devices can be later attached through the driver's sysfs new_id
inteface.

The use cases for this are primarily for debugging, eg, being able to
prevent attachment before probes are set up. It can also be used to mask
off faulty built-in hardware or faulty simulated hardware.

Another use case is to prevent attachment of devices which will be
passed to VMs, shortcutting the detachment effort.

The format is similar to the sysfs new_id format. Device ids are
specified with:

VVVV:DDDD[:SVVV:SDDD][:CCCC][:MMMM]

Where:
VVVV = Vendor ID
DDDD = Device ID
SVVV = Subvendor ID
SDDD = Subdevice ID
CCCC = Class
MMMM = Class Mask

IDs can be chained with commas.

Examples:
	<driver>.delete_id=1234:5678
	<driver>.delete_id=ffffffff:ffffffff
	<driver>.delete_id=ffffffff:ffffffff:ffffffff:ffffffff:010802
	<driver>.delete_id=1234:5678,abcd:ef01,2345:ffffffff

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-driver.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h      |   1 +
 2 files changed, 252 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 11bd267..7acdf13 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/kexec.h>
+#include <asm/setup.h>
 #include "pci.h"
 
 struct pci_dynid {
@@ -27,6 +28,250 @@ struct pci_dynid {
 	struct pci_device_id id;
 };
 
+static struct pci_device_id *pci_match_deleted_ids(struct pci_driver *drv,
+						   struct pci_dev *dev,
+						   bool inverse)
+{
+	struct pci_dynid *deleteid;
+	struct pci_device_id *found_id = NULL;
+
+	spin_lock(&drv->deleteids.lock);
+	list_for_each_entry(deleteid, &drv->deleteids.list, node) {
+		if (!inverse && pci_match_one_device(&deleteid->id, dev)) {
+			found_id = &deleteid->id;
+			break;
+		}
+		if (inverse && !pci_match_one_device(&deleteid->id, dev)) {
+			found_id = &deleteid->id;
+			break;
+		}
+	}
+	spin_unlock(&drv->deleteids.lock);
+
+	return found_id;
+}
+
+/**
+ * pci_match_non_deleted_ids - match dev against not-deleted ids
+ * @ids: array of PCI device id structures to search in
+ * @dev: the PCI device structure to match against.
+ *
+ * Finds devices in driver id table not matching the delete list and tries to
+ * match them individually to dev. Returns the matching pci_dev_id structure,
+ * %NULL if there is no match, of -errno if there was a failure to allocate
+ * memory for the temporary pci_dev
+ */
+static struct pci_device_id *pci_match_non_deleted_ids(struct pci_driver *drv,
+						       struct pci_dev *dev)
+{
+	const struct pci_device_id *ids = drv->id_table;
+	struct pci_device_id *match = NULL;
+	struct pci_dev *tmpdev;
+
+	tmpdev = kzalloc(sizeof(*tmpdev), GFP_KERNEL);
+	if (!tmpdev)
+		return ERR_PTR(-ENOMEM);
+
+	while (ids->vendor || ids->subvendor || ids->class_mask) {
+		struct pci_device_id *found_id = NULL;
+
+		tmpdev->vendor = ids->vendor;
+		tmpdev->device = ids->device,
+		tmpdev->subsystem_vendor = ids->subvendor,
+		tmpdev->subsystem_device = ids->subdevice,
+		tmpdev->class = ids->class;
+
+		found_id = pci_match_deleted_ids(drv, tmpdev, true);
+		if (found_id) {
+			const struct pci_device_id id[2] = { *found_id, {0,} };
+			if (pci_match_id(id, dev)) {
+				match = found_id;
+				break;
+			}
+		}
+		ids++;
+	}
+
+	kfree(tmpdev);
+
+	return match;
+}
+
+/**
+ * pci_add_delete_id - add a new PCI device ID to a built-in driver's blacklist
+ * @drv: target pci driver
+ * @vendor: PCI vendor ID
+ * @device: PCI device ID
+ * @subvendor: PCI subvendor ID
+ * @subdevice: PCI subdevice ID
+ * @class: PCI class
+ * @class_mask: PCI class mask
+ *
+ * Adds a new dynamic pci device ID to this driver's delete list, preventing
+ * the device from attaching to built-in drivers
+ *
+ * CONTEXT:
+ * Does GFP_KERNEL allocation.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+static int pci_add_delete_id(struct pci_driver *drv,
+		  unsigned int vendor, unsigned int device,
+		  unsigned int subvendor, unsigned int subdevice,
+		  unsigned int class, unsigned int class_mask)
+{
+	struct pci_dynid *deleteid;
+
+	deleteid = kzalloc(sizeof(*deleteid), GFP_KERNEL);
+	if (!deleteid)
+		return -ENOMEM;
+
+	deleteid->id.vendor = vendor;
+	deleteid->id.device = device;
+	deleteid->id.subvendor = subvendor;
+	deleteid->id.subdevice = subdevice;
+	deleteid->id.class = class;
+	deleteid->id.class_mask = class_mask;
+
+	spin_lock(&drv->deleteids.lock);
+	list_add_tail(&deleteid->node, &drv->deleteids.list);
+	spin_unlock(&drv->deleteids.lock);
+
+	pr_debug("%s: added %04x:%04x:[%04x:%04x]:[%08x:%08x] to delete list\n",
+		drv->driver.name, vendor, device, subvendor, subdevice,
+		class, class_mask);
+	return 0;
+}
+
+static void pci_free_delete_ids(struct pci_driver *drv)
+{
+	struct pci_dynid *deleteid, *n;
+
+	spin_lock(&drv->deleteids.lock);
+	list_for_each_entry_safe(deleteid, n, &drv->deleteids.list, node) {
+		list_del(&deleteid->node);
+		kfree(deleteid);
+	}
+	spin_unlock(&drv->deleteids.lock);
+}
+
+/**
+ * pci_parse_and_add_delete_id - parses kernel cmdline for delete ids
+ * @drv: the driver structure to register
+ * @ids: string of comma-delimited ids
+ *
+ * Parses a comma-delimited list of pci ids and adds them to the driver's
+ * delete blacklist
+ *
+ * Available formats: VVVV:DDDD[:SVVV:SDDD][:CCCC][:MMMM]
+ * Use full 32-bit format for PCI_ANY_ID (FFFFFFFF)
+ */
+static void pci_parse_and_add_delete_id(struct pci_driver *drv, char *ids)
+{
+	int vendor, device, subvendor, subdevice, class, class_mask;
+	int count, fields;
+
+	while (*ids) {
+		count = 0;
+		fields = sscanf(ids, "%x:%x:%x:%x:%x:%x%n",
+				&vendor, &device, &subvendor, &subdevice,
+				&class, &class_mask, &count);
+
+		switch (fields) {
+		case 6:
+			break;
+		case 5:
+			sscanf(ids, "%x:%x:%x:%x:%x%n", &vendor, &device,
+			       &subvendor, &subdevice, &class, &count);
+			class_mask = 0;
+			break;
+		case 4:
+			sscanf(ids, "%x:%x:%x:%x%n", &vendor, &device,
+			       &subvendor, &subdevice, &count);
+			class_mask = 0;
+			class = PCI_ANY_ID;
+			break;
+		case 2:
+			sscanf(ids, "%x:%x%n", &vendor, &device, &count);
+			class_mask = 0;
+			class = PCI_ANY_ID;
+			subvendor = subdevice = PCI_ANY_ID;
+			break;
+		default:
+			pr_err("%s: Can't parse delete_id parameter: %s\n",
+				drv->driver.name, ids);
+			return;
+		}
+
+		if (pci_add_delete_id(drv, vendor, device,
+			subvendor, subdevice, class, class_mask))
+			break;
+
+		ids += count;
+		if (*ids != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		ids++;
+	}
+}
+
+static int pci_boot_param_cb(char *param, char *val,
+			     const char *modname, void *arg)
+{
+	struct pci_driver *drv = arg;
+	size_t len;
+	char *p;
+
+	/* Missing arg on right side of <param>= */
+	if (!val)
+		return 0;
+
+	p = strchr(param, '.');
+	if (!p)
+		return 0;
+
+	if (strcmp(p + 1, "delete_id"))
+		return 0;
+
+	len = p - param;
+	if (len != strlen(drv->driver.name) ||
+	   (strncmp(param, drv->driver.name, len)))
+		return 0;
+
+	pci_parse_and_add_delete_id(drv, val);
+
+	return 0;
+}
+
+static void __pci_init_delete_ids(struct pci_driver *drv)
+{
+	static char cmdline[COMMAND_LINE_SIZE];
+	char doing[strlen("pci-driver() params") + strlen(drv->driver.name) + 1];
+
+	strcpy(cmdline, saved_command_line);
+	snprintf(doing, sizeof(doing), "pci-driver(%s) params",
+		 drv->driver.name);
+	parse_args(doing, cmdline, NULL,
+		   0, 0, 0, drv, &pci_boot_param_cb);
+}
+
+static void pci_init_delete_ids(struct pci_driver *drv)
+{
+	spin_lock_init(&drv->deleteids.lock);
+	INIT_LIST_HEAD(&drv->deleteids.list);
+
+	/*
+	 * Most configurations won't need to blacklist any device ids.
+	 * Shortcut those cases before calling into parse_args.
+	 */
+	if (!strstr(saved_command_line, "delete_id"))
+		return;
+
+	__pci_init_delete_ids(drv);
+}
+
 /**
  * pci_add_dynid - add a new PCI device ID to this driver and re-probe devices
  * @drv: target pci driver
@@ -124,7 +369,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 		pdev->subsystem_device = subdevice;
 		pdev->class = class;
 
-		if (pci_match_id(pdrv->id_table, pdev))
+		if (pci_match_non_deleted_ids(pdrv, pdev))
 			retval = -EEXIST;
 
 		kfree(pdev);
@@ -269,7 +514,8 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
 	}
 	spin_unlock(&drv->dynids.lock);
 
-	if (!found_id)
+	/* Check the device blacklist before matching the driver id table */
+	if (!found_id && !pci_match_deleted_ids(drv, dev, false))
 		found_id = pci_match_id(drv->id_table, dev);
 
 	/* driver_override will always match, send a dummy id */
@@ -1310,6 +1556,8 @@ int __pci_register_driver(struct pci_driver *drv, struct module *owner,
 	spin_lock_init(&drv->dynids.lock);
 	INIT_LIST_HEAD(&drv->dynids.list);
 
+	pci_init_delete_ids(drv);
+
 	/* register with core */
 	return driver_register(&drv->driver);
 }
@@ -1328,6 +1576,7 @@ int __pci_register_driver(struct pci_driver *drv, struct module *owner,
 void pci_unregister_driver(struct pci_driver *drv)
 {
 	driver_unregister(&drv->driver);
+	pci_free_delete_ids(drv);
 	pci_free_dynids(drv);
 }
 EXPORT_SYMBOL(pci_unregister_driver);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f68c58a..6dc190a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -757,6 +757,7 @@ struct pci_driver {
 	const struct attribute_group **groups;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
+	struct pci_dynids deleteids;
 };
 
 #define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
-- 
1.8.3.1
