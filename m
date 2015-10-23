Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55482 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbbJWJJ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 05:09:59 -0400
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] pci: Update VPD size with correct length
Date: Fri, 23 Oct 2015 11:09:56 +0200
Message-Id: <1445591396-95395-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI-2.2 VPD entries have a maximum size of 32k, but might actually
be smaller than that. To figure out the actual size one has to read
the VPD area until the 'end marker' is reached.
Trying to read VPD data beyond that marker results in 'interesting'
effects, from simple read errors to crashing the card.
This path modifies the attribute size to the avialable VPD size.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/access.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 6bc9b12..4f8208e 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,6 +409,34 @@ static int pci_vpd_f0_dev_check(struct pci_dev *dev)
 	return ret;
 }
 
+/**
+ * pci_vpd_size - determine actual size of Vital Product Data
+ * @dev:	pci device struct
+ * @old_size:	current assumed size, also maximum allowed size
+ *
+ */
+size_t
+pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
+{
+	loff_t off = 0;
+	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
+
+	while (off < old_size && pci_read_vpd(dev, off, 1, header)) {
+		if (header[0] == 0x78)	/* End tag descriptor */
+			return off + 1;
+		if (header[0] & 0x80) {
+			/* Large Resource Data Type Tag */
+			if (pci_read_vpd(dev, off+1, 2, &header[1]) != 2)
+				return off + 1;
+			off += 3 + ((header[2] << 8) | header[1]);
+		} else {
+			/* Short Resource Data Type Tag */
+			off += 1 + (header[0] & 0x07);
+		}
+	}
+	return old_size;
+}
+
 int pci_vpd_pci22_init(struct pci_dev *dev)
 {
 	struct pci_vpd_pci22 *vpd;
@@ -436,6 +464,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	vpd->cap = cap;
 	vpd->busy = false;
 	dev->vpd = &vpd->base;
+	vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
 	return 0;
 }
 
-- 
1.8.5.6

