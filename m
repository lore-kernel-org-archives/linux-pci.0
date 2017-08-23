Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:41628 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:04:10 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 07/10] PCI: rockchip: Clean up PHY if driver probe or resume fails
Date: Wed, 23 Aug 2017 15:03:07 +0800
Message-Id: <1503471787-74055-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We observed that the clk_pciephy_ref is still enabled when we actually
fail to probe the driver.

root@linaro-alip:~# cat /sys/kernel/debug/clk/clk_summary | grep pcie
clk_pciephy_ref                    1     1        24000000       0 0
clk_pcie_pm                        0     0        24000000       0 0
        clk_pcie_core_cru          0     0       125000000       0 0
        clk_pciephy_ref100m        0     0       100000000       0 0
                aclk_pcie          0     0       148500000       0 0
                aclk_perf_pcie     0     0       148500000       0 0
                        pclk_pcie  0     0        37125000       0 0
clk_pcie_core                      0     0               0       0 0

clk_pciephy_ref is used by phy driver and we need to properly disable
it for this case. So this patch add error handle for the function of
rockchip_pcie_init_port and rockchip_pcie_resume_noirq to fix this issue.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v5:
- fix all the missing error handling cases that need to cleanup
  PHY

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 46 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 933e3e9..42dcb3d 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -561,32 +561,32 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		err = phy_init(rockchip->phys[i]);
 		if (err) {
 			dev_err(dev, "init phy%d err %d\n", i, err);
-			return err;
+			goto err_exit_phy;
 		}
 	}
 
 	err = reset_control_assert(rockchip->core_rst);
 	if (err) {
 		dev_err(dev, "assert core_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_rst);
 	if (err) {
 		dev_err(dev, "assert mgmt_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_sticky_rst);
 	if (err) {
 		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->pipe_rst);
 	if (err) {
 		dev_err(dev, "assert pipe_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	udelay(10);
@@ -594,19 +594,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_deassert(rockchip->pm_rst);
 	if (err) {
 		dev_err(dev, "deassert pm_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_deassert(rockchip->aclk_rst);
 	if (err) {
 		dev_err(dev, "deassert aclk_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_deassert(rockchip->pclk_rst);
 	if (err) {
 		dev_err(dev, "deassert pclk_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	if (rockchip->link_gen == 2)
@@ -628,7 +628,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		err = phy_power_on(rockchip->phys[i]);
 		if (err) {
 			dev_err(dev, "power on phy%d err %d\n", i, err);
-			return err;
+			goto err_power_off_phy;
 		}
 	}
 
@@ -639,25 +639,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
 		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
 		dev_err(dev, "deassert core_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
 		dev_err(dev, "deassert mgmt_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->pipe_rst);
 	if (err) {
 		dev_err(dev, "deassert pipe_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	/* Fix the transmitted FTS count desired to exit from L0s. */
@@ -690,7 +690,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 				 500 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(dev, "PCIe link training gen1 timeout!\n");
-		return -ETIMEDOUT;
+		goto err_power_off_phy;
 	}
 
 	if (rockchip->link_gen == 2) {
@@ -751,6 +751,14 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
 
 	return 0;
+err_power_off_phy:
+	while (i--)
+		phy_power_off(rockchip->phys[i]);
+	i = MAX_LANE_NUM;
+err_exit_phy:
+	while (i--)
+		phy_exit(rockchip->phys[i]);
+	return err;
 }
 
 static void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
@@ -1481,7 +1489,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_pcie_resume;
+		goto err_err_deinit_port;
 
 	/* Need this to enter L1 again */
 	rockchip_pcie_update_txcredit_mui(rockchip);
@@ -1489,6 +1497,8 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 
 	return 0;
 
+err_err_deinit_port:
+	rockchip_pcie_deinit_phys(rockchip);
 err_pcie_resume:
 	rockchip_pcie_disable_clocks(rockchip);
 	return err;
@@ -1554,12 +1564,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_init_irq_domain(rockchip);
 	if (err < 0)
-		goto err_vpcie;
+		goto err_deinit_port;
 
 	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
 					       &res, &io_base);
 	if (err)
-		goto err_vpcie;
+		goto err_deinit_port;
 
 	err = devm_request_pci_bus_resources(dev, &res);
 	if (err)
@@ -1631,6 +1641,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 err_free_res:
 	pci_free_resource_list(&res);
+err_deinit_port:
+	rockchip_pcie_deinit_phys(rockchip);
 err_vpcie:
 	if (!IS_ERR(rockchip->vpcie12v))
 		regulator_disable(rockchip->vpcie12v);
-- 
1.9.1
