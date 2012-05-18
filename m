Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5264 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030413Ab2EROQ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 10:16:56 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shyam Iyer <Shyam_Iyer@Dell.com>, gregkh@linuxfoundation.org,
	ddutile@redhat.com
Subject: Re: [PATCH] pci, Add AER_panic sysfs file
Date: Fri, 18 May 2012 10:16:46 -0400
Message-Id: <1337350606-32648-1-git-send-email-prarit@redhat.com>
In-Reply-To: <20120518045130.GA3281@kroah.com>
References: <20120518045130.GA3281@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, ... [v2] with missing Doc file.

P.

----8<----

Consider the following case

		[ RP ]
		  |
		  |
	+---------+-----------+
	|	  |	      |
       [H1]      [H2]        [X1]

where RP is a PCIE Root Port, H1 and H2 are devices with drivers that support
PCIE AER driver error handling (ie, they have pci_error_handlers defined in
the driver), and X1 is a device with a driver that does not support PCIE
AER driver error handling.

If the Root Port takes an error what currently happens is that the
bus resets and H1 & H2 call their slot_reset functions.  X1 does nothing.

In some cases a user may not wish the system to continue because X1 is
an unhardened driver.  In these cases, the system should not do a bus reset,
but rather the system should panic to avoid any further possible data
corruption.

This patch implements an AER_panic sysfs entry for each root port which
a user can modify.  AER_panic = 1, means the system will panic on a
PCIE error which would have normally resulted in a secondary bus reset.
The default is AER_panic = 0.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shyam Iyer <Shyam_Iyer@Dell.com>
Cc: gregkh@linuxfoundation.org
Cc: ddutile@redhat.com

[v2]: added missing Documentation/ABI/testing/sysfs-bus-pci
---
 Documentation/ABI/testing/sysfs-bus-pci |   10 +++++++
 drivers/pci/pci-sysfs.c                 |   42 ++++++++++++++++++++++++++++++-
 drivers/pci/pcie/aer/aerdrv.c           |    3 ++
 include/linux/pci.h                     |    1 +
 4 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 34f5110..e64d434 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -210,3 +210,13 @@ Users:
 		firmware assigned instance number of the PCI
 		device that can help in understanding the firmware
 		intended order of the PCI device.
+
+What:		/sys/bus/pci/devices/.../AER_panic
+Date:		May 2012
+Contact:	linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
+Description:
+		This file is present for PCIe Root Ports only and changes the
+		behavior when an AER event targets the port.
+		This attribute can have two values.  If the value is 0, this
+		PCIe bus will issue a bus reset on the secondary bus.  If the
+		value is 1, the kernel will panic.  The default value is 0.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a55e248..8c6d525 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1135,6 +1135,35 @@ static ssize_t reset_store(struct device *dev,
 
 static struct device_attribute reset_attr = __ATTR(reset, 0200, NULL, reset_store);
 
+static ssize_t AER_panic_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sprintf(buf, "%d\n", pdev->rp_AER_panic);
+}
+
+static ssize_t AER_panic_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if ((val > 1) || (val < 0))
+		return -EINVAL;
+
+	pdev->rp_AER_panic = val;
+
+	return count;
+}
+
+static struct device_attribute rp_AER_panic_attr =
+	      __ATTR(AER_panic, 0600, AER_panic_show, AER_panic_store);
+
 static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 {
 	int retval;
@@ -1169,8 +1198,16 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 			goto error;
 		dev->reset_fn = 1;
 	}
-	return 0;
 
+	/* PCIE Root Port panic-on-AER allows a user to configure each root
+	 * port to panic on an AER error instead of issuing a bus reset.
+	 */
+	if (dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT) {
+		retval = device_create_file(&dev->dev, &rp_AER_panic_attr);
+		if (retval)
+			goto error;
+	}
+	return 0;
 error:
 	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->vpd && dev->vpd->attr) {
@@ -1279,6 +1316,9 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 		device_remove_file(&dev->dev, &reset_attr);
 		dev->reset_fn = 0;
 	}
+
+	if (dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
+		device_remove_file(&dev->dev, &rp_AER_panic_attr);
 }
 
 /**
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 58ad791..dd6b352 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -346,6 +346,9 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	u32 reg32;
 	int pos;
 
+	if (dev->rp_AER_panic)
+		panic("%s: AER detected on Root Port", pci_name(dev));
+
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 
 	/* Disable Root's interrupt in response to error messages */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..a4e6a5a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -324,6 +324,7 @@ struct pci_dev {
 	unsigned int    is_hotplug_bridge:1;
 	unsigned int    __aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
+	unsigned int	rp_AER_panic:1; /* if 1, panic on AER bus reset */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.7.1

