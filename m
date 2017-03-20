Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53619 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752990AbdCTPVv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 11:21:51 -0400
From: bodong@mellanox.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        saeedm@mellanox.com, Bodong Wang <bodong@mellanox.com>,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH] pci/sriov: Add an option to probe VFs or not before enabling SR-IOV
Date: Mon, 20 Mar 2017 17:14:34 +0200
Message-Id: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bodong Wang <bodong@mellanox.com>

Sometimes it is not desirable to probe the virtual functions after
SRIOV is enabled. This can save host side resource usage by VF
instances which would be eventually probed to VMs.

Added a new PCI sysfs interface "sriov_probe_vfs" to control that
from PF, all current callers still retain the same functionality.
To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to

/sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs

Note that, the choice must be made before enabling VFs. The change
will not take effect if VFs are already enabled. Simply, one can set
sriov_numvfs to 0, choose whether to probe or not, and then resume
sriov_numvfs.

Change-Id: I48e6db1e8c7b364bb371590e2b13b4d7ee87713c
Signed-off-by: Bodong Wang <bodong@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 Documentation/PCI/pci-iov-howto.txt | 10 ++++++++++
 drivers/pci/iov.c                   |  1 +
 drivers/pci/pci-driver.c            | 15 +++++++++++----
 drivers/pci/pci-sysfs.c             | 28 ++++++++++++++++++++++++++++
 drivers/pci/pci.h                   |  1 +
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
index 2d91ae2..902a528 100644
--- a/Documentation/PCI/pci-iov-howto.txt
+++ b/Documentation/PCI/pci-iov-howto.txt
@@ -68,6 +68,16 @@ To disable SR-IOV capability:
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
+To enable probing VFs by a compatible driver on the host:
+Before enabling SR-IOV capabilities, do:
+	echo 1 > \
+        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
+
+To disable probing VFs by a compatible driver on the host:
+Before enabling SR-IOV capabilities, do:
+	echo  0 > \
+        /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
+
 3.2 Usage example
 
 Following piece of code illustrates the usage of the SR-IOV API.
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2479ae8..70691de 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -450,6 +450,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	iov->total_VFs = total;
 	iov->pgsz = pgsz;
 	iov->self = dev;
+	iov->probe_vfs = true;
 	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
 	pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index afa7271..930552c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -405,11 +405,18 @@ static int pci_device_probe(struct device *dev)
 		return error;
 
 	pci_dev_get(pci_dev);
-	error = __pci_device_probe(drv, pci_dev);
-	if (error) {
-		pcibios_free_irq(pci_dev);
-		pci_dev_put(pci_dev);
+#ifdef CONFIG_PCI_IOV
+	if (!pci_dev->is_virtfn ||
+	    (pci_dev->is_virtfn && pci_dev->physfn->sriov->probe_vfs)) {
+#endif
+		error = __pci_device_probe(drv, pci_dev);
+		if (error) {
+			pcibios_free_irq(pci_dev);
+			pci_dev_put(pci_dev);
+		}
+#ifdef CONFIG_PCI_IOV
 	}
+#endif
 
 	return error;
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25d010d..1d5b89d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -526,10 +526,37 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	return count;
 }
 
+static ssize_t sriov_probe_vfs_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->probe_vfs);
+}
+
+static ssize_t sriov_probe_vfs_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool probe_vfs;
+
+	if (kstrtobool(buf, &probe_vfs) < 0)
+		return -EINVAL;
+
+	pdev->sriov->probe_vfs = probe_vfs;
+
+	return count;
+}
+
 static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
 static struct device_attribute sriov_numvfs_attr =
 		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
 		       sriov_numvfs_show, sriov_numvfs_store);
+static struct device_attribute sriov_probe_vfs_attr =
+		__ATTR(sriov_probe_vfs, (S_IRUGO|S_IWUSR|S_IWGRP),
+		       sriov_probe_vfs_show, sriov_probe_vfs_store);
 #endif /* CONFIG_PCI_IOV */
 
 static ssize_t driver_override_store(struct device *dev,
@@ -1549,6 +1576,7 @@ static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
 static struct attribute *sriov_dev_attrs[] = {
 	&sriov_totalvfs_attr.attr,
 	&sriov_numvfs_attr.attr,
+	&sriov_probe_vfs_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8dd38e6..a62c6bf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -272,6 +272,7 @@ struct pci_sriov {
 	struct pci_dev *self;	/* this PF */
 	struct mutex lock;	/* lock for setting sriov_numvfs in sysfs */
 	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
+	bool probe_vfs;		/* probe VFs or not */
 };
 
 #ifdef CONFIG_PCI_ATS
-- 
1.8.3.1
