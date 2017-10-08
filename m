Return-Path: <SRS0=oEwl=BH=amazon.com=prvs=44771f684=sironi@kernel.org>
Return-Path: <SRS0=oEwl=BH=amazon.com=prvs=44771f684=sironi@kernel.org>
From: Filippo Sironi <sironi@amazon.de>
To: helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Filippo Sironi <sironi@amazon.de>
Subject: [PATCH v2] pci: Expose offset, stride, and VF device ID via sysfs
Date: Mon,  9 Oct 2017 01:09:11 +0200
Message-Id: <1507504151-16179-2-git-send-email-sironi@amazon.de>
In-Reply-To: <1507504151-16179-1-git-send-email-sironi@amazon.de>
References: <1503927530-26076-1-git-send-email-sironi@amazon.de>
 <1507504151-16179-1-git-send-email-sironi@amazon.de>
List-ID: <linux-pci.vger.kernel.org>

... to make it easier for userspace applications to consume them.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2:
* follow up with the rename of vf_did to vf_device

 drivers/pci/pci-sysfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b50723..e6f4133f8992 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -648,6 +648,33 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	return count;
 }
 
+static ssize_t sriov_offset_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->offset);
+}
+
+static ssize_t sriov_stride_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->stride);
+}
+
+static ssize_t sriov_vf_device_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
+}
+
 static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
@@ -676,6 +703,9 @@ static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
 static struct device_attribute sriov_numvfs_attr =
 		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
 		       sriov_numvfs_show, sriov_numvfs_store);
+static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
+static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
+static struct device_attribute sriov_vf_device_attr = __ATTR_RO(sriov_vf_device);
 static struct device_attribute sriov_drivers_autoprobe_attr =
 		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
 		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
@@ -1744,6 +1774,9 @@ static struct attribute_group pci_dev_hp_attr_group = {
 static struct attribute *sriov_dev_attrs[] = {
 	&sriov_totalvfs_attr.attr,
 	&sriov_numvfs_attr.attr,
+	&sriov_offset_attr.attr,
+	&sriov_stride_attr.attr,
+	&sriov_vf_device_attr.attr,
 	&sriov_drivers_autoprobe_attr.attr,
 	NULL,
 };
-- 
2.7.4
