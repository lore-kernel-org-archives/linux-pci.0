Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754971AbcKUVp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 16:45:59 -0500
Subject: [PATCH v2 6/9] PCI: Remove service driver load/unload messages
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:45:55 -0600
Message-ID: <20161121214555.21036.9377.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the "service driver %s loaded" and unloaded messages.  All service
drivers already log something in their probe functions, where they can log
more useful details.

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

