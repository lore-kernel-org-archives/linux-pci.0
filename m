Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:44368 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933396AbcJMBLe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2016 21:11:34 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: rockchip: fix wrong print for negotiated lane numbers
Date: Thu, 13 Oct 2016 09:16:31 +0800
Message-Id: <1476321391-6665-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The negotiated lane numbers was incorrectly calculated, fix it.

Fixes: e77f847df54c6b0 ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e0b22da..0d69d8c 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -549,7 +549,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-	status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
+	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
 			  PCIE_CORE_PL_CONF_LANE_MASK);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
-- 
2.3.7


