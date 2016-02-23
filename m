Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47997 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbcBWArK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:10 -0500
Subject: [PATCH v4 06/11] PCI: Move pci_read_vpd() and pci_write_vpd() close
 to other VPD code
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:07 -0600
Message-ID: <20160223004707.10635.94730.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_read_vpd() and pci_write_vpd() were stranded in the middle of config
accessor functions.  Move them close to the other VPD code in the file.
No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   62 ++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 4850f06..4c4c734 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -174,38 +174,6 @@ struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops)
 }
 EXPORT_SYMBOL(pci_bus_set_ops);
 
-/**
- * pci_read_vpd - Read one entry from Vital Product Data
- * @dev:	pci device struct
- * @pos:	offset in vpd space
- * @count:	number of bytes to read
- * @buf:	pointer to where to store result
- *
- */
-ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
-{
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->read(dev, pos, count, buf);
-}
-EXPORT_SYMBOL(pci_read_vpd);
-
-/**
- * pci_write_vpd - Write entry to Vital Product Data
- * @dev:	pci device struct
- * @pos:	offset in vpd space
- * @count:	number of bytes to write
- * @buf:	buffer containing write data
- *
- */
-ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
-{
-	if (!dev->vpd || !dev->vpd->ops)
-		return -ENODEV;
-	return dev->vpd->ops->write(dev, pos, count, buf);
-}
-EXPORT_SYMBOL(pci_write_vpd);
-
 /*
  * The following routines are to prevent the user from accessing PCI config
  * space when it's unsafe to do so.  Some devices require this during BIST and
@@ -277,6 +245,36 @@ PCI_USER_WRITE_CONFIG(dword, u32)
 
 /* VPD access through PCI 2.2+ VPD capability */
 
+/**
+ * pci_read_vpd - Read one entry from Vital Product Data
+ * @dev:	pci device struct
+ * @pos:	offset in vpd space
+ * @count:	number of bytes to read
+ * @buf:	pointer to where to store result
+ */
+ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return -ENODEV;
+	return dev->vpd->ops->read(dev, pos, count, buf);
+}
+EXPORT_SYMBOL(pci_read_vpd);
+
+/**
+ * pci_write_vpd - Write entry to Vital Product Data
+ * @dev:	pci device struct
+ * @pos:	offset in vpd space
+ * @count:	number of bytes to write
+ * @buf:	buffer containing write data
+ */
+ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return -ENODEV;
+	return dev->vpd->ops->write(dev, pos, count, buf);
+}
+EXPORT_SYMBOL(pci_write_vpd);
+
 #define PCI_VPD_PCI22_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 struct pci_vpd_pci22 {

