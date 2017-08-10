Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:44720 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdHJAhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2017 20:37:21 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: rockchip: manipulate phy properly if failing to probe the driver
Date: Thu, 10 Aug 2017 08:36:31 +0800
Message-Id: <1502325391-32492-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We observed that the clk_pciephy_ref is still enabled when we actually
fail to probe the driver.

root@linaro-alip:~# cat /sys/kernel/debug/clk/clk_summary | grep pcie
clk_pciephy_ref			  1	1	 24000000	0 0
clk_pcie_pm			  0	0	 24000000	0 0
      clk_pcie_core_cru           0	0	125000000	0 0
      clk_pciephy_ref100m         0	0	100000000	0 0
		aclk_pcie         0	0	148500000	0 0
		aclk_perf_pcie    0	0	148500000	0 0
			pclk_pcie 0	0	 37125000	0 0
clk_pcie_core                     0	0		0	0 0

clk_pciephy_ref is used by phy driver and we need to properly disable
it for this case. So this patch add error handle for the function of
rockchip_pcie_init_port to fix this issue.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- introduce two new variables init and pwron for simply the logic
  of handle different kinds of failure cases

 drivers/pci/host/pcie-rockchip.c | 52 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 2eccd53..39aafe2 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -534,7 +534,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
-	int err, i;
+	int err, i, init, pwron;
 	u32 status;
 
 	gpiod_set_value(rockchip->ep_gpio, 0);
@@ -557,36 +557,36 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	for (i = 0; i < MAX_LANE_NUM; i++) {
-		err = phy_init(rockchip->phys[i]);
+	for (init = 0; init < MAX_LANE_NUM; init++) {
+		err = phy_init(rockchip->phys[init]);
 		if (err) {
-			dev_err(dev, "init phy%d err %d\n", i, err);
-			return err;
+			dev_err(dev, "init phy%d err %d\n", init, err);
+			goto err_phy_exit;
 		}
 	}
 
 	err = reset_control_assert(rockchip->core_rst);
 	if (err) {
 		dev_err(dev, "assert core_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_rst);
 	if (err) {
 		dev_err(dev, "assert mgmt_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_sticky_rst);
 	if (err) {
 		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	err = reset_control_assert(rockchip->pipe_rst);
 	if (err) {
 		dev_err(dev, "assert pipe_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	udelay(10);
@@ -594,19 +594,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_deassert(rockchip->pm_rst);
 	if (err) {
 		dev_err(dev, "deassert pm_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	err = reset_control_deassert(rockchip->aclk_rst);
 	if (err) {
 		dev_err(dev, "deassert aclk_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	err = reset_control_deassert(rockchip->pclk_rst);
 	if (err) {
 		dev_err(dev, "deassert pclk_rst err %d\n", err);
-		return err;
+		goto err_phy_exit;
 	}
 
 	if (rockchip->link_gen == 2)
@@ -624,11 +624,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			    PCIE_CLIENT_MODE_RC,
 			    PCIE_CLIENT_CONFIG);
 
-	for (i = 0; i < MAX_LANE_NUM; i++) {
-		err = phy_power_on(rockchip->phys[i]);
+	for (pwron = 0; pwron < MAX_LANE_NUM; pwron++) {
+		err = phy_power_on(rockchip->phys[pwron]);
 		if (err) {
-			dev_err(dev, "power on phy%d err %d\n", i, err);
-			return err;
+			dev_err(dev, "power on phy%d err %d\n", pwron, err);
+			goto err_phy_power_off;
 		}
 	}
 
@@ -639,25 +639,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
 		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		return err;
+		goto err_phy_power_off;
 	}
 
 	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
 		dev_err(dev, "deassert core_rst err %d\n", err);
-		return err;
+		goto err_phy_power_off;
 	}
 
 	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
 		dev_err(dev, "deassert mgmt_rst err %d\n", err);
-		return err;
+		goto err_phy_power_off;
 	}
 
 	err = reset_control_deassert(rockchip->pipe_rst);
 	if (err) {
 		dev_err(dev, "deassert pipe_rst err %d\n", err);
-		return err;
+		goto err_phy_power_off;
 	}
 
 	/* Fix the transmitted FTS count desired to exit from L0s. */
@@ -690,7 +690,8 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 				 500 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(dev, "PCIe link training gen1 timeout!\n");
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto err_phy_power_off;
 	}
 
 	if (rockchip->link_gen == 2) {
@@ -751,6 +752,15 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
 
 	return 0;
+
+err_phy_power_off:
+	for (i = 0; i < init; i++)
+		phy_power_off(rockchip->phys[i]);
+err_phy_exit:
+	for (i = 0; i < pwron; i++)
+		phy_exit(rockchip->phys[i]);
+
+	return err;
 }
 
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
-- 
1.9.1
