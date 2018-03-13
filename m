Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbeCMW0s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 18:26:48 -0400
Subject: [PATCH v1 2/4] PCI/VPD: Move VPD sysfs code to vpd.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:26:41 -0500
Message-ID: <152097999840.37832.2831547542821143769.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Move the VPD-related sysfs code from pci-sysfs.c to vpd.c.  This follows
the pattern of pcie_aspm_create_sysfs_dev_files().  The goal is to
encapsulate all the VPD code and structures in vpd.c.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |   67 ++---------------------------------------------
 drivers/pci/pci.h       |    2 +
 drivers/pci/vpd.c       |   67 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index eb6bee8724cc..4415e624cf7e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -982,38 +982,6 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
-			     loff_t off, size_t count)
-{
-	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (bin_attr->size > 0) {
-		if (off > bin_attr->size)
-			count = 0;
-		else if (count > bin_attr->size - off)
-			count = bin_attr->size - off;
-	}
-
-	return pci_read_vpd(dev, off, count, buf);
-}
-
-static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buf,
-			      loff_t off, size_t count)
-{
-	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
-
-	if (bin_attr->size > 0) {
-		if (off > bin_attr->size)
-			count = 0;
-		else if (count > bin_attr->size - off)
-			count = bin_attr->size - off;
-	}
-
-	return pci_write_vpd(dev, off, count, buf);
-}
-
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
@@ -1517,29 +1485,8 @@ static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_stor
 static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 {
 	int retval;
-	struct bin_attribute *attr;
-
-	/* If the device has VPD, try to expose it in sysfs. */
-	if (dev->vpd) {
-		attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
-		if (!attr)
-			return -ENOMEM;
 
-		sysfs_bin_attr_init(attr);
-		attr->size = 0;
-		attr->attr.name = "vpd";
-		attr->attr.mode = S_IRUSR | S_IWUSR;
-		attr->read = read_vpd_attr;
-		attr->write = write_vpd_attr;
-		retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
-		if (retval) {
-			kfree(attr);
-			return retval;
-		}
-		dev->vpd->attr = attr;
-	}
-
-	/* Active State Power Management */
+	pcie_vpd_create_sysfs_dev_files(dev);
 	pcie_aspm_create_sysfs_dev_files(dev);
 
 	if (!pci_probe_reset_function(dev)) {
@@ -1552,11 +1499,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 
 error:
 	pcie_aspm_remove_sysfs_dev_files(dev);
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
-
+	pcie_vpd_remove_sysfs_dev_files(dev);
 	return retval;
 }
 
@@ -1630,11 +1573,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
-	if (dev->vpd && dev->vpd->attr) {
-		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
-		kfree(dev->vpd->attr);
-	}
-
+	pcie_vpd_remove_sysfs_dev_files(dev);
 	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->reset_fn) {
 		device_remove_file(&dev->dev, &reset_attr);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd81911b127..1191320a44d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -123,6 +123,8 @@ struct pci_vpd {
 
 int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
+void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
+void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev);
 
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 4596452d58bf..55477f24d8b9 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -378,6 +378,73 @@ void pci_vpd_release(struct pci_dev *dev)
 	kfree(dev->vpd);
 }
 
+static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *bin_attr, char *buf,
+			     loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (bin_attr->size > 0) {
+		if (off > bin_attr->size)
+			count = 0;
+		else if (count > bin_attr->size - off)
+			count = bin_attr->size - off;
+	}
+
+	return pci_read_vpd(dev, off, count, buf);
+}
+
+static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
+			      struct bin_attribute *bin_attr, char *buf,
+			      loff_t off, size_t count)
+{
+	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (bin_attr->size > 0) {
+		if (off > bin_attr->size)
+			count = 0;
+		else if (count > bin_attr->size - off)
+			count = bin_attr->size - off;
+	}
+
+	return pci_write_vpd(dev, off, count, buf);
+}
+
+void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev)
+{
+	int retval;
+	struct bin_attribute *attr;
+
+	if (!dev->vpd)
+		return;
+
+	attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
+	if (!attr)
+		return;
+
+	sysfs_bin_attr_init(attr);
+	attr->size = 0;
+	attr->attr.name = "vpd";
+	attr->attr.mode = S_IRUSR | S_IWUSR;
+	attr->read = read_vpd_attr;
+	attr->write = write_vpd_attr;
+	retval = sysfs_create_bin_file(&dev->dev.kobj, attr);
+	if (retval) {
+		kfree(attr);
+		return;
+	}
+
+	dev->vpd->attr = attr;
+}
+
+void pcie_vpd_remove_sysfs_dev_files(struct pci_dev *dev)
+{
+	if (dev->vpd && dev->vpd->attr) {
+		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
+		kfree(dev->vpd->attr);
+	}
+}
+
 int pci_vpd_find_tag(const u8 *buf, unsigned int off, unsigned int len, u8 rdt)
 {
 	int i;
