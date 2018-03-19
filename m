Return-Path: <SRS0=cIp0=GJ=amazon.com=prvs=6098dda2b=karahmed@kernel.org>
Return-Path: <SRS0=cIp0=GJ=amazon.com=prvs=6098dda2b=karahmed@kernel.org>
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v4 1/2] PCI/IOV: Use VF0 cached config registers for other VFs
Date: Mon, 19 Mar 2018 21:06:00 +0100
Message-Id: <1521489961-18291-1-git-send-email-karahmed@amazon.de>
List-ID: <linux-pci.vger.kernel.org>

Cache some config data from VF0 and use it for all other VFs instead of
reading it from the config space of each VF.  We assume these items are the
same across all associated VFs:

   Revision ID
   Class Code
   Subsystem Vendor ID
   Subsystem ID

This is an optimization when enabling SR-IOV on a device with many VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
[bhelgaas: changelog, simplify comments, remove unused "device"]
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
---
v3->v4:
- Restructure the code to handle CONFIG_PCI_ATS

 drivers/pci/iov.c   | 42 +++++++++++++++++++++++++++++++++++-------
 drivers/pci/pci.h   |  4 ++++
 drivers/pci/probe.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924a..30bf8f7 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -114,6 +114,29 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
 
+static void pci_read_vf_config_common(struct pci_dev *virtfn)
+{
+	struct pci_dev *physfn = virtfn->physfn;
+
+	/*
+	 * Some config registers are the same across all associated VFs.
+	 * Read them once from VF0 so we can skip reading them from the
+	 * other VFs.
+	 *
+	 * PCIe r4.0, sec 9.3.4.1, technically doesn't require all VFs to
+	 * have the same Revision ID and Subsystem ID, but we assume they
+	 * do.
+	 */
+	pci_read_config_dword(virtfn, PCI_CLASS_REVISION,
+			      &physfn->sriov->class);
+	pci_read_config_byte(virtfn, PCI_HEADER_TYPE,
+			     &physfn->sriov->hdr_type);
+	pci_read_config_word(virtfn, PCI_SUBSYSTEM_VENDOR_ID,
+			     &physfn->sriov->subsystem_vendor);
+	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
+			     &physfn->sriov->subsystem_device);
+}
+
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	int i;
@@ -136,13 +159,17 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
+	virtfn->is_virtfn = 1;
+	virtfn->physfn = pci_dev_get(dev);
+
+	if (id == 0)
+		pci_read_vf_config_common(virtfn);
+
 	rc = pci_setup_device(virtfn);
 	if (rc)
-		goto failed0;
+		goto failed1;
 
 	virtfn->dev.parent = dev->dev.parent;
-	virtfn->physfn = pci_dev_get(dev);
-	virtfn->is_virtfn = 1;
 	virtfn->multifunction = 0;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -163,10 +190,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
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
 
@@ -174,11 +201,12 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 
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
index fcd8191..bdb4ba2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -271,6 +271,10 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
+	u32		class;		/* VF device */
+	u8		hdr_type;	/* VF header type */
+	u16		subsystem_vendor; /* VF subsystem vendor */
+	u16		subsystem_device; /* VF subsystem device */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef53774..21ee1c3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1389,6 +1389,43 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	return PCI_CFG_SPACE_SIZE;
 }
 
+static int pci_cfg_space_class(struct pci_dev *dev)
+{
+	int class;
+
+#ifdef CONFIG_PCI_ATS
+	if (dev->is_virtfn)
+		return dev->physfn->sriov->class;
+#endif
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
+	return class;
+}
+
+static void pci_cfg_space_subsystem(struct pci_dev *dev, u16 *vendor, u16 *device)
+{
+#ifdef CONFIG_PCI_ATS
+	if (dev->is_virtfn) {
+		*vendor = dev->physfn->sriov->subsystem_vendor;
+		*device = dev->physfn->sriov->subsystem_device;
+		return;
+	}
+#endif
+	pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, vendor);
+	pci_read_config_word(dev, PCI_SUBSYSTEM_ID, device);
+}
+
+static u8 pci_cfg_space_hdr_type(struct pci_dev *dev)
+{
+	u8 hdr_type;
+
+#ifdef CONFIG_PCI_ATS
+	if (dev->is_virtfn)
+		return dev->physfn->sriov->hdr_type;
+#endif
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
+	return hdr_type;
+}
+
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
 static void pci_msi_setup_pci_dev(struct pci_dev *dev)
@@ -1454,8 +1491,7 @@ int pci_setup_device(struct pci_dev *dev)
 	struct pci_bus_region region;
 	struct resource *res;
 
-	if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
-		return -EIO;
+	hdr_type = pci_cfg_space_hdr_type(dev);
 
 	dev->sysdata = dev->bus->sysdata;
 	dev->dev.parent = dev->bus->bridge;
@@ -1477,7 +1513,8 @@ int pci_setup_device(struct pci_dev *dev)
 		     dev->bus->number, PCI_SLOT(dev->devfn),
 		     PCI_FUNC(dev->devfn));
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
+	class = pci_cfg_space_class(dev);
+
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
@@ -1517,8 +1554,8 @@ int pci_setup_device(struct pci_dev *dev)
 			goto bad;
 		pci_read_irq(dev);
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+
+		pci_cfg_space_subsystem(dev, &dev->subsystem_vendor, &dev->subsystem_device);
 
 		/*
 		 * Do the ugly legacy mode stuff here rather than broken chip
-- 
2.7.4
