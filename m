Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:58324 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHKHT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2017 03:19:57 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4] PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
Date: Fri, 11 Aug 2017 15:19:11 +0800
Message-Id: <1502435951-162973-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
would still access the irq handler registed as a shard irq.
Per the comment within the function of __free_irq, it says
"It's a shared IRQ -- the driver ought to be prepared for
an IRQ event to happen even now it's being freed". However
when failing to probe the driver, it may disable the clock
for accessing the register and the following check for shared
irq state would call the irq handler which accesses the register
w/o the clk enabled. That will hang the system forever.

With adding some dump_stack we could see how that happened.

calling  rockchip_pcie_driver_init+0x0/0x28 @ 1
rockchip-pcie f8000000.pcie: no vpcie3v3 regulator found
rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc3-next-20170807-ARCH+ #189
Hardware name: Firefly-RK3399 Board (DT)
Call trace:
[<ffff000008089bf0>] dump_backtrace+0x0/0x250
[<ffff000008089eb0>] show_stack+0x20/0x28
[<ffff000008c3313c>] dump_stack+0x90/0xb0
[<ffff000008632ad4>] rockchip_pcie_read.isra.11+0x54/0x58
[<ffff0000086334fc>] rockchip_pcie_client_irq_handler+0x30/0x1a0
[<ffff00000813ce98>] __free_irq+0x1c8/0x2dc
[<ffff00000813d044>] free_irq+0x44/0x74
[<ffff0000081415fc>] devm_irq_release+0x24/0x2c
[<ffff00000877429c>] release_nodes+0x1d8/0x30c
[<ffff000008774838>] devres_release_all+0x3c/0x5c
[<ffff00000876f19c>] driver_probe_device+0x244/0x494
[<ffff00000876f50c>] __driver_attach+0x120/0x124
[<ffff00000876cb80>] bus_for_each_dev+0x6c/0xac
[<ffff00000876e984>] driver_attach+0x2c/0x34
[<ffff00000876e3a4>] bus_add_driver+0x244/0x2b0
[<ffff000008770264>] driver_register+0x70/0x110
[<ffff0000087718b4>] platform_driver_register+0x60/0x6c
[<ffff0000091eb108>] rockchip_pcie_driver_init+0x20/0x28
[<ffff000008083a2c>] do_one_initcall+0xc8/0x130
[<ffff0000091a0ea8>] kernel_init_freeable+0x1a0/0x238
[<ffff000008c461cc>] kernel_init+0x18/0x108
[<ffff0000080836c0>] ret_from_fork+0x10/0x50

In order to fix this, we remove all the clock-disabling from
the error handle path and driver's remove function. And replying
on the devm_add_action_or_reset to fire the clock-disabling at
the appropriate time. Also split out rockchip_pcie_setup_irq
and move requesting irq after enabling clks to avoid this kind
of issues.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v4:
- split out rockchip_pcie_enable_clocks and reuse
  rockchip_pcie_enable_clocks and rockchip_pcie_disable_clocks
  for elsewhere suggested by Jeffy

Changes in v3:
- check the return value of devm_add_action_or_reset and spilt out
  rockchip_pcie_setup_irq in order to move requesting irq after
  enabling clks.

Changes in v2:
- use devm_add_action_or_reset to fix this ordering suggested by
  Heiko and Jeffy. Thanks!

 drivers/pci/host/pcie-rockchip.c | 209 +++++++++++++++++++++------------------
 1 file changed, 112 insertions(+), 97 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 39aafe2..e8b90aa 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -939,6 +939,51 @@ static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
