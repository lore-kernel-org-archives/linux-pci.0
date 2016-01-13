Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48172 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978AbcAMLZi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 06:25:38 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 3/4] pci: Determine actual VPD size on first access
Date: Wed, 13 Jan 2016 12:25:34 +0100
Message-Id: <1452684335-46107-4-git-send-email-hare@suse.de>
In-Reply-To: <1452684335-46107-1-git-send-email-hare@suse.de>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI-2.2 VPD entries have a maximum size of 32k, but might actually
be smaller than that. To figure out the actual size one has to read
the VPD area until the 'end marker' is reached.
Trying to read VPD data beyond that marker results in 'interesting'
effects, from simple read errors to crashing the card. And to make
matters worse not every PCI card implements this properly, leaving
us with no 'end' marker or even completely invalid data.
This path tries to determine the size of the VPD data.
If no valid data can be read an I/O error will be returned when
reading the sysfs attribute.

Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/access.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci-sysfs.c |  2 +-
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 59ac36f..914e023 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -284,9 +284,65 @@ struct pci_vpd_pci22 {
 	struct mutex lock;
 	u16	flag;
 	bool	busy;
+	bool	valid;
 	u8	cap;
 };
 
+/**
+ * pci_vpd_size - determine actual size of Vital Product Data
+ * @dev:	pci device struct
+ * @old_size:	current assumed size, also maximum allowed size
+ *
+ */
+static size_t
+pci_vpd_pci22_size(struct pci_dev *dev)
+{
+	size_t off = 0;
+	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
+
+	while (off < PCI_VPD_PCI22_SIZE &&
+	       pci_read_vpd(dev, off, 1, header) == 1) {
+		unsigned char tag;
+
+		if (header[0] & PCI_VPD_LRDT) {
+			/* Large Resource Data Type Tag */
+			tag = pci_vpd_lrdt_tag(header);
+			/* Only read length from known tag items */
+			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
+			    (tag == PCI_VPD_LTIN_RO_DATA) ||
+			    (tag == PCI_VPD_LTIN_RW_DATA)) {
+				if (pci_read_vpd(dev, off+1, 2,
+						 &header[1]) != 2) {
+					dev_dbg(&dev->dev,
+						"invalid large vpd tag %02x "
+						"size at offset %zu",
+						tag, off + 1);
+					break;
+				}
+				off += PCI_VPD_LRDT_TAG_SIZE +
+					pci_vpd_lrdt_size(header);
+			}
+		} else {
+			/* Short Resource Data Type Tag */
+			off += PCI_VPD_SRDT_TAG_SIZE +
+				pci_vpd_srdt_size(header);
+			tag = pci_vpd_srdt_tag(header);
+		}
+		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
+			return off;
+		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
+		    (tag != PCI_VPD_LTIN_RO_DATA) &&
+		    (tag != PCI_VPD_LTIN_RW_DATA)) {
+			dev_dbg(&dev->dev,
+				"invalid %s vpd tag %02x at offset %zu",
+				(header[0] & PCI_VPD_LRDT) ? "large" : "short",
+				tag, off);
+			break;
+		}
+	}
+	return 0;
+}
+
 /*
  * Wait for last operation to complete.
  * This code has to spin since there is no other notification from the PCI
@@ -337,9 +393,23 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
-	if (pos < 0 || pos > vpd->base.len || end > vpd->base.len)
+	if (pos < 0)
 		return -EINVAL;
 
+	if (!vpd->valid) {
+		vpd->valid = true;
+		vpd->base.len = pci_vpd_pci22_size(dev);
+	}
+	if (vpd->base.len == 0)
+		return -EIO;
+
+	if (end > vpd->base.len) {
+		if (pos > vpd->base.len)
+			return 0;
+		end = vpd->base.len;
+		count = end - pos;
+	}
+
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
 
@@ -389,6 +459,9 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
 	loff_t end = pos + count;
 	int ret = 0;
 
+	if (!vpd->valid)
+		return -EAGAIN;
+
 	if (pos < 0 || (pos & 3) || (count & 3) || end > vpd->base.len)
 		return -EINVAL;
 
@@ -496,6 +569,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
 	vpd->busy = false;
+	vpd->valid = false;
 	dev->vpd = &vpd->base;
 	return 0;
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index de327c3..31a1f35 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1333,7 +1333,7 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 			return -ENOMEM;
 
 		sysfs_bin_attr_init(attr);
-		attr->size = dev->vpd->len;
+		attr->size = 0;
 		attr->attr.name = "vpd";
 		attr->attr.mode = S_IRUSR | S_IWUSR;
 		attr->read = read_vpd_attr;
-- 
1.8.5.6

