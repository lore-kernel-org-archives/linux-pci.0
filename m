Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:35529 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:03:50 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 05/10] PCI: rockchip: spilt out rockchip_pcie_deinit_phys
Date: Wed, 23 Aug 2017 15:02:49 +0800
Message-Id: <1503471769-73953-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Spilt out rockchip_pcie_deinit_phys so that it could be
reused by rockchip_pcie_suspend_noirq and rockchip_pcie_remove.
No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 891b60a..9cd51e0 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -753,6 +753,18 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
+{
+	int i;
+
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		/* inactive lane is already powered off */
+		if (rockchip->lanes_map & BIT(i))
+			phy_power_off(rockchip->phys[i]);
+		phy_exit(rockchip->phys[i]);
+	}
+}
+
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -1423,7 +1435,7 @@ static void rockchip_pcie_disable_clocks(void *data)
 static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
-	int ret, i;
+	int ret;
 
 	/* disable core and cli int since we don't need to ack PME_ACK */
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
@@ -1436,12 +1448,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 		return ret;
 	}
 
-	for (i = 0; i < MAX_LANE_NUM; i++) {
-		/* inactive lane is already powered off */
-		if (rockchip->lanes_map & BIT(i))
-			phy_power_off(rockchip->phys[i]);
-		phy_exit(rockchip->phys[i]);
-	}
+	rockchip_pcie_deinit_phys(rockchip);
 
 	rockchip_pcie_disable_clocks(rockchip);
 
@@ -1640,19 +1647,13 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
-	int i;
 
 	pci_stop_root_bus(rockchip->root_bus);
 	pci_remove_root_bus(rockchip->root_bus);
 	pci_unmap_iospace(rockchip->io);
 	irq_domain_remove(rockchip->irq_domain);
 
-	for (i = 0; i < MAX_LANE_NUM; i++) {
-		/* inactive lane is already powered off */
-		if (rockchip->lanes_map & BIT(i))
-			phy_power_off(rockchip->phys[i]);
-		phy_exit(rockchip->phys[i]);
-	}
+	rockchip_pcie_deinit_phys(rockchip);
 
 	if (!IS_ERR(rockchip->vpcie12v))
 		regulator_disable(rockchip->vpcie12v);
-- 
1.9.1
