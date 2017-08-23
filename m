Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:50073 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:03:32 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 03/10] PCI: rockchip: spilt out rockchip_pcie_disable_clocks
Date: Wed, 23 Aug 2017 15:02:28 +0800
Message-Id: <1503471748-73858-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Spilt out rockchip_pcie_disable_clocks so that it could be
reused by other functions. No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 52974cf..971d22b 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1414,6 +1414,16 @@ static int rockchip_pcie_enable_clocks(
 	return err;
 }
 
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
@@ -1437,10 +1447,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 		phy_exit(rockchip->phys[i]);
 	}
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	rockchip_pcie_disable_clocks(rockchip);
 
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
@@ -1480,10 +1487,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 	return 0;
 
 err_pcie_resume:
-	clk_disable_unprepare(rockchip->aclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
+	rockchip_pcie_disable_clocks(rockchip);
 	return err;
 }
 
@@ -1622,10 +1626,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
 err_set_vpcie:
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	rockchip_pcie_disable_clocks(rockchip);
 	return err;
 }
 
@@ -1647,10 +1648,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 		phy_exit(rockchip->phys[i]);
 	}
 
-	clk_disable_unprepare(rockchip->clk_pcie_pm);
-	clk_disable_unprepare(rockchip->hclk_pcie);
-	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-	clk_disable_unprepare(rockchip->aclk_pcie);
+	rockchip_pcie_disable_clocks(rockchip);
 
 	if (!IS_ERR(rockchip->vpcie12v))
 		regulator_disable(rockchip->vpcie12v);
-- 
1.9.1
