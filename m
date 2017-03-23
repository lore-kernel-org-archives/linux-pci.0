Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:34010 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdCWIpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2017 04:45:51 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: slightly reword the log for bus numbering
Date: Thu, 23 Mar 2017 16:42:05 +0800
Message-Id: <1490258525-80319-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I was confused by the log that bridge configuration is invalid.
It seems like that the RC driver do some silly configurations
before sacnning the tree. But actually it was just trying to
figure out if the hierarchy behind the bridge had been configured
by BIOS. The log should better reflect the fact and don't mislead
folks.

pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
reconfiguring

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3abc942..957d7c4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -975,7 +975,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 	if (!pass &&
 	    (primary != bus->number || secondary <= bus->number ||
 	     secondary > subordinate)) {
-		dev_info(&dev->dev, "bridge configuration invalid ([bus %02x-%02x]), reconfiguring\n",
+		dev_info(&dev->dev, "bridge hasn't been configured by BIOS ([bus %02x-%02x]), reconfiguring\n",
 			 secondary, subordinate);
 		broken = 1;
 	}
-- 
1.9.1
