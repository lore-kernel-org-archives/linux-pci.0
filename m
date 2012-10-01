Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47305 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965130Ab2JAX1I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Oct 2012 19:27:08 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Subject: [RFC] PCI: enable and disable sriov support via sysfs at per device level
Date: Mon,  1 Oct 2012 19:27:00 -0400
Message-Id: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Provide files under sysfs to determine the max number of vfs
an SRIOV-capable PCIe device supports, and methods to enable and
disable the vfs on a per device basis.

Currently, VF enablement by SRIOV-capable PCIe devices is done
in driver-specific module parameters.  If not setup in modprobe files,
it requires admin to unload & reload PF drivers with number of desired
VFs to enable.  Additionally, the enablement is system wide: all
devices controlled by the same driver have the same number of VFs
enabled.  Although the latter is probably desired, there are PCI
configurations setup by system BIOS that may not enable that to occur.

Three files are created if a PCIe device has SRIOV support:
sriov_max_vfs -- cat-ing this file returns the maximum number
                 of VFs a PCIe device supports.
sriov_enable_vfs -- echo'ing a number to this file enables this
                    number of VFs for this given PCIe device.
                 -- cat-ing this file will return the number of VFs
                    currently enabled on this PCIe device.
sriov_disable_vfs -- echo-ing any number other than 0 disables all
                     VFs associated with this PCIe device.

VF enable and disablement is invoked much like other PCIe
configuration functions -- via registered callbacks in the driver,
i.e., probe, release, etc.

Note: I haven't had a chance to refactor an SRIOV PF driver
      to test against; hoping to try ixgbe or igb in next couple days.
      To date, just tested that cat-ing sriov_max_vfs works, and
      cat-ing sriov_enable_vfs returns the correct number when
      a PF driver has been loaded with VFs enabled via per-driver param,
      e.g., modprobe igb max_vfs=4

Send comments and I'll integrate as needed, while modifying
a PF driver to use this interface.

Signed-off-by: Donald Dutile <ddutile@redhat.com>

---
 drivers/pci/pci-sysfs.c | 186 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/pci.h     |   2 +
 2 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6869009..1b5eab7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -404,6 +404,152 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 }
 #endif
 
