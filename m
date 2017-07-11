Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:41517 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbdGKKPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2017 06:15:39 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] PCI: rockchip: fix wrong check of pci_scan_root_bus_bridge
Date: Tue, 11 Jul 2017 18:15:08 +0800
Message-Id: <1499768108-48891-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's wrong to check the return value of pci_scan_root_bus_bridge
here by using (!err) as 0 means it successfully scans the root
bridge. So the probe process will be terminated mistakenly.

Fixes: ae13cb9b ("PCI: rockchip: Convert PCI scan API to ...")
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 5acf869..7bb9870 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1483,7 +1483,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	bridge->swizzle_irq = pci_common_swizzle;
 
 	err = pci_scan_root_bus_bridge(bridge);
-	if (!err)
+	if (err < 0)
 		goto err_free_res;
 
 	bus = bridge->bus;
-- 
1.9.1
