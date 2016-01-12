Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] pci: Update VPD size with correct length
Date: Tue, 12 Jan 2016 15:42:29 +0100
Message-Id: <1452609750-90760-3-git-send-email-hare@suse.de>
In-Reply-To: <1452609750-90760-1-git-send-email-hare@suse.de>
References: <1452609750-90760-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI-2.2 VPD entries have a maximum size of 32k, but might actually
be smaller than that. To figure out the actual size one has to read
the VPD area until the 'end marker' is reached.
Trying to read VPD data beyond that marker results in 'interesting'
effects, from simple read errors to crashing the card. And to make
matters worse not every PCI card implements this properly, leaving
us with no 'end' marker or even completely invalid data.
This path modifies the size of the VPD attribute to the available
size, or set it to '0' if the VPD attribute couldn't be read.

Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/access.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 59ac36f..ce1b0cb 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -475,6 +475,61 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.release = pci_vpd_pci22_release,
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
 int pci_vpd_pci22_init(struct pci_dev *dev)
 {
 	struct pci_vpd_pci22 *vpd;
@@ -497,6 +552,8 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	vpd->cap = cap;
 	vpd->busy = false;
 	dev->vpd = &vpd->base;
+	if (!(dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0))
+		vpd->base.len = pci_vpd_pci22_size(dev);
 	return 0;
 }
 
-- 
1.8.5.6
