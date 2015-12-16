Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50781 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbbLPKt4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Dec 2015 05:49:56 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Michal Kubecek <mkubecek@suse.com>
Subject: [PATCHv2] pci: Update VPD size with correct length
Date: Wed, 16 Dec 2015 11:49:52 +0100
Message-Id: <1450262992-77276-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI-2.2 VPD entries have a maximum size of 32k, but might actually
be smaller than that. To figure out the actual size one has to read
the VPD area until the 'end marker' is reached.
Trying to read VPD data beyond that marker results in 'interesting'
effects, from simple read errors to crashing the card. And to make
matters worse not every PCI card implements this properly, leaving
us with no 'end' marker or even completely invalid data.
This path modifies the size of the VPD attribute to the available
size, and disables the VPD attribute altogether if no valid data
could be read.

Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Michal Kubecek <mkubecek@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/access.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 59ac36f..ab571a5 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -475,6 +475,48 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.release = pci_vpd_pci22_release,
 };
 
+/**
+ * pci_vpd_size - determine actual size of Vital Product Data
+ * @dev:	pci device struct
+ * @old_size:	current assumed size, also maximum allowed size
+ *
+ */
+static size_t
+pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
+{
+	size_t off = 0;
+	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
+
+	while (off < old_size && pci_read_vpd(dev, off, 1, header)) {
+		unsigned char tag;
+
+		if (header[0] == 0xff) {
+			/* Invalid data from VPD read */
+			tag = header[0];
+		} else if (header[0] & 0x80) {
+			/* Large Resource Data Type Tag */
+			if (pci_read_vpd(dev, off+1, 2, &header[1]) != 2)
+				return off + 1;
+			off += 3 + ((header[2] << 8) | header[1]);
+			tag = (header[0] & 0x7f);
+		} else {
+			/* Short Resource Data Type Tag */
+			off += 1 + (header[0] & 0x07);
+			tag = (header[0] & 0x78) >> 3;
+		}
+		if (tag == 0x0f)	/* End tag descriptor */
+			break;
+		if ((tag != 0x02) && (tag != 0x10) && (tag != 0x11)) {
+			dev_dbg(&dev->dev,
+				"invalid %s vpd tag %02x at offset %zu.",
+				header[0] & 0x80 ? "large" : "short",
+				tag, off);
+			break;
+		}
+	}
+	return off;
+}
+
 int pci_vpd_pci22_init(struct pci_dev *dev)
 {
 	struct pci_vpd_pci22 *vpd;
@@ -497,6 +539,13 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	vpd->cap = cap;
 	vpd->busy = false;
 	dev->vpd = &vpd->base;
+	vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
+	if (vpd->base.len == 0) {
+		dev_dbg(&dev->dev, "Disabling VPD access.");
+		dev->vpd = NULL;
+		kfree(vpd);
+		return -ENXIO;
+	}
 	return 0;
 }
 
-- 
1.8.5.6

