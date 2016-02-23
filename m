Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47886 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379AbcBWAql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:46:41 -0500
Subject: [PATCH v4 02/11] PCI: Allow access to VPD attributes with size 0
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:46:38 -0600
Message-ID: <20160223004638.10635.92076.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

It is not always possible to determine the actual size of the VPD
data, so allow access to them if the size is set to '0'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
---
 drivers/pci/pci-sysfs.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 95d9e7b..a730f54 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -769,10 +769,12 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
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
@@ -783,10 +785,12 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 
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

