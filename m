Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34657 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755528AbdDLWvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2017 18:51:53 -0400
From: bodong@mellanox.com
To: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        saeedm@mellanox.com, Bodong Wang <bodong@mellanox.com>,
        Eli Cohen <eli@mellanox.com>
Subject: [v3] PCI: Add an option to control probing of VFs before enabling SR-IOV
Date: Thu, 13 Apr 2017 01:51:40 +0300
Message-Id: <1492037500-84654-1-git-send-email-bodong@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bodong Wang <bodong@mellanox.com>

Sometimes it is not desirable to probe the virtual functions after
SRIOV is enabled. This can save host side resource usage by VF
instances which would be eventually probed to VMs.

Add a new PCI sysfs interface "sriov_drivers_autoprobe" to control
that from the PF, all current callers still retain the same
functionality. To modify it, echo 0/n/N (disable probe) or 1/y/Y
(enable probe) to:

/sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe

Note that, the choice must be made before enabling VFs. The change
will not take effect if VFs are already enabled. Simply, one can set
sriov_numvfs to 0, choose whether to probe or not, and then resume
sriov_numvfs.

Signed-off-by: Bodong Wang <bodong@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci |   18 ++++++++++++++++++
 Documentation/PCI/pci-iov-howto.txt     |   12 ++++++++++++
 drivers/pci/iov.c                       |    1 +
 drivers/pci/pci-driver.c                |   22 ++++++++++++++++++----
 drivers/pci/pci-sysfs.c                 |   28 ++++++++++++++++++++++++++++
 drivers/pci/pci.h                       |    1 +
 6 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5a1732b..0878520 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -301,3 +301,21 @@ Contact:	Emil Velikov <emil.l.velikov@gmail.com>
 Description:
 		This file contains the revision field of the the PCI device.
 		The value comes from device config space. The file is read only.
+
+What:		/sys/bus/pci/devices/.../sriov_drivers_autoprobe
+Date:		April 2017
+Contact:	Bodong Wang<bodong@mellanox.com>
+Description:
+		This file appears when a physical PCIe device supports SR-IOV.
+		Userspace applications can read and write to this file to
+		determine and control the enablement(1/y/Y) or disablement
+		(0/n/N) of probing Virtual Functions (VFs) by a compatible
+		driver on host side. The default value is 1(enabled) which means
+		VFs will be probed and bound to a compatible driver on the host
+		side if SR-IOV is enabled. A typical use case is writing 0 to
+		this file to disable SR-IOV drivers auto probe, then admin from
+		host is able to assign the newly created VFs to virtual machines
+		directly after SR-IOV is enabled. Note that, changing this file
+		will not affect VFs which are already probed by host. In this
+		scenario, the user must first disable SR-IOV, make the change,
+		then resume SR-IOV.
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
index 2d91ae2..b6807df 100644
--- a/Documentation/PCI/pci-iov-howto.txt
+++ b/Documentation/PCI/pci-iov-howto.txt
@@ -68,6 +68,18 @@ To disable SR-IOV capability:
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
+To enable auto probing VFs by a compatible driver on the host, run
+command bellow before enabling SR-IOV capabilities. This is the
+default behavior.
+	echo 1 > \
+        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
+
+To disable auto probing VFs by a compatible driver on the host, run
+command bellow before enabling SR-IOV capabilities. Updating this
+entry will not affect VFs which are already probed.
+	echo  0 > \
+        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
+
 3.2 Usage example
 
 Following piece of code illustrates the usage of the SR-IOV API.
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2479ae8..d9dc736 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -450,6 +450,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	iov->total_VFs = total;
 	iov->pgsz = pgsz;
 	iov->self = dev;
+	iov->drivers_autoprobe = true;
 	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
 	pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index afa7271..f99f7fe 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -394,6 +394,18 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
 {
 }
 
+#ifdef CONFIG_PCI_IOV
+static inline bool pci_device_can_probe(struct pci_dev *pdev)
+{
+	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe);
+}
+#else
+static inline bool pci_device_can_probe(struct pci_dev *pdev)
+{
+	return true;
+}
+#endif
+
 static int pci_device_probe(struct device *dev)
 {
 	int error;
@@ -405,10 +417,12 @@ static int pci_device_probe(struct device *dev)
 		return error;
 
 	pci_dev_get(pci_dev);
-	error = __pci_device_probe(drv, pci_dev);
-	if (error) {
-		pcibios_free_irq(pci_dev);
-		pci_dev_put(pci_dev);
+	if (pci_device_can_probe(pci_dev)) {
+		error = __pci_device_probe(drv, pci_dev);
+		if (error) {
+			pcibios_free_irq(pci_dev);
+			pci_dev_put(pci_dev);
+		}
 	}
 
 	return error;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25d010d..369c999 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -526,10 +526,37 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	return count;
 }
 
+static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->drivers_autoprobe);
+}
+
+static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool drivers_autoprobe;
+
+	if (kstrtobool(buf, &drivers_autoprobe) < 0)
+		return -EINVAL;
+
+	pdev->sriov->drivers_autoprobe = drivers_autoprobe;
+
+	return count;
+}
+
 static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
 static struct device_attribute sriov_numvfs_attr =
 		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
 		       sriov_numvfs_show, sriov_numvfs_store);
+static struct device_attribute sriov_drivers_autoprobe_attr =
+		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
+		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
 #endif /* CONFIG_PCI_IOV */
 
 static ssize_t driver_override_store(struct device *dev,
@@ -1549,6 +1576,7 @@ static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
 static struct attribute *sriov_dev_attrs[] = {
 	&sriov_totalvfs_attr.attr,
 	&sriov_numvfs_attr.attr,
+	&sriov_drivers_autoprobe_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8dd38e6..3ba7d58 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -272,6 +272,7 @@ struct pci_sriov {
 	struct pci_dev *self;	/* this PF */
 	struct mutex lock;	/* lock for setting sriov_numvfs in sysfs */
 	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
+	bool drivers_autoprobe;	/* auto probing of VFs by driver */
 };
 
 #ifdef CONFIG_PCI_ATS
-- 
1.7.1
