Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:44441 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbcFBMxB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jun 2016 08:53:01 -0400
From: Stefan Roese <sr@denx.de>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Jisheng Zhang <jszhang@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: mvebu: Don't try to add an MBus window that already exists
Date: Thu,  2 Jun 2016 14:52:47 +0200
Message-Id: <20160602125247.17566-1-sr@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a check to mvebu_pcie_add_windows() to detect, if an MBus window is
already configured. If this is the case (base address, size, target and
attribute are identical), then this window is not created. This fixes
a problem I'm currently seeing on a custom Armada XP based board, which
generates this error upon PCI rescanning (in this case via sysfs):

$ echo 1 > /sys/bus/pci/rescan
mvebu_mbus: cannot add window '4:e8', conflicts with another window
mvebu-pcie soc:pcie-controller: Could not create MBus window at [mem 0x9e000000-0x9e0fffff]: -22

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6b451df..a85b2b4 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -355,18 +355,31 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 	while (size) {
 		size_t sz = 1 << (fls(size) - 1);
 		int ret;
+		u32 wsize;
+		u8 wtarget, wattr;
 
-		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
-							sz, remap);
-		if (ret) {
-			phys_addr_t end = base + sz - 1;
-
-			dev_err(&port->pcie->pdev->dev,
-				"Could not create MBus window at [mem %pa-%pa]: %d\n",
-				&base, &end, ret);
-			mvebu_pcie_del_windows(port, base - size_mapped,
-					       size_mapped);
-			return;
+		/*
+		 * Only add this MBus window when it does not yet exist.
+		 * Otherwise an error may occur upon PCI rescanning (e.g.
+		 * via sysfs).
+		 */
+		ret = mvebu_mbus_get_io_win_info(base, &wsize, &wtarget,
+						 &wattr);
+		if (ret < 0 || wsize != sz || wtarget != target ||
+		    wattr != attribute) {
+			ret = mvebu_mbus_add_window_remap_by_id(target,
+								attribute, base,
+								sz, remap);
+			if (ret) {
+				phys_addr_t end = base + sz - 1;
+
+				dev_err(&port->pcie->pdev->dev,
+					"Could not create MBus window at [mem %pa-%pa]: %d\n",
+					&base, &end, ret);
+				mvebu_pcie_del_windows(port, base - size_mapped,
+						       size_mapped);
+				return;
+			}
 		}
 
 		size -= sz;
-- 
2.8.3

