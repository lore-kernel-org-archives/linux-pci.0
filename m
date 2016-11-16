Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbcKPWNN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Nov 2016 17:13:13 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 3C5A3203E1
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:12 +0000 (UTC)
Received: from localhost (unknown [69.71.4.155])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA50203C4
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:11 +0000 (UTC)
Subject: [PATCH 1/4] PCI: Remove service driver load/unload messages
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 16 Nov 2016 16:13:10 -0600
Message-ID: <20161116221310.15842.25671.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the "service driver %s loaded" and unloaded messages.  I don't think
these add any useful information.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e9270b4..9698289 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -499,7 +499,6 @@ static int pcie_port_probe_service(struct device *dev)
 	if (status)
 		return status;
 
-	dev_printk(KERN_DEBUG, dev, "service driver %s loaded\n", driver->name);
 	get_device(dev);
 	return 0;
 }
@@ -524,8 +523,6 @@ static int pcie_port_remove_service(struct device *dev)
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(dev->driver);
 	if (driver && driver->remove) {
-		dev_printk(KERN_DEBUG, dev, "unloading service driver %s\n",
-			driver->name);
 		driver->remove(pciedev);
 		put_device(dev);
 	}

