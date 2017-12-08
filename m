Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23538 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752350AbdLHVsI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 16:48:08 -0500
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: alex.williamson@redhat.com
Cc: Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, alexander.h.duyck@intel.com
Subject: [PATCH v2] Enable SR-IOV instantiation through /sys file
Date: Fri,  8 Dec 2017 13:47:58 -0800
Message-Id: <20171208214758.6959-1-jeffrey.t.kirsher@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liang-Min Wang <liang-min.wang@intel.com>

When a SR-IOV capable device is bound with vfio-pci, the
device loses capability of creating SR-IOV instances through /sy/bus/
pci/devices/.../sriov_numvfs. This patch re-activates this capability
for a PCIe device that is SR-IOV capable and is bound with vfio-pci.ko.
This patch also disables drivers_autoprobe attribute of SR-IOV devices
created from vfio-pci bound device by default, so user-space PF device
can coordinate the bring-up of SR-IOV devices

Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
---
 drivers/pci/pci-driver.c    | 12 ++++++++++++
 drivers/vfio/pci/vfio_pci.c | 22 ++++++++++++++++++++++
 include/linux/pci.h         |  1 +
 3 files changed, 35 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7f47bb7..19522fe 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1467,6 +1467,18 @@ void pci_dev_put(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_dev_put);
 
+/**
+ * pci_dev_sriov_autoprobe_set - set device sriov driver autoprobe
+ * @dev: device with which sriov autoprobe will be set
+ *
+ */
+void pci_dev_sriov_autoprobe_set(struct pci_dev *dev, bool autoprobe)
+{
+	if (dev && dev->sriov)
+		dev->sriov->drivers_autoprobe = autoprobe;
+}
+EXPORT_SYMBOL(pci_dev_sriov_autoprobe_set);
+
 static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct pci_dev *pdev;
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index f041b1a..004836c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1213,6 +1213,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
+	/* disable sriov automatic driver attachment */
+	pci_dev_sriov_autoprobe_set(pdev, false);
 	vdev->pdev = pdev;
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	mutex_init(&vdev->igate);
@@ -1256,6 +1258,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 	if (!vdev)
 		return;
 
+	pci_disable_sriov(pdev);
 	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
 	kfree(vdev->region);
 	kfree(vdev);
@@ -1303,12 +1306,31 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 	.error_detected = vfio_pci_aer_err_detected,
 };
 
+static int vfio_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	int status;
+
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		return 0;
+	}
+
+	status = pci_enable_sriov(pdev, num_vfs);
+	if (!status) {
+		pr_crit("Created %d SR-IOV from a user-space driver based upon vfio-pci\n", num_vfs);
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	}
+
+	return status;
+}
+
 static struct pci_driver vfio_pci_driver = {
 	.name		= "vfio-pci",
 	.id_table	= NULL, /* only dynamic ids */
 	.probe		= vfio_pci_probe,
 	.remove		= vfio_pci_remove,
 	.err_handler	= &vfio_err_handlers,
+	.sriov_configure = vfio_sriov_configure,
 };
 
 struct vfio_devices {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0403894..e04b69d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -921,6 +921,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
 void pci_remove_bus(struct pci_bus *b);
+void pci_dev_sriov_autoprobe_set(struct pci_dev *dev, bool autoprobe);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
-- 
1.9.1
