Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:57102 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbcKWEQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 23:16:33 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] PCI: rockchip: move the deassert of pm/aclk/pclk after phy_init
Date: Wed, 23 Nov 2016 12:15:14 +0800
Message-Id: <1479874515-65872-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1479874515-65872-1-git-send-email-shawn.lin@rock-chips.com>
References: <1479874515-65872-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move them after phy_init as we want to optimize the logic
of reset control and reuse rockchip_pcie_init_port later
which should fully follow the cold boot procedure of ROM
code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 9cb84b1..457401d 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -473,26 +473,6 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	udelay(10);
-
-	err = reset_control_deassert(rockchip->pm_rst);
-	if (err) {
-		dev_err(dev, "deassert pm_rst err %d\n", err);
-		return err;
-	}
-
-	err = reset_control_deassert(rockchip->aclk_rst);
-	if (err) {
-		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		return err;
-	}
-
-	err = reset_control_deassert(rockchip->pclk_rst);
-	if (err) {
-		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		return err;
-	}
-
 	err = phy_init(rockchip->phy);
 	if (err < 0) {
 		dev_err(dev, "fail to init phy, err %d\n", err);
@@ -523,6 +503,26 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	udelay(10);
+
+	err = reset_control_deassert(rockchip->pm_rst);
+	if (err) {
+		dev_err(dev, "deassert pm_rst err %d\n", err);
+		return err;
+	}
+
+	err = reset_control_deassert(rockchip->aclk_rst);
+	if (err) {
+		dev_err(dev, "deassert aclk_rst err %d\n", err);
+		return err;
+	}
+
+	err = reset_control_deassert(rockchip->pclk_rst);
+	if (err) {
+		dev_err(dev, "deassert pclk_rst err %d\n", err);
+		return err;
+	}
+
 	if (rockchip->link_gen == 2)
 		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
 				    PCIE_CLIENT_CONFIG);
-- 
1.9.1


