Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:41453 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:04:00 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 06/10] PCI: rockchip: fix missing phy manipulation for legacy phy
Date: Wed, 23 Aug 2017 15:02:57 +0800
Message-Id: <1503471777-73999-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For instance, if a EP connect to lane3 and work under lagecy
phy mode, so struct phy phys[0..2] are all NULL. In this case,
rockchip->lanes_map & BIT(i) will tell the driver that lane0 is
already inactive, but what we want actually is to power off
the phys[0] for legacy phy mode. Fix this by add checking of
rockchip->legacy_phy for rockchip_pcie_deinit_phys.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 9cd51e0..933e3e9 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -759,7 +759,7 @@ static void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
 
 	for (i = 0; i < MAX_LANE_NUM; i++) {
 		/* inactive lane is already powered off */
-		if (rockchip->lanes_map & BIT(i))
+		if (rockchip->legacy_phy || rockchip->lanes_map & BIT(i))
 			phy_power_off(rockchip->phys[i]);
 		phy_exit(rockchip->phys[i]);
 	}
-- 
1.9.1
