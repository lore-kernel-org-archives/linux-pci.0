Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: [PATCH v4 1/4] PCI: rockchip: Fix error handlings
Date: Tue, 22 Aug 2017 11:19:31 +0800
Message-Id: <20170822031934.8675-2-jeffy.chen@rock-chips.com>
In-Reply-To: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com, briannorris@chromium.org,
 dianders@chromium.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Fix error handlings in probe & resume.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4:
Rebase on newest for-next branch, also fix error handling by:
1e7f570a1b86 PCI: rockchip: Idle inactive PHY(s)

Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 160 +++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 73 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 2eccd532c256..5d85ec2e2fb0 100644
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
@@ -751,6 +751,26 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
+}
+
+static void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
+{
+	int i;
+
+	for (i = 0; i < MAX_LANE_NUM; i++) {
+		/* inactive lane is already powered off */
+		if (rockchip->legacy_phy || rockchip->lanes_map & BIT(i))
+			phy_power_off(rockchip->phys[i]);
+		phy_exit(rockchip->phys[i]);
+	}
 }
 
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
@@ -1131,7 +1151,7 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 		err = regulator_enable(rockchip->vpcie12v);
 		if (err) {
 			dev_err(dev, "fail to enable vpcie12v regulator\n");
-			goto err_out;
+			return err;
 		}
 	}
 
@@ -1160,7 +1180,6 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 	}
 
 	return 0;
-
 err_disable_1v8:
 	if (!IS_ERR(rockchip->vpcie1v8))
 		regulator_disable(rockchip->vpcie1v8);
@@ -1170,7 +1189,6 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 err_disable_12v:
 	if (!IS_ERR(rockchip->vpcie12v))
 		regulator_disable(rockchip->vpcie12v);
-err_out:
 	return err;
 }
 
@@ -1364,7 +1382,7 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
 static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
-	int ret, i;
+	int ret;
 
 	/* disable core and cli int since we don't need to ack PME_ACK */
 	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
@@ -1377,12 +1395,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 		return ret;
 	}
 
-	for (i = 0; i < MAX_LANE_NUM; i++) {
-		/* inactive lane is already powered off */
-		if (rockchip->lanes_map & BIT(i))
-			phy_power_off(rockchip->phys[i]);
-		phy_exit(rockchip->phys[i]);
-	}
+	rockchip_pcie_deinit_phys(rockchip);
 
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
 	clk_disable_unprepare(rockchip->hclk_pcie);
@@ -1391,7 +1404,6 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
-
 	return ret;
 }
 
@@ -1410,43 +1422,46 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 
 	err = clk_prepare_enable(rockchip->clk_pcie_pm);
 	if (err)
-		goto err_pcie_pm;
+		goto err_disable_0v9;
 
 	err = clk_prepare_enable(rockchip->hclk_pcie);
 	if (err)
-		goto err_hclk_pcie;
+		goto err_disable_clk_pcie_pm;
 
 	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
 	if (err)
-		goto err_aclk_perf_pcie;
+		goto err_disable_hclk_pcie;
 
 	err = clk_prepare_enable(rockchip->aclk_pcie);
 	if (err)
-		goto err_aclk_pcie;
+		goto err_disable_aclk_perf_pcie;
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
-		goto err_pcie_resume;
+		goto err_disable_aclk_pcie;
 
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_pcie_resume;
+		goto err_deinit_port;
 
 	/* Need this to enter L1 again */
 	rockchip_pcie_update_txcredit_mui(rockchip);
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	return 0;
-
-err_pcie_resume:
+err_deinit_port:
+	rockchip_pcie_deinit_phys(rockchip);
+err_disable_aclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
+err_disable_aclk_perf_pcie:
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
+err_disable_hclk_pcie:
 	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
+err_disable_clk_pcie_pm:
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
+err_disable_0v9:
+	if (!IS_ERR(rockchip->vpcie0v9))
+		regulator_disable(rockchip->vpcie0v9);
 	return err;
 }
 
