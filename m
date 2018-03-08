Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45613 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeCHTCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 14:02:32 -0500
Subject: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
Date: Thu, 08 Mar 2018 11:02:29 -0800
Message-ID: <20180308190047.5433.77952.stgit@localhost.localdomain>
In-Reply-To: <20180308185507.5433.98830.stgit@localhost.localdomain>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This patch is meant to add some basic functionality to support for SR-IOV
on devices when the VFs are not managed by some other entity in the device
other than the kernel.

A new sysfs value called sriov_unmanaged_autoprobe has been added. This
value is used as the drivers_autoprobe setting of the VFs when they are
being managed by an external entity such as device firmware instead of
being managed by the kernel.

One side effect of this change is that the sriov_drivers_autoprobe and
sriov_unmanaged_autoprobe will only apply their updates when SR-IOV VFs
are allocated. Attempts to update them when SR-IOV is in use will only
update the local value and will not update sriov->autoprobe.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v3: Updated documentation to better explain sriov_unmanaged_autoprobe use
v4: Further documentation updates
    Added bits so that sriov->autoprobe is not updated while VFs are active
    Added code to check for assigned VFs in pci_sriov_configure_unamanged

 Documentation/ABI/testing/sysfs-bus-pci |   25 ++++++++++++++++++
 drivers/pci/iov.c                       |   42 +++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c                |    2 +
 drivers/pci/pci-sysfs.c                 |   29 +++++++++++++++++++++
 drivers/pci/pci.h                       |    4 ++-
 include/linux/pci.h                     |    1 +
 6 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 44d4b2be92fd..82c9520e365f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -323,3 +323,28 @@ Description:
 
 		This is similar to /sys/bus/pci/drivers_autoprobe, but
 		affects only the VFs associated with a specific PF.
+
+What:		/sys/bus/pci/devices/.../sriov_unmanaged_autoprobe
+Date:		March 2018
+Contact:	Alexander Duyck <alexander.h.duyck@intel.com>
+Description:
+		This file is associated with the PF of a device that
+		supports SR-IOV.  It determines whether newly-enabled VFs
+		are immediately bound to a driver when the PF driver does
+		not manage the VFs itself.  It initially contains 0, which
+		means the kernel will not automatically bind VFs to a driver.
+		If an application writes 1 to the file before enabling VFs,
+		the kernel will bind VFs to a compatible driver immediately
+		after they are enabled.
+
+		Currently the use of this setting is limited to drivers that
+		make use of pci_sriov_configure_unmanaged. Examples might
+		include drivers such as virtio_net which would be exposed as
+		a PCIe PF due to the fact that a given device exposes all of
+		the VFs and PFs as the same general device type but can add
+		the SR-IOV configuration bits to the configuration space of
+		the PF.
+
+		This overrides /sys/bus/pci/devices/.../sriov_drivers_autoprobe
+		when a PF driver does not provide functionality to manage the
+		VFs when SR-IOV is enabled.
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924ae0350..9415a006d064 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -446,6 +446,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_device);
 	iov->pgsz = pgsz;
 	iov->self = dev;
+	iov->autoprobe = true;
 	iov->drivers_autoprobe = true;
 	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
 	pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
@@ -683,6 +684,12 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 	if (!dev->is_physfn)
 		return -ENOSYS;
 
+	if (dev->sriov->num_VFs)
+		return -EINVAL;
+
+	/* Update autoprobe setting to reflect managed device */
+	dev->sriov->autoprobe = dev->sriov->drivers_autoprobe;
+
 	return sriov_enable(dev, nr_virtfn);
 }
 EXPORT_SYMBOL_GPL(pci_enable_sriov);
@@ -807,3 +814,38 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
 	return dev->sriov->total_VFs;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
+
+/**
+ * pci_sriov_configure_unmanaged - helper to configure unmanaged SR-IOV
+ * @dev: the PCI device
+ * @nr_virtfn: number of virtual functions to enable, 0 to disable
+ *
+ * Used to provide generic enable/disable SR-IOV option for devices
+ * that do not manage the VFs generated by their driver, or have no
+ * driver present.
+ */
+int pci_sriov_configure_unmanaged(struct pci_dev *dev, int nr_virtfn)
+{
+	int err = -EINVAL;
+
+	might_sleep();
+
+	if (!dev->is_physfn)
+		return -ENODEV;
+
+	if (pci_vfs_assigned(dev)) {
+		pci_warn(dev,
+			 "Cannot modify SR-IOV while VFs are assigned\n");
+		err = -EPERM;
+	} else if (!nr_virtfn) {
+		sriov_disable(dev);
+		err = 0;
+	} else if (!dev->sriov->num_VFs) {
+		/* Update autoprobe setting to reflect unmanaged device */
+		dev->sriov->autoprobe = dev->sriov->unmanaged_autoprobe;
+		err = sriov_enable(dev, nr_virtfn);
+	}
+
+	return err ? err : nr_virtfn;
+}
+EXPORT_SYMBOL_GPL(pci_sriov_configure_unmanaged);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6beda051..2cc68dff6130 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -398,7 +398,7 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
 #ifdef CONFIG_PCI_IOV
 static inline bool pci_device_can_probe(struct pci_dev *pdev)
 {
-	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe);
+	return (!pdev->is_virtfn || pdev->physfn->sriov->autoprobe);
 }
 #else
 static inline bool pci_device_can_probe(struct pci_dev *pdev)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index eb6bee8724cc..6f78fa73e317 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -710,6 +710,30 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 	return count;
 }
 
+static ssize_t sriov_unmanaged_autoprobe_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%u\n", pdev->sriov->unmanaged_autoprobe);
+}
+
+static ssize_t sriov_unmanaged_autoprobe_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	bool unmanaged_autoprobe;
+
+	if (kstrtobool(buf, &unmanaged_autoprobe) < 0)
+		return -EINVAL;
+
+	pdev->sriov->unmanaged_autoprobe = unmanaged_autoprobe;
+
+	return count;
+}
+
 static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
 static struct device_attribute sriov_numvfs_attr =
 		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
@@ -720,6 +744,10 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 static struct device_attribute sriov_drivers_autoprobe_attr =
 		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
 		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
+static struct device_attribute sriov_unmanaged_autoprobe_attr =
+		__ATTR(sriov_unmanaged_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
+		       sriov_unmanaged_autoprobe_show,
+		       sriov_unmanaged_autoprobe_store);
 #endif /* CONFIG_PCI_IOV */
 
 static ssize_t driver_override_store(struct device *dev,
@@ -1789,6 +1817,7 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	&sriov_stride_attr.attr,
 	&sriov_vf_device_attr.attr,
 	&sriov_drivers_autoprobe_attr.attr,
+	&sriov_unmanaged_autoprobe_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd81911b127..b5f8b034f02d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -272,7 +272,9 @@ struct pci_sriov {
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
-	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
+	bool		autoprobe;	/* Auto probing of VFs by VF driver */
+	bool		drivers_autoprobe;	/* "" managed by PF driver */
+	bool		unmanaged_autoprobe;	/* "" unmanaged by kernel */
 };
 
 /* pci_dev priv_flags */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..553860a08131 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1953,6 +1953,7 @@ static inline void pci_mmcfg_late_init(void) { }
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
+int pci_sriov_configure_unmanaged(struct pci_dev *dev, int nr_virtfn);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
 #else
