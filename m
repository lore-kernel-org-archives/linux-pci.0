Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44291 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaB0P0M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 10:26:12 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so2627092pab.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2014 07:26:12 -0800 (PST)
From: Tim Harvey <tharvey@gateworks.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH] sky2: allow mac to come from dt
Date: Thu, 27 Feb 2014 07:26:03 -0800
Message-Id: <1393514763-8384-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The sky2 driver currently reads the mac address from the device registers
which would need to have been programmed by the bootloader.

This patch adds the ability to pull the mac from devicetree via the
aliases/sky2 node.

The RFC is because I'm not clear if there is a better way to reference the
devicetree node for a PCI device from both the bootloader perspective and
the driver perspective.  Using an alias feels a bit like a hack.  An example
of a dts that describes a marvell,sky2 sitting on bus8 of the PCI bus is:

aliases {
	sky2 = &eth1;
};

&pcie { 
        eth1: sky2@8 { /* MAC/PHY on bus 8 */
                compatible = "marvell,sky2";
        };
};

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/net/ethernet/marvell/sky2.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 55a37ae..4165fc0 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -44,6 +44,8 @@
 #include <linux/prefetch.h>
 #include <linux/debugfs.h>
 #include <linux/mii.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
 
 #include <asm/irq.h>
 
@@ -4748,6 +4750,7 @@ static struct net_device *sky2_init_netdev(struct sky2_hw *hw, unsigned port,
 {
 	struct sky2_port *sky2;
 	struct net_device *dev = alloc_etherdev(sizeof(*sky2));
+	unsigned char *iap, tmpaddr[ETH_ALEN];
 
 	if (!dev)
 		return NULL;
@@ -4805,8 +4808,36 @@ static struct net_device *sky2_init_netdev(struct sky2_hw *hw, unsigned port,
 
 	dev->features |= dev->hw_features;
 
+	/*
+	 * try to get mac address in the following order:
+	 * 1) from device tree data
+	 * 2) from internal registers set by bootloader
+	 */
+	iap = NULL;
+	if (IS_ENABLED(CONFIG_OF)) {
+		struct device_node *np;
+		np = of_find_node_by_path("/aliases");
+		if (np) {
+			const char *path = of_get_property(np, "sky2", NULL);
+			if (path)
+				np = of_find_node_by_path(path);
+			if (np)
+				path = of_get_mac_address(np);
+			if (path)
+				iap = (unsigned char *) path;
+		}
+	}
+
+	/*
+	 * 2) mac registers set by bootloader
+	 */
+	if (!iap || !is_valid_ether_addr(iap)) {
+		memcpy_fromio(&tmpaddr, hw->regs + B2_MAC_1 + port * 8, ETH_ALEN);
+		iap = &tmpaddr[0];
+	}
+
 	/* read the mac address */
-	memcpy_fromio(dev->dev_addr, hw->regs + B2_MAC_1 + port * 8, ETH_ALEN);
+	memcpy(dev->dev_addr, iap, ETH_ALEN);
 
 	return dev;
 }
-- 
1.8.3.2