+{
+	int irq, err;
+	struct device *dev = rockchip->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	irq = platform_get_irq_byname(pdev, "sys");
+	if (irq < 0) {
+		dev_err(dev, "missing sys IRQ resource\n");
+		return -EINVAL;
+	}
+
+	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
+			       IRQF_SHARED, "pcie-sys", rockchip);
+	if (err) {
+		dev_err(dev, "failed to request PCIe subsystem IRQ\n");
+		return err;
+	}
+
+	irq = platform_get_irq_byname(pdev, "legacy");
+	if (irq < 0) {
+		dev_err(dev, "missing legacy IRQ resource\n");
+		return -EINVAL;
+	}
+
+	irq_set_chained_handler_and_data(irq,
+					 rockchip_pcie_legacy_int_handler,
+					 rockchip);
+
+	irq = platform_get_irq_byname(pdev, "client");
+	if (irq < 0) {
+		dev_err(dev, "missing client IRQ resource\n");
+		return -EINVAL;
+	}
+
+	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
+			       IRQF_SHARED, "pcie-client", rockchip);
+	if (err) {
+		dev_err(dev, "failed to request PCIe client IRQ\n");
+		return err;
+	}
+
+	return 0;
+}
+
 /**
  * rockchip_pcie_parse_dt - Parse Device Tree
  * @rockchip: PCIe port information
@@ -951,7 +996,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
 	struct resource *regs;
-	int irq;
 	int err;
 
 	regs = platform_get_resource_byname(pdev,
@@ -1065,42 +1109,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return PTR_ERR(rockchip->clk_pcie_pm);
 	}
 
-	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0) {
-		dev_err(dev, "missing sys IRQ resource\n");
-		return -EINVAL;
-	}
-
-	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
-			       IRQF_SHARED, "pcie-sys", rockchip);
-	if (err) {
-		dev_err(dev, "failed to request PCIe subsystem IRQ\n");
-		return err;
-	}
-
-	irq = platform_get_irq_byname(pdev, "legacy");
-	if (irq < 0) {
-		dev_err(dev, "missing legacy IRQ resource\n");
-		return -EINVAL;
-	}
-
-	irq_set_chained_handler_and_data(irq,
-					 rockchip_pcie_legacy_int_handler,
-					 rockchip);
-
-	irq = platform_get_irq_byname(pdev, "client");
-	if (irq < 0) {
-		dev_err(dev, "missing client IRQ resource\n");
-		return -EINVAL;
-	}
-
-	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
-			       IRQF_SHARED, "pcie-client", rockchip);
-	if (err) {
-		dev_err(dev, "failed to request PCIe client IRQ\n");
-		return err;
-	}
-
 	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(rockchip->vpcie12v)) {
 		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
@@ -1371,6 +1379,57 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static int rockchip_pcie_enable_clocks(
+				struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->dev;
+	int err;
+
+	err = clk_prepare_enable(rockchip->aclk_pcie);
+	if (err) {
+		dev_err(dev, "unable to enable aclk_pcie clock\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
+	if (err) {
+		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
+		goto err_aclk_perf_pcie;
+	}
+
+	err = clk_prepare_enable(rockchip->hclk_pcie);
+	if (err) {
+		dev_err(dev, "unable to enable hclk_pcie clock\n");
+		goto err_hclk_pcie;
+	}
+
+	err = clk_prepare_enable(rockchip->clk_pcie_pm);
+	if (err) {
+		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
+		goto err_clk_pcie_pm;
+	}
+
+	return 0;
+
+err_clk_pcie_pm:
+	clk_disable_unprepare(rockchip->hclk_pcie);
+err_hclk_pcie:
+	clk_disable_unprepare(rockchip->aclk_perf_pcie);
+err_aclk_perf_pcie:
+	clk_disable_unprepare(rockchip->aclk_pcie);
+	return err;
+}
+
+static void rockchip_pcie_disable_clocks(void *data)
+{
+	struct rockchip_pcie *rockchip = data;
+
+	clk_disable_unprepare(rockchip->clk_pcie_pm);
+	clk_disable_unprepare(rockchip->hclk_pcie);
+	clk_disable_unprepare(rockchip->aclk_perf_pcie);
+	clk_disable_unprepare(rockchip->aclk_pcie);
+}
+
 static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -1394,10 +1453,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 		phy_exit(rockchip->phys[i]);
 	}
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	rockchip_pcie_disable_clocks(rockchip);
 
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
@@ -1418,21 +1474,9 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 		}
 	}
 
-	err = clk_prepare_enable(rockchip->clk_pcie_pm);
-	if (err)
-		goto err_pcie_pm;
-
-	err = clk_prepare_enable(rockchip->hclk_pcie);
-	if (err)
-		goto err_hclk_pcie;
-
-	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
-	if (err)
-		goto err_aclk_perf_pcie;
-
-	err = clk_prepare_enable(rockchip->aclk_pcie);
+	err = rockchip_pcie_enable_clocks(rockchip);
 	if (err)
-		goto err_aclk_pcie;
+		return err;
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
@@ -1449,14 +1493,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 	return 0;
 
 err_pcie_resume:
-	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
-	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
+	rockchip_pcie_disable_clocks(rockchip);
 	return err;
 }
 
@@ -1490,34 +1527,26 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = clk_prepare_enable(rockchip->aclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		goto err_aclk_pcie;
-	}
+	err = rockchip_pcie_enable_clocks(rockchip);
+	if (err)
+		return err;
 
-	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
+	err = devm_add_action_or_reset(dev,
+				       rockchip_pcie_disable_clocks,
+				       rockchip);
 	if (err) {
-		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
-		goto err_aclk_perf_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->hclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_hclk_pcie;
+		dev_err(dev, "unable to add action or reset\n");
+		return err;
 	}
 
-	err = clk_prepare_enable(rockchip->clk_pcie_pm);
-	if (err) {
-		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_pcie_pm;
-	}
+	err = rockchip_pcie_setup_irq(rockchip);
+	if (err)
+		return err;
 
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
 		dev_err(dev, "failed to set vpcie regulator\n");
-		goto err_set_vpcie;
+		return err;
 	}
 
 	err = rockchip_pcie_init_port(rockchip);
@@ -1614,15 +1643,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		regulator_disable(rockchip->vpcie1v8);
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
-err_set_vpcie:
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
-	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
-	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
 	return err;
 }
 
@@ -1644,11 +1664,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 		phy_exit(rockchip->phys[i]);
 	}
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
-
 	if (!IS_ERR(rockchip->vpcie12v))
 		regulator_disable(rockchip->vpcie12v);
 	if (!IS_ERR(rockchip->vpcie3v3))
-- 
1.9.1
