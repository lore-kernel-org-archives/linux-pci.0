Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:44691 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab2IKAT6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2012 20:19:58 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: VL <vl.homutov@gmail.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] PCI: Check bridge secondary/subordinate bus register
Date: Mon, 10 Sep 2012 17:19:33 -0700
Message-Id: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel DP43BF requires "pci=assign-busses" to discover some devices.

It turns out BIOS set the bridge 00:1e.0 bus register wrong.

Try to check that wrong range and reject so next pass could only assign
bus for that bridge.

	https://bugzilla.kernel.org/show_bug.cgi?id=18412

Reported-by: VL <vl.homutov@gmail.com>
Tested-by: VL <vl.homutov@gmail.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3cdba8b..a8f1bf6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -729,7 +729,8 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 	/* Check if setup is sensible at all */
 	if (!pass &&
-	    (primary != bus->number || secondary <= bus->number)) {
+	    (primary != bus->number || secondary <= bus->number ||
+	     secondary > subordinate)) {
 		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
 		broken = 1;
 	}
