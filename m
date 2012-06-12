Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60308 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab2FLNQP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 09:16:15 -0400
Received: by dady13 with SMTP id y13so6854301dad.19
        for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2012 06:16:14 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: use name pci_release_host_bridge_dev() for host bridge device release fn
Date: Tue, 12 Jun 2012 21:14:44 +0800
Message-Id: <1339506884-21606-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

Rename pci_release_bus_bridge_dev() to pci_release_host_bridge_dev()
in drivers/pci/probe.c for easy understanding.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/pci/probe.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0840409..f62dd9b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -473,6 +473,18 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 	return bridge;
 }
 
+static void pci_release_host_bridge_dev(struct device *dev)
+{
+	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
+
+	if (bridge->release_fn)
+		bridge->release_fn(bridge);
+
+	pci_free_resource_list(&bridge->windows);
+
+	kfree(bridge);
+}
+
 static unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
@@ -1172,18 +1184,6 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	return PCI_CFG_SPACE_SIZE;
 }
 
-static void pci_release_bus_bridge_dev(struct device *dev)
-{
-	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
-
-	if (bridge->release_fn)
-		bridge->release_fn(bridge);
-
-	pci_free_resource_list(&bridge->windows);
-
-	kfree(bridge);
-}
-
 struct pci_dev *alloc_pci_dev(void)
 {
 	struct pci_dev *dev;
@@ -1658,7 +1658,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 
 	bridge->dev.parent = parent;
-	bridge->dev.release = pci_release_bus_bridge_dev;
+	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = device_register(&bridge->dev);
 	if (error)
-- 
1.7.9.5

