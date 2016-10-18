Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:42982 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933431AbcJRBf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 21:35:57 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 4/4] PCI: rockchip: fix wrong negotiated lanes calculation
Date: Tue, 18 Oct 2016 09:41:29 +0800
Message-Id: <1476754889-21804-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1476754889-21804-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476754889-21804-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The calculation of negotiated lanes is wrong since it should
be shifted by PCIE_CORE_PL_CONF_LANE_SHIFT, but it is shifted
by PCIE_CORE_PL_CONF_LANE_MASK. Let's fix it.

Fixes: commit e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 8e260d2..279ef17 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -595,8 +595,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
-	status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
-			  PCIE_CORE_PL_CONF_LANE_MASK);
+	status = 0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
+			  PCIE_CORE_PL_CONF_LANE_SHIFT);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
-- 
2.3.7


