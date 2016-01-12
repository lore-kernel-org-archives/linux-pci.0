Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60796 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964929AbcALOme (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 09:42:34 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/3] pci: set VPD size to '0' if PCI_VPD_FLAGS_VPD_REF_F0 is set
Date: Tue, 12 Jan 2016 15:42:30 +0100
Message-Id: <1452609750-90760-4-git-send-email-hare@suse.de>
In-Reply-To: <1452609750-90760-1-git-send-email-hare@suse.de>
References: <1452609750-90760-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the VPD data is accessed via another PCI function than 0
the access is redirected to function 0. However, we shouldn't
calculate the actual size as we did for function 0, as there
is no guarantee that function 0 is already initialized and
VPD access is very costly and error prone.

So to avoid all this we set the size to '0' in sysfs, but only return
the valid bytes from the underlying function 0.

Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/pci/access.c    | 11 ++++++++++-
 drivers/pci/pci-sysfs.c | 20 ++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ce1b0cb..9fe19be 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -337,9 +337,16 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
 	loff_t end = pos + count;
 	u8 *buf = arg;
 
-	if (pos < 0 || pos > vpd->base.len || end > vpd->base.len)
+	if (pos < 0)
 		return -EINVAL;
 
+	if (end > vpd->base.len) {
+		if (pos > vpd->base.len)
+			return 0;
+		end = vpd->base.len;
+		count = end - pos;
+	}
+
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
 
@@ -554,6 +561,8 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	dev->vpd = &vpd->base;
 	if (!(dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0))
 		vpd->base.len = pci_vpd_pci22_size(dev);
+	else
+		vpd->base.len = 0;
 	return 0;
 }
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index eead54c..de327c3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -772,10 +772,12 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
 	struct pci_dev *dev =
 		to_pci_dev(container_of(kobj, struct device, kobj));
 
-	if (off > bin_attr->size)
-		count = 0;
-	else if (count > bin_attr->size - off)
-		count = bin_attr->size - off;
+	if (bin_attr->size > 0) {
+		if (off > bin_attr->size)
+			count = 0;
+		else if (count > bin_attr->size - off)
+			count = bin_attr->size - off;
+	}
 
 	return pci_read_vpd(dev, off, count, buf);
 }
@@ -787,10 +789,12 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 	struct pci_dev *dev =
 		to_pci_dev(container_of(kobj, struct device, kobj));
 
-	if (off > bin_attr->size)
-		count = 0;
-	else if (count > bin_attr->size - off)
-		count = bin_attr->size - off;
+	if (bin_attr->size > 0) {
+		if (off > bin_attr->size)
+			count = 0;
+		else if (count > bin_attr->size - off)
+			count = bin_attr->size - off;
+	}
 
 	return pci_write_vpd(dev, off, count, buf);
 }
-- 
1.8.5.6

