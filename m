Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751947AbeBZEsj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Feb 2018 23:48:39 -0500
Subject: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for virtio_pci
 devices
To: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: Mark Rustad <mark.d.rustad@intel.com>
Cc: dan.daly@intel.com, alex.williamson@redhat.com, MRustad@gmail.com,
        alexander.duyck@gmail.com, mst@redhat.com
Date: Sun, 25 Feb 2018 20:48:38 -0800
Message-ID: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hardware-realized virtio_pci devices can implement SR-IOV, so this
patch enables its use. The device in question is an upcoming Intel
NIC that implements both a virtio_net PF and virtio_net VFs. These
are hardware realizations of what has been up to now been a software
interface.

The device in question has the following 4-part PCI IDs:

PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe

The patch needs no check for device ID, because the callback will
never be made for devices that do not assert the capability or
when run on a platform incapable of SR-IOV.

One reason for this patch is because the hardware requires the
vendor ID of a VF to be the same as the vendor ID of the PF that
created it. So it seemed logical to simply have a fully-functioning
virtio_net PF create the VFs. This patch makes that possible.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
Changes in V4:
- V3 was a mis-send, this has what was intended
- Move most code to new helpers in pci/iov.c, pci_sriov_configure_generic
  and pci_sriov_disable_generic
- Correct mislabeling of vendor and device IDs
- Other minor changelog fixes
- Rebased to pci/master, since most changes are in that area now
- No new ifdefs with this approach (yay)
Changes in V3:
- Missent patch, please disregard
Changes in V2:
- Simplified logic from previous version, removed added driver variable
- Disable SR-IOV on driver removal except when VFs are assigned
- Sent as RFC to virtio-dev, linux-pci, netdev, lkml and others
---
 drivers/pci/iov.c                  |   50 ++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c |    2 +
 include/linux/pci.h                |   10 +++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924ae0350..4b110e169b7c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -367,6 +367,56 @@ static void sriov_disable(struct pci_dev *dev)
 	pci_iov_set_numvfs(dev, 0);
 }
 
+/**
+ * pci_sriov_disable_generic - standard helper to disable SR-IOV
+ * @dev:the PCI PF device whose VFs are to be disabled
+ */
+int pci_sriov_disable_generic(struct pci_dev *dev)
+{
+	/*
+	 * If vfs are assigned we cannot shut down SR-IOV without causing
+	 * issues, so just leave the hardware available.
+	 */
+	if (pci_vfs_assigned(dev)) {
+		pci_warn(dev,
+			 "Cannot disable SR-IOV while VFs are assigned - VFs will not be deallocated\n");
+		return -EPERM;
+	}
+	pci_disable_sriov(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_sriov_disable_generic);
+
+static int pci_sriov_enable(struct pci_dev *dev, int num_vfs)
+{
+	int rc;
+
+	if (pci_num_vf(dev))
+		return -EINVAL;
+
+	rc = pci_enable_sriov(dev, num_vfs);
+	if (rc) {
+		pci_warn(dev, "Failed to enable PCI sriov: %d\n", rc);
+		return rc;
+	}
+	pci_info(dev, "SR-IOV enabled with %d VFs\n", num_vfs);
+	return num_vfs;
+}
+
+/**
+ * pci_sriov_configure_generic - standard helper to configure SR-IOV
+ * @dev: the PCI PF device that is configuring SR-IOV
+ */
+int pci_sriov_configure_generic(struct pci_dev *dev, int num_vfs)
+{
+	if (num_vfs)
+		return pci_sriov_enable(dev, num_vfs);
+	if (!pci_num_vf(dev))
+		return -EINVAL;
+	return pci_sriov_disable_generic(dev);
+}
+EXPORT_SYMBOL_GPL(pci_sriov_configure_generic);
+
 static int sriov_init(struct pci_dev *dev, int pos)
 {
 	int i, bar64;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 48d4d1cf1cb6..d7679377131f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -584,6 +584,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	else
 		virtio_pci_modern_remove(vp_dev);
 
+	pci_sriov_disable_generic(pci_dev);
 	pci_disable_device(pci_dev);
 	put_device(dev);
 }
@@ -596,6 +597,7 @@ static struct pci_driver virtio_pci_driver = {
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
+	.sriov_configure = pci_sriov_configure_generic,
 };
 
 module_pci_driver(virtio_pci_driver);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..937124d4e098 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1947,6 +1947,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
+int pci_sriov_disable_generic(struct pci_dev *dev);
+int pci_sriov_configure_generic(struct pci_dev *dev, int num_vfs);
 int pci_iov_add_virtfn(struct pci_dev *dev, int id);
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
@@ -1973,6 +1975,14 @@ static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 static inline void pci_iov_remove_virtfn(struct pci_dev *dev,
 					 int id) { }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
+static inline int pci_sriov_disable_generic(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
+static inline int pci_sriov_configure_generic(struct pci_dev *dev, int num_vfs)
+{
+	return -ENODEV;
+}
 static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
