Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965239Ab2JYSio (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 14:38:44 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 4/8] sriov: provide method to reduce the number of total VFs supported
Date: Thu, 25 Oct 2012 14:38:26 -0400
Message-Id: <1351190310-5043-5-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
References: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Some implementations of SRIOV provide a capability structure
 value of TotalVFs that is greater than what the software can support.
 Provide a method to reduce the capability structure reported value
 to the value the driver can support.
 This ensures sysfs reports the current capability of the system,
 hardware and software.
 Example for its use: igb & ixgbe -- report 8 & 64 as TotalVFs,
 but drivers only support 7 & 63 maximum.

Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/pci/iov.c       | 24 +++++++++++++++++++++++-
 drivers/pci/pci-sysfs.c | 10 ++++++++--
 drivers/pci/pci.h       |  1 +
 include/linux/pci.h     |  5 +++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index aeccc91..f1357b0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -682,7 +682,6 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 
 	if (!dev->is_physfn)
 		return -ENODEV;
-
 	return sriov_enable(dev, nr_virtfn);
 }
 EXPORT_SYMBOL_GPL(pci_enable_sriov);
@@ -735,3 +734,26 @@ int pci_num_vf(struct pci_dev *dev)
 		return dev->sriov->nr_virtfn;
 }
 EXPORT_SYMBOL_GPL(pci_num_vf);
+
+/**
+ * pci_sriov_set_totalvfs -- reduce the TotalVFs available
+ * @dev: the PCI PF device
+ * numvfs: number that should be used for TotalVFs supported
+ *
+ * Returns 0 if PF is an SRIOV-capable device and
+ * value of numvfs valid, otherwise -EINVAL
+ */
+int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
+{
+	if (!dev || !dev->is_physfn || (numvfs > dev->sriov->total))
+		return -EINVAL;
+
+	/* Shouldn't change if VFs already enabled */
+	if (!dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
+		return -EIO; 
+
+	dev->sriov->drvttl = numvfs;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2894ca..1cf6c15 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -414,7 +414,10 @@ static ssize_t sriov_totalvfs_show(struct device *dev,
 	u16 total;
 
 	pdev = to_pci_dev(dev);
-	total = pdev->sriov->total;
+	if (pdev->sriov->drvttl)
+		total = pdev->sriov->drvttl;
+	else
+		total = pdev->sriov->total;
 	return sprintf (buf, "%u\n", total);
 }
 
@@ -462,7 +465,10 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	}
 
 	/* if enabling vf's ... */
-	total = pdev->sriov->total;
+	if (pdev->sriov->drvttl)
+		total = pdev->sriov->drvttl;
+	else
+		total = pdev->sriov->total;
 	if ((num_vfs > 0) && (num_vfs <= total)) {
 		if (pdev->sriov->nr_virtfn == 0) { /* if not already enabled */
 		    num_vfs_enabled = pdev->driver->sriov_configure(pdev, num_vfs);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6f6cd14..553bbba 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -240,6 +240,7 @@ struct pci_sriov {
 	u16 stride;		/* following VF stride */
 	u32 pgsz;		/* page size for BAR alignment */
 	u8 link;		/* Function Dependency Link */
+	u16 drvttl;		/* max num VFs driver supports */
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
 	struct mutex lock;	/* lock for VF bus */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1d60a23..a5e08f2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1633,6 +1633,7 @@ extern int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 extern void pci_disable_sriov(struct pci_dev *dev);
 extern irqreturn_t pci_sriov_migration(struct pci_dev *dev);
 extern int pci_num_vf(struct pci_dev *dev);
+extern int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 #else
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 {
@@ -1649,6 +1650,10 @@ static inline int pci_num_vf(struct pci_dev *dev)
 {
 	return 0;
 }
+static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
1.7.10.2.552.gaa3bb87

