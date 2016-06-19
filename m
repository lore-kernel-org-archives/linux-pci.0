Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:45459 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751676AbcFSMZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Jun 2016 08:25:53 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [PATCH v2 1/2] PCI: Extend PCI IOV API
Date: Sun, 19 Jun 2016 15:16:56 +0300
Message-Id: <1466338617-43027-2-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

1. Add pci_enable_sriov_with_override to allow
enabling sriov with a driver override
on the VFs.

2. Expose pci_iov_set_numvfs and pci_iov_resource_size
to make them available for other modules

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Haggai Eran <haggaie@mellanox.com>
---
 drivers/pci/iov.c   | 41 +++++++++++++++++++++++++++++++++--------
 include/linux/pci.h | 13 ++++++++++++-
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..5ffd926 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -41,7 +41,7 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
  *
  * Update iov->offset and iov->stride when NumVFs is written.
  */
-static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
+void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 {
 	struct pci_sriov *iov = dev->sriov;
 
@@ -49,6 +49,7 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
 }
+EXPORT_SYMBOL(pci_iov_set_numvfs);
 
 /*
  * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
@@ -112,8 +113,10 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
+EXPORT_SYMBOL(pci_iov_resource_size);
 
-int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
+int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset,
+		       char *driver_override)
 {
 	int i;
 	int rc = -ENOMEM;
@@ -154,14 +157,20 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 		rc = request_resource(res, &virtfn->resource[i]);
 		BUG_ON(rc);
 	}
-
 	if (reset)
 		__pci_reset_function(virtfn);
 
 	pci_device_add(virtfn, virtfn->bus);
 	mutex_unlock(&iov->dev->sriov->lock);
 
+	if (driver_override) {
+		virtfn->driver_override = kstrdup(driver_override, GFP_KERNEL);
+		if (!virtfn->driver_override)
+			goto failed1;
+	}
+
 	pci_bus_add_device(virtfn);
+
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
@@ -235,7 +244,8 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 	return 0;
 }
 
-static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
+static int sriov_enable(struct pci_dev *dev, int nr_virtfn,
+			char *driver_override)
 {
 	int rc;
 	int i;
@@ -321,7 +331,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	}
 
 	for (i = 0; i < initial; i++) {
-		rc = pci_iov_add_virtfn(dev, i, 0);
+		rc = pci_iov_add_virtfn(dev, i, 0, driver_override);
 		if (rc)
 			goto failed;
 	}
@@ -622,20 +632,35 @@ int pci_iov_bus_range(struct pci_bus *bus)
 }
 
 /**
- * pci_enable_sriov - enable the SR-IOV capability
+ * pci_enable_sriov_with_override - enable the SR-IOV capability
  * @dev: the PCI device
  * @nr_virtfn: number of virtual functions to enable
+ * driver_override: driver override for VFs
  *
  * Returns 0 on success, or negative on failure.
  */
-int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
+int pci_enable_sriov_with_override(struct pci_dev *dev, int nr_virtfn,
+				   char *driver_override)
 {
 	might_sleep();
 
 	if (!dev->is_physfn)
 		return -ENOSYS;
 
-	return sriov_enable(dev, nr_virtfn);
+	return sriov_enable(dev, nr_virtfn, driver_override);
+}
+EXPORT_SYMBOL_GPL(pci_enable_sriov_with_override);
+
+/**
+ * pci_enable_sriov - enable the SR-IOV capability
+ * @dev: the PCI device
+ * @nr_virtfn: number of virtual functions to enable
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
+{
+	return pci_enable_sriov_with_override(dev, nr_virtfn, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_enable_sriov);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..54b3059 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1739,15 +1739,20 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar);
 int pci_iov_virtfn_bus(struct pci_dev *dev, int id);
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
+int pci_enable_sriov_with_override(struct pci_dev *dev, int nr_virtfn,
+				   char *driver_override);
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
-int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset);
+int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset,
+		       char *driver_override);
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
+
+void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -1757,6 +1762,11 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 {
 	return -ENOSYS;
 }
+
+static inline int pci_enable_sriov_with_override(struct pci_dev *dev,
+						 int nr_virtfn,
+						 char *driver_override)
+{ return -ENODEV; }
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
 static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
@@ -1775,6 +1785,7 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 { return 0; }
+static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn) { }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
1.8.3.1

