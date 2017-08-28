Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Filippo Sironi <sironi@amazon.de>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Filippo Sironi <sironi@amazon.de>
Subject: [PATCH 2/2] pci: Expose offset, stride, and VF device ID via sysfs
Date: Mon, 28 Aug 2017 15:38:50 +0200
Message-Id: <1503927530-26076-2-git-send-email-sironi@amazon.de>
In-Reply-To: <1503927530-26076-1-git-send-email-sironi@amazon.de>
References: <1503927530-26076-1-git-send-email-sironi@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

... to make it easier for userspace applications consumption.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b50723..f920afe7cff3 100644
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
+static ssize_t sriov_vf_did_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%x\n", pdev->sriov->vf_did);
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
+static struct device_attribute sriov_vf_did_attr = __ATTR_RO(sriov_vf_did);
 static struct device_attribute sriov_drivers_autoprobe_attr =
 		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
 		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
@@ -1744,6 +1774,9 @@ static struct attribute_group pci_dev_hp_attr_group = {
 static struct attribute *sriov_dev_attrs[] = {
 	&sriov_totalvfs_attr.attr,
 	&sriov_numvfs_attr.attr,
+	&sriov_offset_attr.attr,
+	&sriov_stride_attr.attr,
+	&sriov_vf_did_attr.attr,
 	&sriov_drivers_autoprobe_attr.attr,
 	NULL,
 };
-- 
2.7.4
