Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61330 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161500AbeCAVbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 16:31:49 -0500
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 1/2] PCI/IOV: Store more data about VFs into the SRIOV struct
Date: Thu,  1 Mar 2018 22:31:36 +0100
Message-Id: <1519939897-14596-1-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Store more data about PCI VFs into the SRIOV to avoid reading them from the
config space of all the PCI VFs. This is specially a useful optimization
when bringing up thousands of VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v2 -> v3:
 * Update changelog
 * Move the call to pci_read_vf_config_common a bit later and use standard
   pci_read_config*.
 * Update whitespace.
 * Move the using barsz into its own patch.
 * Added a comment about the usage of subsystem vendor id, subsystem id, and
   class revision.
 * Make sure virtfn->is_virtfn is set before calling into pci_setup_device.

v1 -> v2:
 * Rebase on latest + remove dependency on a non-upstream patch.

 drivers/pci/iov.c   | 48 +++++++++++++++++++++++++++++++++++++++++-------
 drivers/pci/pci.h   |  5 +++++
 drivers/pci/probe.c | 18 ++++++++++++++----
 3 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924a..10291a0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -114,6 +114,36 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
 
+static void pci_read_vf_config_common(struct pci_dev *virtfn)
+{
+	struct pci_dev *physfn = virtfn->physfn;
+
+	BUG_ON(!virtfn->is_virtfn || physfn->is_virtfn);
+
+	/*
+	 * Per PCIe r4.0, sec 9.3.4.1.5, the value reported in the VF maybe
+	 * different than the value reported in the PF. We assume here that all
+	 * VFs would report the same revision ID.
+	 */
+	pci_read_config_dword(virtfn, PCI_CLASS_REVISION,
+			      &physfn->sriov->class);
+	/*
+	 * Per PCIe r4.0, sec 9.3.4.1.13, the field in the PF and the
+	 * associated VFs must return the same value.
+	 */
+	pci_read_config_word(virtfn, PCI_SUBSYSTEM_VENDOR_ID,
+			     &physfn->sriov->subsystem_vendor);
+	/*
+	 * Per PCIe r4.0, sec 9.3.4.1.14, the value reported in the VF maybe
+	 * different than the value reported in the PF. We assume here that all
+	 * VFs would report the same subsystem ID.
+	 */
+	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
+			     &physfn->sriov->subsystem_device);
+	pci_read_config_byte(virtfn, PCI_HEADER_TYPE,
+			     &physfn->sriov->hdr_type);
+}
+
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	int i;
@@ -134,15 +164,18 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		goto failed0;
 
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
+	virtfn->is_virtfn = 1;
+	virtfn->physfn = pci_dev_get(dev);
+	if (id == 0)
+		/* virtfn->{devfn,bus,is_virtfn,physfn} have to be initialized */
+		pci_read_vf_config_common(virtfn);
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
 	rc = pci_setup_device(virtfn);
 	if (rc)
-		goto failed0;
+		goto failed1;
 
 	virtfn->dev.parent = dev->dev.parent;
-	virtfn->physfn = pci_dev_get(dev);
-	virtfn->is_virtfn = 1;
 	virtfn->multifunction = 0;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -163,10 +196,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
-		goto failed1;
+		goto failed2;
 	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
 	if (rc)
-		goto failed2;
+		goto failed3;
 
 	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
@@ -174,11 +207,12 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 
 	return 0;
 
-failed2:
+failed3:
 	sysfs_remove_link(&dev->dev.kobj, buf);
+failed2:
+	pci_stop_and_remove_bus_device(virtfn);
 failed1:
 	pci_dev_put(dev);
-	pci_stop_and_remove_bus_device(virtfn);
 failed0:
 	virtfn_remove_bus(dev->bus, bus);
 failed:
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd8191..17e6688 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -271,6 +271,11 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
+	u8		hdr_type;	/* VF header type */
+	u32		class;		/* VF device */
+	u16		device;		/* VF device */
+	u16		subsystem_vendor; /* VF subsystem vendor */
+	u16		subsystem_device; /* VF subsystem device */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef53774..a96837e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1454,7 +1454,9 @@ int pci_setup_device(struct pci_dev *dev)
 	struct pci_bus_region region;
 	struct resource *res;
 
-	if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
+	if (dev->is_virtfn)
+		hdr_type = dev->physfn->sriov->hdr_type;
+	else if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
 		return -EIO;
 
 	dev->sysdata = dev->bus->sysdata;
@@ -1477,7 +1479,10 @@ int pci_setup_device(struct pci_dev *dev)
 		     dev->bus->number, PCI_SLOT(dev->devfn),
 		     PCI_FUNC(dev->devfn));
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
+	if (dev->is_virtfn)
+		class = dev->physfn->sriov->class;
+	else
+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
@@ -1517,8 +1522,13 @@ int pci_setup_device(struct pci_dev *dev)
 			goto bad;
 		pci_read_irq(dev);
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+		if (dev->is_virtfn) {
+			dev->subsystem_vendor = dev->physfn->sriov->subsystem_vendor;
+			dev->subsystem_device = dev->physfn->sriov->subsystem_device;
+		} else {
+			pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
+			pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+		}
 
 		/*
 		 * Do the ugly legacy mode stuff here rather than broken chip
-- 
2.7.4
