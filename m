Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46303 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab2KUUfD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:03 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/9] PCI: Remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 15:34:57 -0500
Message-Id: <1353530100-728-7-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 15 ---------------
 drivers/pci/pci-sysfs.c  |  7 -------
 drivers/pci/pci.h        |  4 ----
 drivers/pci/probe.c      |  2 --
 include/linux/pci.h      |  2 --
 5 files changed, 30 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 11d9c8a..ef54916 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -89,10 +89,6 @@ static void pci_free_dynids(struct pci_driver *drv)
 	spin_unlock(&drv->dynids.lock);
 }
 
-/*
- * Dynamic device ID manipulation via sysfs is disabled for !CONFIG_HOTPLUG
- */
-#ifdef CONFIG_HOTPLUG
 /**
  * store_new_id - sysfs frontend to pci_add_dynid()
  * @driver: target device driver
@@ -191,10 +187,6 @@ static struct driver_attribute pci_drv_attrs[] = {
 	__ATTR_NULL,
 };
 
-#else
-#define pci_drv_attrs	NULL
-#endif /* CONFIG_HOTPLUG */
-
 /**
  * pci_match_id - See if a pci device matches a given pci_id table
  * @ids: array of PCI device id structures to search in
@@ -1231,13 +1223,6 @@ void pci_dev_put(struct pci_dev *dev)
 		put_device(&dev->dev);
 }
 
-#ifndef CONFIG_HOTPLUG
-int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	return -ENODEV;
-}
-#endif
-
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f21991..d12ea86 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -284,7 +284,6 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-#ifdef CONFIG_HOTPLUG
 static DEFINE_MUTEX(pci_remove_rescan_mutex);
 static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 				size_t count)
@@ -377,8 +376,6 @@ dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-#endif
-
 #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -524,10 +521,8 @@ struct device_attribute pci_dev_attrs[] = {
 	__ATTR(broken_parity_status,(S_IRUGO|S_IWUSR),
 		broken_parity_status_show,broken_parity_status_store),
 	__ATTR(msi_bus, 0644, msi_bus_show, msi_bus_store),
-#ifdef CONFIG_HOTPLUG
 	__ATTR(remove, (S_IWUSR|S_IWGRP), NULL, remove_store),
 	__ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_rescan_store),
-#endif
 #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
 	__ATTR(d3cold_allowed, 0644, d3cold_allowed_show, d3cold_allowed_store),
 #endif
@@ -535,9 +530,7 @@ struct device_attribute pci_dev_attrs[] = {
 };
 
 struct device_attribute pcibus_dev_attrs[] = {
-#ifdef CONFIG_HOTPLUG
 	__ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store),
-#endif
 	__ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpumaskaffinity, NULL),
 	__ATTR(cpulistaffinity, S_IRUGO, pci_bus_show_cpulistaffinity, NULL),
 	__ATTR_NULL,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3c9443e..3df6ded 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -158,11 +158,7 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 extern struct device_attribute pci_dev_attrs[];
 extern struct device_attribute pcibus_dev_attrs[];
 extern struct device_type pci_dev_type;
-#ifdef CONFIG_HOTPLUG
 extern struct bus_attribute pci_bus_attrs[];
-#else
-#define pci_bus_attrs	NULL
-#endif
 
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 293af5a..3d17641 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1865,7 +1865,6 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 }
 EXPORT_SYMBOL(pci_scan_bus);
 
-#ifdef CONFIG_HOTPLUG
 /**
  * pci_rescan_bus_bridge_resize - scan a PCI bus for devices.
  * @bridge: PCI bridge for the bus to scan
@@ -1917,7 +1916,6 @@ EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
-#endif
 
 static int __init pci_sort_bf_cmp(const struct device *d_a, const struct device *d_b)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5b37d64..9f99c59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -944,10 +944,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
-#ifdef CONFIG_HOTPLUG
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
-#endif
 
 /* Vital product data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
1.8.0

