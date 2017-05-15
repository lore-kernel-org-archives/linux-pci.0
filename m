Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:60290 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752651AbdEOQpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 May 2017 12:45:04 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 15 May 2017 10:44:52 -0600
Message-Id: <1494866693-2850-2-git-send-email-logang@deltatee.com>
In-Reply-To: <1494866693-2850-1-git-send-email-logang@deltatee.com>
References: <1494866693-2850-1-git-send-email-logang@deltatee.com>
Subject: [PATCH 1/2] switchtec: utilize new device_add_cdev helper function
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Very straightforward conversion to device_add_cdev. Drop cdev_add and
device_add and use cdev_device_add.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index cc6e085..abaa227a 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1291,7 +1291,6 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	cdev = &stdev->cdev;
 	cdev_init(cdev, &switchtec_fops);
 	cdev->owner = THIS_MODULE;
-	cdev->kobj.parent = &dev->kobj;
 
 	return stdev;
 
@@ -1479,11 +1478,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 		  SWITCHTEC_EVENT_EN_IRQ,
 		  &stdev->mmio_part_cfg->mrpc_comp_hdr);
 
-	rc = cdev_add(&stdev->cdev, stdev->dev.devt, 1);
-	if (rc)
-		goto err_put;
-
-	rc = device_add(&stdev->dev);
+	rc = cdev_device_add(&stdev->cdev, &stdev->dev);
 	if (rc)
 		goto err_devadd;
 
@@ -1492,7 +1487,6 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 err_devadd:
-	cdev_del(&stdev->cdev);
 	stdev_kill(stdev);
 err_put:
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
@@ -1506,8 +1500,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 
 	pci_set_drvdata(pdev, NULL);
 
-	device_del(&stdev->dev);
-	cdev_del(&stdev->cdev);
+	cdev_device_del(&stdev->cdev, &stdev->dev);
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 
-- 
2.1.4
