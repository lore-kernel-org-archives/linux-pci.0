Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33310 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaLCVlI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Dec 2014 16:41:08 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	boris.ostrovsky@oracle.com, david.vrabel@citrix.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH v5 4/9] xen/pciback: Print out the domain owning the device.
Date: Wed,  3 Dec 2014 16:40:29 -0500
Message-Id: <1417642834-20350-5-git-send-email-konrad.wilk@oracle.com>
In-Reply-To: <1417642834-20350-1-git-send-email-konrad.wilk@oracle.com>
References: <1417642834-20350-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We had been printing it only if the device was built with
debug enabled. But this information is useful in the field
to troubleshoot.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/xen-pciback/xenbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index eeee499..fe17c80 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -247,7 +247,7 @@ static int xen_pcibk_export_device(struct xen_pcibk_device *pdev,
 	if (err)
 		goto out;
 
-	dev_dbg(&dev->dev, "registering for %d\n", pdev->xdev->otherend_id);
+	dev_info(&dev->dev, "registering for %d\n", pdev->xdev->otherend_id);
 	if (xen_register_device_domain_owner(dev,
 					     pdev->xdev->otherend_id) != 0) {
 		dev_err(&dev->dev, "Stealing ownership from dom%d.\n",
-- 
1.9.3

