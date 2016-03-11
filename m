Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41325 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbcCKPNZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 10:13:25 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 449AA201F5
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 15:13:24 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 86978201B4
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 15:13:23 +0000 (UTC)
Subject: [PATCH 1/2] PCI: Don't leak memory if sysfs_create_bin_file() fails
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Mar 2016 09:13:22 -0600
Message-ID: <20160311151322.31298.25447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160311151137.31298.19101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160311151137.31298.19101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If sysfs_create_bin_file() fails, pci_create_attr() leaks the struct
bin_attribute it allocated previously.

Free the struct bin_attribute if pci_create_attr() fails.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a4cfa52..b0c36f0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1159,6 +1159,8 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 		res_attr->size = pci_resource_len(pdev, num);
 		res_attr->private = &pdev->resource[num];
 		retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
+		if (retval)
+			kfree(res_attr);
 	} else
 		retval = -ENOMEM;
 

