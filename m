Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48116 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbcBWArb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:31 -0500
Subject: [PATCH v4 09/11] PCI: Rename VPD symbols to remove unnecessary
 "pci22"
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:28 -0600
Message-ID: <20160223004728.10635.43331.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's only one kind of VPD, so we don't need to qualify it as "the
version described by PCI spec rev 2.2."

Rename the following symbols to remove unnecessary "pci22":

  PCI_VPD_PCI22_SIZE	-> PCI_VPD_MAX_SIZE
  pci_vpd_pci22_size()	-> pci_vpd_size()
  pci_vpd_pci22_wait()	-> pci_vpd_wait()
  pci_vpd_pci22_read()	-> pci_vpd_read()
  pci_vpd_pci22_write()	-> pci_vpd_write()
  pci_vpd_pci22_ops	-> pci_vpd_ops
  pci_vpd_pci22_init()	-> pci_vpd_init()

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   38 +++++++++++++++++++-------------------
 drivers/pci/pci.h    |    2 +-
 drivers/pci/probe.c  |    2 +-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 68ed22a..ee205de 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -275,7 +275,7 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 }
 EXPORT_SYMBOL(pci_write_vpd);
 
-#define PCI_VPD_PCI22_SIZE (PCI_VPD_ADDR_MASK + 1)
+#define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 struct pci_vpd_pci22 {
 	struct pci_vpd base;
@@ -291,7 +291,7 @@ struct pci_vpd_pci22 {
  * @dev:	pci device struct
  * @old_size:	current assumed size, also maximum allowed size
  */
-static size_t pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
+static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 {
 	size_t off = 0;
 	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
@@ -348,7 +348,7 @@ static size_t pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
  *
  * Returns 0 on success, negative values indicate error.
  */
-static int pci_vpd_pci22_wait(struct pci_dev *dev)
+static int pci_vpd_wait(struct pci_dev *dev)
 {
 	struct pci_vpd_pci22 *vpd =
 		container_of(dev->vpd, struct pci_vpd_pci22, base);
@@ -381,8 +381,8 @@ static int pci_vpd_pci22_wait(struct pci_dev *dev)
 	}
 }
 
-static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
-				  void *arg)
+static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
+			    void *arg)
 {
 	struct pci_vpd_pci22 *vpd =
 		container_of(dev->vpd, struct pci_vpd_pci22, base);
@@ -395,7 +395,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 
 	if (!vpd->valid) {
 		vpd->valid = 1;
-		vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
+		vpd->base.len = pci_vpd_size(dev, vpd->base.len);
 	}
 
 	if (vpd->base.len == 0)
@@ -412,7 +412,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
 
-	ret = pci_vpd_pci22_wait(dev);
+	ret = pci_vpd_wait(dev);
 	if (ret < 0)
 		goto out;
 
@@ -426,7 +426,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 			break;
 		vpd->busy = 1;
 		vpd->flag = PCI_VPD_ADDR_F;
-		ret = pci_vpd_pci22_wait(dev);
+		ret = pci_vpd_wait(dev);
 		if (ret < 0)
 			break;
 
@@ -449,8 +449,8 @@ out:
 	return ret ? ret : count;
 }
 
-static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count,
-				   const void *arg)
+static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
+			     const void *arg)
 {
 	struct pci_vpd_pci22 *vpd =
 		container_of(dev->vpd, struct pci_vpd_pci22, base);
@@ -463,7 +463,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
 
 	if (!vpd->valid) {
 		vpd->valid = 1;
-		vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
+		vpd->base.len = pci_vpd_size(dev, vpd->base.len);
 	}
 
 	if (vpd->base.len == 0)
@@ -475,7 +475,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
 
-	ret = pci_vpd_pci22_wait(dev);
+	ret = pci_vpd_wait(dev);
 	if (ret < 0)
 		goto out;
 
@@ -497,7 +497,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
 
 		vpd->busy = 1;
 		vpd->flag = 0;
-		ret = pci_vpd_pci22_wait(dev);
+		ret = pci_vpd_wait(dev);
 		if (ret < 0)
 			break;
 
@@ -508,9 +508,9 @@ out:
 	return ret ? ret : count;
 }
 
-static const struct pci_vpd_ops pci_vpd_pci22_ops = {
-	.read = pci_vpd_pci22_read,
-	.write = pci_vpd_pci22_write,
+static const struct pci_vpd_ops pci_vpd_ops = {
+	.read = pci_vpd_read,
+	.write = pci_vpd_write,
 };
 
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
@@ -548,7 +548,7 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.write = pci_vpd_f0_write,
 };
 
-int pci_vpd_pci22_init(struct pci_dev *dev)
+int pci_vpd_init(struct pci_dev *dev)
 {
 	struct pci_vpd_pci22 *vpd;
 	u8 cap;
@@ -561,11 +561,11 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	if (!vpd)
 		return -ENOMEM;
 
-	vpd->base.len = PCI_VPD_PCI22_SIZE;
+	vpd->base.len = PCI_VPD_MAX_SIZE;
 	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
 		vpd->base.ops = &pci_vpd_f0_ops;
 	else
-		vpd->base.ops = &pci_vpd_pci22_ops;
+		vpd->base.ops = &pci_vpd_ops;
 	mutex_init(&vpd->lock);
 	vpd->cap = cap;
 	vpd->busy = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b3e9daa..6191703 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -105,7 +105,7 @@ struct pci_vpd {
 	struct bin_attribute *attr; /* descriptor for sysfs VPD entry */
 };
 
-int pci_vpd_pci22_init(struct pci_dev *dev);
+int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
 
 /* PCI /proc functions */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..39b0174 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1608,7 +1608,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_pm_init(dev);
 
 	/* Vital Product Data */
-	pci_vpd_pci22_init(dev);
+	pci_vpd_init(dev);
 
 	/* Alternative Routing-ID Forwarding */
 	pci_configure_ari(dev);

