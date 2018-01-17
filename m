Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39033 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeAQRoz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 12:44:55 -0500
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-pci@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Store more data about VFs into the SRIOV struct
Date: Wed, 17 Jan 2018 18:44:23 +0100
Message-Id: <1516211063-1488-1-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

... to avoid reading them from the config space of all the PCI VFs. This is
specially a useful optimization when bringing up thousands of VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/pci/iov.c   | 20 ++++++++++++++++++--
 drivers/pci/pci.h   |  6 +++++-
 drivers/pci/probe.c | 42 ++++++++++++++++++++++++++++++++----------
 3 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 168328a..78e9595 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -129,7 +129,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	if (!dev->is_physfn)
 		return 0;
 
-	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
+	return dev->sriov->vf_barsz[resno - PCI_IOV_RESOURCES];
 }
 
 int batch_pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus **bus,
@@ -325,6 +325,20 @@ static void pci_iov_wq_fn(struct work_struct *work)
 	kfree(req);
 }
 
+static void pci_read_vf_config_common(struct pci_bus *bus,
+				      struct pci_dev *dev)
+{
+	int devfn = pci_iov_virtfn_devfn(dev, 0);
+
+	pci_bus_read_config_dword(bus, devfn, PCI_CLASS_REVISION,
+				  &dev->sriov->vf_class);
+	pci_bus_read_config_word(bus, devfn, PCI_SUBSYSTEM_ID,
+				 &dev->sriov->vf_subsystem_device);
+	pci_bus_read_config_word(bus, devfn, PCI_SUBSYSTEM_VENDOR_ID,
+				 &dev->sriov->vf_subsystem_vendor);
+	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &dev->sriov->vf_hdr_type);
+}
+
 static struct workqueue_struct *pci_iov_wq;
 
 static int __init init_pci_iov_wq(void)
@@ -361,6 +375,8 @@ static int enable_vfs(struct pci_dev *dev, int nr_vfs)
 			goto add_bus_fail;
 	}
 
+	pci_read_vf_config_common(bus[0], dev);
+
 	while (remaining_vfs > 0) {
 		bool ret;
 		struct pci_iov_wq_item *req;
@@ -617,7 +633,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 			rc = -EIO;
 			goto failed;
 		}
-		iov->barsz[i] = resource_size(res);
+		iov->vf_barsz[i] = resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
 		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
 			 i, res, i, total);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f6b58b3..3264c9e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -271,7 +271,11 @@ struct pci_sriov {
 	u16 driver_max_VFs;	/* max num VFs driver supports */
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
-	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
+	u8 vf_hdr_type;		/* VF header type */
+	u32 vf_class;		/* VF device */
+	u16 vf_subsystem_vendor;	/* VF subsystem vendor */
+	u16 vf_subsystem_device;	/* VF subsystem device */
+	resource_size_t vf_barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool drivers_autoprobe;	/* auto probing of VFs by driver */
 };
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1..65099d0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -175,6 +175,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int pos)
 {
+	int bar = res - dev->resource;
 	u32 l = 0, sz = 0, mask;
 	u64 l64, sz64, mask64;
 	u16 orig_cmd;
@@ -194,9 +195,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->name = pci_name(dev);
 
 	pci_read_config_dword(dev, pos, &l);
-	pci_write_config_dword(dev, pos, l | mask);
-	pci_read_config_dword(dev, pos, &sz);
-	pci_write_config_dword(dev, pos, l);
+	if (dev->is_virtfn) {
+		sz = dev->physfn->sriov->vf_barsz[bar] & 0xffffffff;
+	} else {
+		pci_write_config_dword(dev, pos, l | mask);
+		pci_read_config_dword(dev, pos, &sz);
+		pci_write_config_dword(dev, pos, l);
+	}
 
 	/*
 	 * All bits set in sz means the device isn't working properly.
@@ -236,9 +241,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	if (res->flags & IORESOURCE_MEM_64) {
 		pci_read_config_dword(dev, pos + 4, &l);
-		pci_write_config_dword(dev, pos + 4, ~0);
-		pci_read_config_dword(dev, pos + 4, &sz);
-		pci_write_config_dword(dev, pos + 4, l);
+
+		if (dev->is_virtfn) {
+			sz = (dev->physfn->sriov->vf_barsz[bar] >> 32) & 0xffffffff;
+		} else {
+			pci_write_config_dword(dev, pos + 4, ~0);
+			pci_read_config_dword(dev, pos + 4, &sz);
+			pci_write_config_dword(dev, pos + 4, l);
+		}
 
 		l64 |= ((u64)l << 32);
 		sz64 |= ((u64)sz << 32);
@@ -327,6 +337,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
+		if (dev->is_virtfn && dev->physfn->sriov->vf_barsz[pos] == 0)
+			continue;
 		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
 	}
 
@@ -1444,7 +1456,9 @@ int pci_setup_device(struct pci_dev *dev)
 	struct pci_bus_region region;
 	struct resource *res;
 
-	if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
+	if (dev->is_virtfn)
+		hdr_type = dev->physfn->sriov->vf_hdr_type;
+	else if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
 		return -EIO;
 
 	dev->sysdata = dev->bus->sysdata;
@@ -1464,7 +1478,10 @@ int pci_setup_device(struct pci_dev *dev)
 		     dev->bus->number, PCI_SLOT(dev->devfn),
 		     PCI_FUNC(dev->devfn));
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
+	if (dev->is_virtfn)
+		class = dev->physfn->sriov->vf_class;
+	else
+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
@@ -1503,8 +1520,13 @@ int pci_setup_device(struct pci_dev *dev)
 			goto bad;
 		pci_read_irq(dev);
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+		if (dev->is_virtfn) {
+			dev->subsystem_vendor = dev->physfn->sriov->vf_subsystem_vendor;
+			dev->subsystem_device = dev->physfn->sriov->vf_subsystem_device;
+		} else {
+			pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
+			pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+		}
 
 		/*
 		 * Do the ugly legacy mode stuff here rather than broken chip
-- 
2.7.4
