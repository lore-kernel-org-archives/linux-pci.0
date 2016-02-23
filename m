Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48134 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbcBWAri (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:38 -0500
Subject: [PATCH v4 10/11] PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:35 -0600
Message-ID: <20160223004735.10635.72128.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We only support one flavor of VPD, so there's no need to complicate things
by having a "generic" struct pci_vpd and a more specific struct
pci_vpd_pci22.

Fold struct pci_vpd_pci22 directly into struct pci_vpd.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   46 +++++++++++++++++-----------------------------
 drivers/pci/pci.h    |    7 ++++++-
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ee205de..cae5462 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -277,15 +277,6 @@ EXPORT_SYMBOL(pci_write_vpd);
 
 #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
 
-struct pci_vpd_pci22 {
-	struct pci_vpd base;
-	struct mutex lock;
-	u16	flag;
-	u8	cap;
-	u8	busy:1;
-	u8	valid:1;
-};
-
 /**
  * pci_vpd_size - determine actual size of Vital Product Data
  * @dev:	pci device struct
@@ -350,8 +341,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
  */
 static int pci_vpd_wait(struct pci_dev *dev)
 {
-	struct pci_vpd_pci22 *vpd =
-		container_of(dev->vpd, struct pci_vpd_pci22, base);
+	struct pci_vpd *vpd = dev->vpd;
 	unsigned long timeout = jiffies + HZ/20 + 2;
 	u16 status;
 	int ret;
@@ -384,8 +374,7 @@ static int pci_vpd_wait(struct pci_dev *dev)
 static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 			    void *arg)
 {
-	struct pci_vpd_pci22 *vpd =
-		container_of(dev->vpd, struct pci_vpd_pci22, base);
+	struct pci_vpd *vpd = dev->vpd;
 	int ret;
 	loff_t end = pos + count;
 	u8 *buf = arg;
@@ -395,17 +384,17 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 
 	if (!vpd->valid) {
 		vpd->valid = 1;
-		vpd->base.len = pci_vpd_size(dev, vpd->base.len);
+		vpd->len = pci_vpd_size(dev, vpd->len);
 	}
 
-	if (vpd->base.len == 0)
+	if (vpd->len == 0)
 		return -EIO;
 
-	if (pos >= vpd->base.len)
+	if (pos > vpd->len)
 		return 0;
 
-	if (end > vpd->base.len) {
-		end = vpd->base.len;
+	if (end > vpd->len) {
+		end = vpd->len;
 		count = end - pos;
 	}
 
@@ -452,8 +441,7 @@ out:
 static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 			     const void *arg)
 {
-	struct pci_vpd_pci22 *vpd =
-		container_of(dev->vpd, struct pci_vpd_pci22, base);
+	struct pci_vpd *vpd = dev->vpd;
 	const u8 *buf = arg;
 	loff_t end = pos + count;
 	int ret = 0;
@@ -463,13 +451,13 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
 
 	if (!vpd->valid) {
 		vpd->valid = 1;
-		vpd->base.len = pci_vpd_size(dev, vpd->base.len);
+		vpd->len = pci_vpd_size(dev, vpd->len);
 	}
 
-	if (vpd->base.len == 0)
+	if (vpd->len == 0)
 		return -EIO;
 
-	if (end > vpd->base.len)
+	if (end > vpd->len)
 		return -EINVAL;
 
 	if (mutex_lock_killable(&vpd->lock))
@@ -550,7 +538,7 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 
 int pci_vpd_init(struct pci_dev *dev)
 {
-	struct pci_vpd_pci22 *vpd;
+	struct pci_vpd *vpd;
 	u8 cap;
 
 	cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
@@ -561,23 +549,23 @@ int pci_vpd_init(struct pci_dev *dev)
 	if (!vpd)
 		return -ENOMEM;
 
-	vpd->base.len = PCI_VPD_MAX_SIZE;
+	vpd->len = PCI_VPD_MAX_SIZE;
 	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
-		vpd->base.ops = &pci_vpd_f0_ops;
+		vpd->ops = &pci_vpd_f0_ops;
 	else
-		vpd->base.ops = &pci_vpd_ops;
+		vpd->ops = &pci_vpd_ops;
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
 	vpd->busy = 0;
 	vpd->valid = 0;
-	dev->vpd = &vpd->base;
+	dev->vpd = vpd;
 	return 0;
 }
 
 void pci_vpd_release(struct pci_dev *dev)
 {
 	if (dev->vpd)
-		kfree(container_of(dev->vpd, struct pci_vpd_pci22, base));
+		kfree(dev->vpd);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6191703..d0fb934 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -100,9 +100,14 @@ struct pci_vpd_ops {
 };
 
 struct pci_vpd {
-	unsigned int len;
 	const struct pci_vpd_ops *ops;
 	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
+	struct mutex	lock;
+	unsigned int	len;
+	u16		flag;
+	u8		cap;
+	u8		busy:1;
+	u8		valid:1;
 };
 
 int pci_vpd_init(struct pci_dev *dev);