@@ -1483,47 +1498,47 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(rockchip->aclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		goto err_aclk_pcie;
+		return err;
 	}
 
 	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
-		goto err_aclk_perf_pcie;
+		goto err_disable_aclk_pcie;
 	}
 
 	err = clk_prepare_enable(rockchip->hclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_hclk_pcie;
+		goto err_disable_aclk_perf_pcie;
 	}
 
 	err = clk_prepare_enable(rockchip->clk_pcie_pm);
 	if (err) {
 		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_pcie_pm;
+		goto err_disable_hclk_pcie;
 	}
 
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
 		dev_err(dev, "failed to set vpcie regulator\n");
-		goto err_set_vpcie;
+		goto err_disable_clk_pcie_pm;
 	}
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
-		goto err_vpcie;
+		goto err_disable_vpcie;
 
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	err = rockchip_pcie_init_irq_domain(rockchip);
 	if (err < 0)
-		goto err_vpcie;
+		goto err_deinit_port;
 
 	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
 					       &res, &io_base);
 	if (err)
-		goto err_vpcie;
+		goto err_remove_irq_domain;
 
 	err = devm_request_pci_bus_resources(dev, &res);
 	if (err)
@@ -1561,12 +1576,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_free_res;
+		goto err_unmap_iospace;
 
 	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
 	if (!rockchip->msg_region) {
 		err = -ENOMEM;
-		goto err_free_res;
+		goto err_unmap_iospace;
 	}
 
 	list_splice_init(&res, &bridge->windows);
@@ -1591,28 +1606,33 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-	return 0;
 
+	return 0;
+err_unmap_iospace:
+	pci_unmap_iospace(rockchip->io);
 err_free_res:
 	pci_free_resource_list(&res);
-err_vpcie:
-	if (!IS_ERR(rockchip->vpcie12v))
-		regulator_disable(rockchip->vpcie12v);
-	if (!IS_ERR(rockchip->vpcie3v3))
-		regulator_disable(rockchip->vpcie3v3);
-	if (!IS_ERR(rockchip->vpcie1v8))
-		regulator_disable(rockchip->vpcie1v8);
+err_remove_irq_domain:
+	irq_domain_remove(rockchip->irq_domain);
+err_deinit_port:
+	rockchip_pcie_deinit_phys(rockchip);
+err_disable_vpcie:
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
-err_set_vpcie:
+	if (!IS_ERR(rockchip->vpcie1v8))
+		regulator_disable(rockchip->vpcie1v8);
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
+	if (!IS_ERR(rockchip->vpcie12v))
+		regulator_disable(rockchip->vpcie12v);
+err_disable_clk_pcie_pm:
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
+err_disable_hclk_pcie:
 	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
+err_disable_aclk_perf_pcie:
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
+err_disable_aclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
 	return err;
 }
 
@@ -1620,33 +1640,27 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
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
 
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
 	clk_disable_unprepare(rockchip->hclk_pcie);
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
 	clk_disable_unprepare(rockchip->aclk_pcie);
 
-	if (!IS_ERR(rockchip->vpcie12v))
-		regulator_disable(rockchip->vpcie12v);
-	if (!IS_ERR(rockchip->vpcie3v3))
-		regulator_disable(rockchip->vpcie3v3);
-	if (!IS_ERR(rockchip->vpcie1v8))
-		regulator_disable(rockchip->vpcie1v8);
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
+	if (!IS_ERR(rockchip->vpcie1v8))
+		regulator_disable(rockchip->vpcie1v8);
+	if (!IS_ERR(rockchip->vpcie3v3))
+		regulator_disable(rockchip->vpcie3v3);
+	if (!IS_ERR(rockchip->vpcie12v))
+		regulator_disable(rockchip->vpcie12v);
 
 	return 0;
 }
-- 
2.11.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
