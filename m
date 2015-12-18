Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 2/2] pci: Update VPD size with correct length
Date: Fri, 18 Dec 2015 09:35:19 +0100
Message-Id: <1450427719-29619-3-git-send-email-hare@suse.de>
In-Reply-To: <1450427719-29619-1-git-send-email-hare@suse.de>
References: <1450427719-29619-1-git-send-email-hare@suse.de>
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
size, or set it to '0' if no valid data could be read.

Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/access.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h    |  1 +
 2 files changed, 82 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 59ac36f..2e23fc7 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -206,6 +206,18 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 }
 EXPORT_SYMBOL(pci_write_vpd);
 
+/**
+ * pci_vpd_size - Determine the size of the Vital Product Data
+ * @dev:	pci device struct
+ *
+ */
+size_t pci_vpd_size(struct pci_dev *dev)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return 0;
+	return dev->vpd->ops->size(dev);
+}
+
 /*
  * The following routines are to prevent the user from accessing PCI config
  * space when it's unsafe to do so.  Some devices require this during BIST and
@@ -428,6 +440,53 @@ out:
 	return ret ? ret : count;
 }
 
+/**
+ * pci_vpd_size - determine actual size of Vital Product Data
+ * @dev:	pci device struct
+ *
+ */
+static size_t pci_vpd_pci22_size(struct pci_dev *dev)
+{
+	ssize_t off = 0;
+	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
+
+	while (pci_read_vpd(dev, off, 1, header) == 1) {
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
+						 &header[1]) != 2)
+					return off + 1;
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
+				"invalid %s vpd tag %02x at offset %zu.",
+				(header[0] & PCI_VPD_LRDT) ? "large" : "short",
+				tag, off);
+			break;
+		}
+	}
+	return 0;
+}
+
 static void pci_vpd_pci22_release(struct pci_dev *dev)
 {
 	kfree(container_of(dev->vpd, struct pci_vpd_pci22, base));
@@ -436,6 +495,7 @@ static void pci_vpd_pci22_release(struct pci_dev *dev)
 static const struct pci_vpd_ops pci_vpd_pci22_ops = {
 	.read = pci_vpd_pci22_read,
 	.write = pci_vpd_pci22_write,
+	.size = pci_vpd_pci22_size,
 	.release = pci_vpd_pci22_release,
 };
 
@@ -469,9 +529,29 @@ static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 	return ret;
 }
 
+static size_t pci_vpd_f0_size(struct pci_dev *dev)
+{
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	ssize_t len = 0;
+
+	if (!tdev)
+		return 0;
+
+	if (tdev->vpd) {
+		struct pci_vpd_pci22 *vpd =
+			container_of(dev->vpd, struct pci_vpd_pci22, base);
+
+		len = vpd->base.len;
+	}
+	pci_dev_put(tdev);
+	return len;
+}
+
 static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.read = pci_vpd_f0_read,
 	.write = pci_vpd_f0_write,
+	.size = pci_vpd_f0_size,
 	.release = pci_vpd_pci22_release,
 };
 
@@ -497,6 +577,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	vpd->cap = cap;
 	vpd->busy = false;
 	dev->vpd = &vpd->base;
+	vpd->base.len = pci_vpd_size(dev);
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd2f03f..33dfc7c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -97,6 +97,7 @@ static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
+	size_t (*size)(struct pci_dev *dev);
 	void (*release)(struct pci_dev *dev);
 };
 
-- 
1.8.5.6

