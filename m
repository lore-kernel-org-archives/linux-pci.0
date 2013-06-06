Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:40214 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3FFRMd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 13:12:33 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so1310pbb.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2013 10:12:33 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: fix a double free issue in pci_create_root_bus() error recovery path
Date: Fri,  7 Jun 2013 01:10:08 +0800
Message-Id: <1370538609-28903-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
References: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On pci_create_root_bus() error recovery path, device_unregister(&bridge->dev)
should have freed memory used by bridge, so we shouldn't call kfree(bridge)
again, it's a double free.

On the other hand, we should not use kfree() to free memory used by
device object once we have invoked device_register() because it's
reference-counted.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: stable@vger.kernel.org
---
Hi Bjorn,
	This is the patch to fix the kfree() issue, it may be a material
for stable trees.
Thanks!
Gerry
---
 drivers/pci/probe.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8882b5d..2f81a0a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1729,12 +1729,16 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->dev.release = pci_release_bus_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bridge_prepare(bridge);
-	if (error)
-		goto bridge_dev_reg_err;
+	if (error) {
+		kfree(bridge);
+		goto err_out;
+	}
 
 	error = device_register(&bridge->dev);
-	if (error)
-		goto bridge_dev_reg_err;
+	if (error) {
+		kfree(bridge);
+		goto err_out;
+	}
 	b->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
@@ -1790,8 +1794,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 class_dev_reg_err:
 	put_device(&bridge->dev);
 	device_unregister(&bridge->dev);
-bridge_dev_reg_err:
-	kfree(bridge);
 err_out:
 	kfree(b);
 	return NULL;
-- 
1.8.1.2

