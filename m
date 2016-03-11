Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41362 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbcCKPNd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 10:13:33 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id DDD31201F5
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 15:13:31 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5F94F201B4
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 15:13:30 +0000 (UTC)
Subject: [PATCH 2/2] PCI: Simplify pci_create_attr() control flow
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Mar 2016 09:13:29 -0600
Message-ID: <20160311151329.31298.16200.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160311151137.31298.19101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160311151137.31298.19101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return error immediately to simplify the control flow in pci_create_attr().
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |   53 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b0c36f0..cd00aa7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1134,35 +1134,36 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	/* allocate attribute structure, piggyback attribute name */
 	int name_len = write_combine ? 13 : 10;
 	struct bin_attribute *res_attr;
+	char *res_attr_name;
 	int retval;
 
 	res_attr = kzalloc(sizeof(*res_attr) + name_len, GFP_ATOMIC);
-	if (res_attr) {
-		char *res_attr_name = (char *)(res_attr + 1);
-
-		sysfs_bin_attr_init(res_attr);
-		if (write_combine) {
-			pdev->res_attr_wc[num] = res_attr;
-			sprintf(res_attr_name, "resource%d_wc", num);
-			res_attr->mmap = pci_mmap_resource_wc;
-		} else {
-			pdev->res_attr[num] = res_attr;
-			sprintf(res_attr_name, "resource%d", num);
-			res_attr->mmap = pci_mmap_resource_uc;
-		}
-		if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
-			res_attr->read = pci_read_resource_io;
-			res_attr->write = pci_write_resource_io;
-		}
-		res_attr->attr.name = res_attr_name;
-		res_attr->attr.mode = S_IRUSR | S_IWUSR;
-		res_attr->size = pci_resource_len(pdev, num);
-		res_attr->private = &pdev->resource[num];
-		retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-		if (retval)
-			kfree(res_attr);
-	} else
-		retval = -ENOMEM;
+	if (!res_attr)
+		return -ENOMEM;
+
+	res_attr_name = (char *)(res_attr + 1);
+
+	sysfs_bin_attr_init(res_attr);
+	if (write_combine) {
+		pdev->res_attr_wc[num] = res_attr;
+		sprintf(res_attr_name, "resource%d_wc", num);
+		res_attr->mmap = pci_mmap_resource_wc;
+	} else {
+		pdev->res_attr[num] = res_attr;
+		sprintf(res_attr_name, "resource%d", num);
+		res_attr->mmap = pci_mmap_resource_uc;
+	}
+	if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
+		res_attr->read = pci_read_resource_io;
+		res_attr->write = pci_write_resource_io;
+	}
+	res_attr->attr.name = res_attr_name;
+	res_attr->attr.mode = S_IRUSR | S_IWUSR;
+	res_attr->size = pci_resource_len(pdev, num);
+	res_attr->private = &pdev->resource[num];
+	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
+	if (retval)
+		kfree(res_attr);
 
 	return retval;
 }

