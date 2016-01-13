Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48158 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957AbcAMLZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 06:25:37 -0500
From: Hannes Reinecke <hare@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Babu Moger <babu.moger@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 2/4] pci: allow access to VPD attributes with size '0'
Date: Wed, 13 Jan 2016 12:25:33 +0100
Message-Id: <1452684335-46107-3-git-send-email-hare@suse.de>
In-Reply-To: <1452684335-46107-1-git-send-email-hare@suse.de>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is not always possible to determine the actual size of the VPD
data, so allow access to them if the size is set to '0'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/pci-sysfs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

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

