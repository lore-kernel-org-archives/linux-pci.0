Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbeBZDTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Feb 2018 22:19:13 -0500
Subject: [RFC PATCH V3] virtio_pci: Add SR-IOV support
To: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: Mark Rustad <mark.d.rustad@intel.com>
Cc: dan.daly@intel.com, alex.williamson@redhat.com, MRustad@gmail.com,
        alexander.duyck@gmail.com, mst@redhat.com
Date: Sun, 25 Feb 2018 19:19:11 -0800
Message-ID: <20180226031911.18980.80488.stgit@mdrustad-mac04.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hardware-realized virtio-pci devices can implement SR-IOV, so this
patch enables its use. The device in question is an upcoming Intel
NIC that implements both a virtio-net PF and virtio-net VFs. These
are hardware realizations of what has been up to now been a software
interface.

The device in question has the following 4-part PCI IDs:

PF: device: 1af4 vendor: 1041 subvendor: 8086 subdevice: 15fe
VF: device: 1af4 vendor: 1041 subvendor: 8086 subdevice: 05fe

The patch needs no check for device ID, because the callback will
never be made for devices that do not assert the capability or
when run on a platform incapable of SR-IOV.

One reason for this patch is because the hardware requires the
vendor ID of a VF to be the same as the vendor ID of the PF that
created it. So it seemed logical to simply have a fully-functioning
virtio-net PF create the VFs. This patch makes that possible.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
Changes in V3:
- Move most code to a new helper in pci/iov.c, pci_sriov_configure
Changes in V2:
- Simplified logic from previous version, removed added driver variable
- Disable SR-IOV on driver removal excapt when VFs are assigned
- Sent as RFC to virtio-dev, linux-pci, netdev, lkml and others
---
 drivers/pci/iov.c                  |   48 ++++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c |    2 ++
 include/linux/pci.h                |   10 ++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924ae0350..ddd44a9d93ec 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -367,6 +367,54 @@ static void sriov_disable(struct pci_dev *dev)
 	pci_iov_set_numvfs(dev, 0);
 }
 
+/**
+ * pci_sriov_disable - standard helper to disable SR-IOV
+ * @dev:the PCI PF device whose VFs are to be disabled
+ */
+int pci_sriov_disable(struct pci_dev *dev)
+{
+	/*
+	 * If vfs are assigned we cannot shut down SR-IOV without causing
+	 * issues, so just leave the hardware available.
+	 */
+	if (pci_vfs_assigned(dev)) {
+		pci_warn(&dev->dev,
+			 "Cannot disable SR-IOV while VFs are assigned - VFs will not be deallocated\n");
+		return -EPERM;
+	}
+	pci_disable_sriov(dev);
+	return 0;
+}
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
+	dev_info(dev, "SR-IOV enabled with %d VFs\n", num_vfs);
+	return num_vfs;
+}
+
+/**
+ * pci_sriov_configure - standard helper to configure SR-IOV
+ * @dev: the PCI PF device that is configuring SR-IOV
+ */
+int pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+{
+	if (num_vfs)
+		return pci_sriov_enable(dev, num_vfs);
+	if (!pci_num_vf(dev))
+		return -EINVAL;
+	return pci_sriov_disable(dev);
+}
+
 static int sriov_init(struct pci_dev *dev, int pos)
 {
 	int i, bar64;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 48d4d1cf1cb6..37e353c4f8b4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -584,6 +584,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	else
 		virtio_pci_modern_remove(vp_dev);
 
+	pci_sriov_disable(pci_dev);
 	pci_disable_device(pci_dev);
 	put_device(dev);
 }
@@ -596,6 +597,7 @@ static struct pci_driver virtio_pci_driver = {
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
+	.sriov_configure = pci_sriov_configure,
 };
 
 module_pci_driver(virtio_pci_driver);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..ef6b359afefd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1947,6 +1947,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
+int pci_sriov_disable(struct pci_dev *dev);
+int pci_sriov_configure(struct pci_dev *dev, int num_vfs);
 int pci_iov_add_virtfn(struct pci_dev *dev, int id);
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
@@ -1973,6 +1975,14 @@ static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 static inline void pci_iov_remove_virtfn(struct pci_dev *dev,
 					 int id) { }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
+static inline int pci_sriov_disable(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
+static inline int pci_sriov_configure(struct pci_dev *dev, int num_vfs)
+{
+	return -ENODEV;
+}
 static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
