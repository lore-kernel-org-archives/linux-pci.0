Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from numidia.opendz.org ([98.142.220.152]:43554 "EHLO
	numidia.opendz.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaANXRs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 18:17:48 -0500
From: Djalal Harouni <tixxdz@opendz.org>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Djalal Harouni <tixxdz@opendz.org>
Subject: [PATCH] PCI: fix a memory leak of pci_host_bridge on error path
Date: Wed, 15 Jan 2014 00:11:19 +0100
Message-Id: <1389741079-12976-1-git-send-email-tixxdz@opendz.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On error paths make sure that the pci_host_bridge struct is freed.

Signed-off-by: Djalal Harouni <tixxdz@opendz.org>
---
On top of linux-next.

 drivers/pci/probe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 23cdfac..483566c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1771,15 +1771,13 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = pcibios_root_bridge_prepare(bridge);
-	if (error) {
-		kfree(bridge);
-		goto err_out;
-	}
+	if (error)
+		goto host_bridge_err;
 
 	error = device_register(&bridge->dev);
 	if (error) {
 		put_device(&bridge->dev);
-		goto err_out;
+		goto host_bridge_err;
 	}
 	b->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(b->bridge);
@@ -1836,6 +1834,8 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 class_dev_reg_err:
 	put_device(&bridge->dev);
 	device_unregister(&bridge->dev);
+host_bridge_err:
+	kfree(bridge);
 err_out:
 	kfree(b);
 	return NULL;
-- 
1.7.11.7

