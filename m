Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:44756 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHDo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:03:44 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 04/10] PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
Date: Wed, 23 Aug 2017 15:02:38 +0800
Message-Id: <1503471758-73904-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
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

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v5:
- rebase on former reconstrtion patches suggested by Bjorn

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

 drivers/pci/host/pcie-rockchip.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 971d22b..891b60a 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1099,10 +1099,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return PTR_ERR(rockchip->clk_pcie_pm);
 	}
 
-	err = rockchip_pcie_setup_irq(rockchip);
-	if (err)
-		return err;
-
 	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(rockchip->vpcie12v)) {
 		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
@@ -1525,10 +1521,22 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = devm_add_action_or_reset(dev,
+				       rockchip_pcie_disable_clocks,
+				       rockchip);
+	if (err) {
+		dev_err(dev, "unable to add action or reset\n");
+		return err;
+	}
+
+	err = rockchip_pcie_setup_irq(rockchip);
+	if (err)
+		return err;
+
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
 		dev_err(dev, "failed to set vpcie regulator\n");
-		goto err_set_vpcie;
+		return err;
 	}
 
 	err = rockchip_pcie_init_port(rockchip);
@@ -1625,8 +1633,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		regulator_disable(rockchip->vpcie1v8);
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
-err_set_vpcie:
-	rockchip_pcie_disable_clocks(rockchip);
 	return err;
 }
 
@@ -1648,8 +1654,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 		phy_exit(rockchip->phys[i]);
 	}
 
-	rockchip_pcie_disable_clocks(rockchip);
-
 	if (!IS_ERR(rockchip->vpcie12v))
 		regulator_disable(rockchip->vpcie12v);
 	if (!IS_ERR(rockchip->vpcie3v3))
-- 
1.9.1
