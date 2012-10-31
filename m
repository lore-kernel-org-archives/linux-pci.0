Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161030Ab2JaVT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 17:19:28 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 3/4] PCI,sys: SRIOV control and status via sysfs
Date: Wed, 31 Oct 2012 17:19:08 -0400
Message-Id: <1351718353-6124-4-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
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
sriov_totalvfs -- cat-ing this file returns the maximum number
                  of VFs a PCIe device supports as reported by
                  the TotalVFs in the SRIOV ext cap structure.
sriov_numvfs -- echo'ing a positive number to this file enables this
                number of VFs for this given PCIe device.
             -- echo'ing a 0 to this file disables
                any previously enabled VFs for this PCIe device.
             -- cat-ing this file will return the number of VFs
                currently enabled on this PCIe device, i.e.,
                the NumVFs field in SRIOV ext. cap structure.

VF enable and disablement is invoked much like other PCIe
configuration functions -- via registered callbacks in the driver,
i.e., probe, release, etc.

Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/pci/pci-sysfs.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h     |   1 +
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fbbb97f..83be8ce 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -14,7 +14,6 @@
  *
  */
 
-
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -404,6 +403,110 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_PCI_IOV
+static ssize_t sriov_totalvfs_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct pci_dev *pdev;
+	u16 total;
+
+	pdev = to_pci_dev(dev);
+	total = pdev->sriov->total;
+	return sprintf(buf, "%u\n", total);
+}
+
+
+static ssize_t sriov_numvfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->nr_virtfn);
+}
+
+/*
+ * num_vfs > 0; number of vfs to enable
+ * num_vfs = 0; disable all vfs
+ *
+ * Note: SRIOV spec doesn't allow partial VF
+ *       disable, so its all or none.
+ */
+static ssize_t sriov_numvfs_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev;
+	int num_vfs_enabled = 0;
+	int num_vfs;
+	int ret = 0;
+	u16 total;
+
+	pdev = to_pci_dev(dev);
+
+	if (kstrtoint(buf, 0, &num_vfs) < 0)
+		return -EINVAL;
+
+	/* is PF driver loaded w/callback */
+	if (!pdev->driver || !pdev->driver->sriov_configure) {
+		dev_info(&pdev->dev,
+			 "Driver doesn't support SRIOV configuration via sysfs\n");
+		return -ENOSYS;
+	}
+
+	/* if enabling vf's ... */
+	total = pdev->sriov->total;
+	/* Requested VFs to enable < totalvfs and none enabled already */
+	if ((num_vfs > 0) && (num_vfs <= total)) {
+		if (pdev->sriov->nr_virtfn == 0) {
+			num_vfs_enabled =
+				pdev->driver->sriov_configure(pdev, num_vfs);
+			if ((num_vfs_enabled >= 0) &&
+			    (num_vfs_enabled != num_vfs))
+				dev_warn(&pdev->dev,
+					 "Only %d VFs enabled\n",
+					 num_vfs_enabled);
+			return count;
+		} else if (num_vfs == pdev->sriov->nr_virtfn) {
+			dev_warn(&pdev->dev,
+				 "%d VFs already enabled; no enable action taken\n",
+				 num_vfs);
+			return count;
+		} else {
+			dev_warn(&pdev->dev,
+				 "%d VFs already enabled. Disable before enabling %d VFs\n",
+				 pdev->sriov->nr_virtfn, num_vfs);
+			return -EINVAL;
+		}
+	}
+
+	/* disable vfs */
+	if (num_vfs == 0) {
+		if (pdev->sriov->nr_virtfn != 0) {
+			ret = pdev->driver->sriov_configure(pdev, 0);
+			return ret ? ret : count;
+		} else {
+			dev_warn(&pdev->dev,
+				 "All VFs disabled; no disable action taken\n");
+			return count;
+		}
+	}
+
+	dev_err(&pdev->dev,
+		"Invalid value for number of VFs to enable: %d\n", num_vfs);
+
+	return -EINVAL;
+}
+
+static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
+static struct device_attribute sriov_numvfs_attr =
+		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
+		       sriov_numvfs_show, sriov_numvfs_store);
+#endif /* CONFIG_PCI_IOV */
+
 struct device_attribute pci_dev_attrs[] = {
 	__ATTR_RO(resource),
 	__ATTR_RO(vendor),
@@ -1409,7 +1512,7 @@ static struct attribute *pci_dev_dev_attrs[] = {
 };
 
 static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
-						struct attribute *a, int n)
+					 struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -1421,6 +1524,33 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
+#ifdef CONFIG_PCI_IOV
+static struct attribute *sriov_dev_attrs[] = {
+	&sriov_totalvfs_attr.attr,
+	&sriov_numvfs_attr.attr,
+	NULL,
+};
+
+static umode_t sriov_attrs_are_visible(struct kobject *kobj,
+					 struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+
+	if ((a == &sriov_totalvfs_attr.attr) ||
+	    (a == &sriov_numvfs_attr.attr)) {
+		if (!dev_is_pf(dev))
+			return 0;
+	}
+
+	return a->mode;
+}
+
+static struct attribute_group sriov_dev_attr_group = {
+	.attrs = sriov_dev_attrs,
+	.is_visible = sriov_attrs_are_visible,
+};
+#endif /* CONFIG_PCI_IOV */
+
 static struct attribute_group pci_dev_attr_group = {
 	.attrs = pci_dev_dev_attrs,
 	.is_visible = pci_dev_attrs_are_visible,
@@ -1428,6 +1558,9 @@ static struct attribute_group pci_dev_attr_group = {
 
 static const struct attribute_group *pci_dev_attr_groups[] = {
 	&pci_dev_attr_group,
+#ifdef CONFIG_PCI_IOV
+	&sriov_dev_attr_group,
+#endif
 	NULL,
 };
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ee21795..7ef8fba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -573,6 +573,7 @@ struct pci_driver {
 	int  (*resume_early) (struct pci_dev *dev);
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	void (*shutdown) (struct pci_dev *dev);
+	int (*sriov_configure) (struct pci_dev *dev, int num_vfs); /* PF pdev */
 	const struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
-- 
1.7.10.2.552.gaa3bb87