+
+#ifdef CONFIG_PCI_IOV
+static ssize_t sriov_max_vfs_show(struct device *dev,
+				  struct device_attribute *attr, 
+				  char *buf)
+{
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	return sprintf (buf, "%u\n", pdev->sriov->total);
+}
+
+bool pci_dev_has_sriov(struct pci_dev *pdev)
+{
+	int ret = false;
+	int pos;
+
+        if (!pci_is_pcie(pdev))
+		goto out;
+
+	pos =  pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos)
+		ret = true;
+out:
+	return ret;
+}
+
+static ssize_t sriov_enable_vfs_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct pci_dev *pdev;
+	int nr_virtfn = 0;
+
+	pdev = to_pci_dev(dev);
+
+	if (pci_dev_has_sriov(pdev))
+		nr_virtfn = pdev->sriov->nr_virtfn;
+
+	return sprintf (buf, "%u\n", nr_virtfn);
+}
+
+static ssize_t sriov_enable_vfs_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct pci_dev *pdev;
+	int num_vf_enabled = 0;
+	unsigned long num_vfs;
+	pdev = to_pci_dev(dev);
+	
+	if (!pci_dev_has_sriov(pdev))
+		goto out;
+
+	/* Requested VFs to enable < max_vfs 
+	 * and none enabled already
+	 */
+	if (strict_strtoul(buf, 0, &num_vfs) < 0)
+			return -EINVAL;
+
+	if ((num_vfs > pdev->sriov->total) ||
+	    (pdev->sriov->nr_virtfn != 0))
+		return -EINVAL;
+
+	/* Ready for lift-off! */
+	if (pdev->driver && pdev->driver->sriov_enable) {
+		num_vf_enabled = pdev->driver->sriov_enable(pdev, num_vfs);
+	}
+
+out:
+	if (num_vf_enabled != num_vfs)
+		printk(KERN_WARNING 
+			"%s: %04x:%02x:%02x.%d: Only %d VFs enabled \n",
+			pci_name(pdev), pci_domain_nr(pdev->bus),
+			pdev->bus->number, PCI_SLOT(pdev->devfn),
+			PCI_FUNC(pdev->devfn), num_vf_enabled);
+
+	return count;
+}
+
+static ssize_t sriov_disable_vfs_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+
+	/* make sure sriov device & at least 1 vf enabled */
+	if (!pci_dev_has_sriov(pdev) ||
+	   (pdev->sriov->nr_virtfn == 0))
+		goto out;
+
+	/* Ready for landing! */
+	if (pdev->driver && pdev->driver->sriov_disable) {
+		pdev->driver->sriov_disable(pdev);
+	}
+out:
+	return count;
+}
+
+struct device_attribute pci_dev_sriov_attrs[] = {
+	__ATTR_RO(sriov_max_vfs),
+	__ATTR(sriov_enable_vfs, (S_IRUGO|S_IWUSR|S_IWGRP), 
+		sriov_enable_vfs_show, sriov_enable_vfs_store),
+	__ATTR(sriov_disable_vfs, (S_IWUSR|S_IWGRP), 
+		NULL, sriov_disable_vfs_store),
+	__ATTR_NULL,
+};
+
+static int pci_sriov_create_sysfs_dev_files(struct pci_dev *dev)
+{
+	int pos, i;
+	int retval=0;
+
+	if ((dev->is_physfn) && pci_is_pcie(dev)) {
+            pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
+            if (pos) {
+		for (i = 0; attr_name(pci_dev_sriov_attrs[i]); i++) {
+		    retval = device_create_file(&dev->dev, &pci_dev_sriov_attrs[i]);
+		    if (retval) {
+			while (--i >= 0)
+			     device_remove_file(&dev->dev, &pci_dev_sriov_attrs[i]);
+			break;
+		    }
+		}
+	    }
+	}
+	return retval;
+}
+
+static void pci_sriov_remove_sysfs_dev_files(struct pci_dev *dev)
+{
+	int pos;
+
+	if ((dev->is_physfn) && pci_is_pcie(dev)) {
+            pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
+            if (pos)
+		device_remove_file(&dev->dev, pci_dev_sriov_attrs);
+	}
+}
+#else
+static int pci_sriov_create_sysfs_dev_files(struct pci_dev *dev) { return 0; }
+static void pci_sriov_remove_sysfs_dev_files(struct pci_dev *dev) { return; }
+#endif /* CONFIG_PCI_IOV */
+
 struct device_attribute pci_dev_attrs[] = {
 	__ATTR_RO(resource),
 	__ATTR_RO(vendor),
@@ -1169,6 +1315,22 @@ static ssize_t reset_store(struct device *dev,
 
 static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_store);
 
+static void pci_reset_remove_sysfs_dev_file(struct pci_dev *dev)
+{
+	if (dev->reset_fn) {
+		device_remove_file(&dev->dev, &reset_attr);
+		dev->reset_fn = 0;
+	}
+}
+
+static void pci_vpd_remove_sysfs_dev_file(struct pci_dev *dev)
+{
+	if (dev->vpd && dev->vpd->attr) {
+		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
+		kfree(dev->vpd->attr);
+	}
+}
+
 static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 {
 	int retval;
@@ -1203,14 +1365,18 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 			goto error;
 		dev->reset_fn = 1;
 	}
+
+	/* SRIOV */
+	retval = pci_sriov_create_sysfs_dev_files(dev);
+	if (retval)
+		goto error;
+
 	return 0;
 
 error:
+	pci_reset_remove_sysfs_dev_file(dev);
 	pcie_aspm_remove_sysfs_dev_files(dev);
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
+	pci_vpd_remove_sysfs_dev_file(dev);
 
 	return retval;
 }
@@ -1303,16 +1469,10 @@ err:
 
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
-
+	pci_sriov_remove_sysfs_dev_files(dev);
+	pci_reset_remove_sysfs_dev_file(dev);
 	pcie_aspm_remove_sysfs_dev_files(dev);
-	if (dev->reset_fn) {
-		device_remove_file(&dev->dev, &reset_attr);
-		dev->reset_fn = 0;
-	}
+	pci_vpd_remove_sysfs_dev_file(dev);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5faa831..29e10aa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -596,6 +596,8 @@ struct pci_driver {
 	int  (*resume_early) (struct pci_dev *dev);
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	void (*shutdown) (struct pci_dev *dev);
+        int (*sriov_enable) (struct pci_dev *dev, int num_vfs);    /* PF pci dev */
+        void (*sriov_disable) (struct pci_dev *dev); 
 	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
-- 
1.7.10.2.552.gaa3bb87

