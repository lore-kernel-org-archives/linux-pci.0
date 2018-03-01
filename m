Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:34187 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030379AbeCAN0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 08:26:39 -0500
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] pci: Store more data about VFs into the SRIOV struct
Date: Thu,  1 Mar 2018 14:26:04 +0100
Message-Id: <1519910764-12789-1-git-send-email-karahmed@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

... to avoid reading them from the config space of all the PCI VFs. This is
specially a useful optimization when bringing up thousands of VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
* Rebase on latest + remove dependency on a non-upstream patch.

 drivers/pci/iov.c   | 16 ++++++++++++++++
 drivers/pci/pci.h   |  5 +++++
 drivers/pci/probe.c | 42 ++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924a..e1d2e3f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -114,6 +114,19 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
 
+static void pci_read_vf_config_common(struct pci_bus *bus, struct pci_dev *dev)
+{
+	int devfn = pci_iov_virtfn_devfn(dev, 0);
+
+	pci_bus_read_config_dword(bus, devfn, PCI_CLASS_REVISION,
+				  &dev->sriov->class);
+	pci_bus_read_config_word(bus, devfn, PCI_SUBSYSTEM_ID,
+				 &dev->sriov->subsystem_device);
+	pci_bus_read_config_word(bus, devfn, PCI_SUBSYSTEM_VENDOR_ID,
+				 &dev->sriov->subsystem_vendor);
+	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &dev->sriov->hdr_type);
+}
+
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	int i;
@@ -133,6 +146,9 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	if (!virtfn)
 		goto failed0;
 
+	if (id == 0)
+		pci_read_vf_config_common(bus, dev);
+
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd8191..346daa5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -271,6 +271,11 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
+	u8 hdr_type;		/* VF header type */
+	u32 class;		/* VF device */
+	u16 device;		/* VF device */
+	u16 subsystem_vendor;	/* VF subsystem vendor */
+	u16 subsystem_device;	/* VF subsystem device */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ef53774..aeaa10a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -180,6 +180,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int pos)
 {
+	int bar = res - dev->resource;
 	u32 l = 0, sz = 0, mask;
 	u64 l64, sz64, mask64;
 	u16 orig_cmd;
@@ -199,9 +200,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->name = pci_name(dev);
 
 	pci_read_config_dword(dev, pos, &l);
-	pci_write_config_dword(dev, pos, l | mask);
-	pci_read_config_dword(dev, pos, &sz);
-	pci_write_config_dword(dev, pos, l);
+	if (dev->is_virtfn) {
+		sz = dev->physfn->sriov->barsz[bar] & 0xffffffff;
+	} else {
+		pci_write_config_dword(dev, pos, l | mask);
+		pci_read_config_dword(dev, pos, &sz);
+		pci_write_config_dword(dev, pos, l);
+	}
 
 	/*
 	 * All bits set in sz means the device isn't working properly.
@@ -241,9 +246,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	if (res->flags & IORESOURCE_MEM_64) {
 		pci_read_config_dword(dev, pos + 4, &l);
-		pci_write_config_dword(dev, pos + 4, ~0);
-		pci_read_config_dword(dev, pos + 4, &sz);
-		pci_write_config_dword(dev, pos + 4, l);
+
+		if (dev->is_virtfn) {
+			sz = (dev->physfn->sriov->barsz[bar] >> 32) & 0xffffffff;
+		} else {
+			pci_write_config_dword(dev, pos + 4, ~0);
+			pci_read_config_dword(dev, pos + 4, &sz);
+			pci_write_config_dword(dev, pos + 4, l);
+		}
 
 		l64 |= ((u64)l << 32);
 		sz64 |= ((u64)sz << 32);
@@ -332,6 +342,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	for (pos = 0; pos < howmany; pos++) {
 		struct resource *res = &dev->resource[pos];
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
+		if (dev->is_virtfn && dev->physfn->sriov->barsz[pos] == 0)
+			continue;
 		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
 	}
 
@@ -1454,7 +1466,9 @@ int pci_setup_device(struct pci_dev *dev)
 	struct pci_bus_region region;
 	struct resource *res;
 
-	if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
+	if (dev->is_virtfn)
+		hdr_type = dev->physfn->sriov->hdr_type;
+	else if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
 		return -EIO;
 
 	dev->sysdata = dev->bus->sysdata;
@@ -1477,7 +1491,10 @@ int pci_setup_device(struct pci_dev *dev)
 		     dev->bus->number, PCI_SLOT(dev->devfn),
 		     PCI_FUNC(dev->devfn));
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
+	if (dev->is_virtfn)
+		class = dev->physfn->sriov->class;
+	else
+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
@@ -1517,8 +1534,13 @@ int pci_setup_device(struct pci_dev *dev)
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
