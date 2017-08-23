Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:49977 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:03:22 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 02/10] PCI: rockchip: spilt out rockchip_pcie_enable_clocks
Date: Wed, 23 Aug 2017 15:02:19 +0800
Message-Id: <1503471739-73811-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Spilt out rockchip_pcie_enable_clocks so that it could be
reused by rockchip_pcie_resume_noirq and rockchip_pcie_probe.
No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 91 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 6dc3d83..52974cf 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1373,6 +1373,47 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
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
 static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -1420,21 +1461,9 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
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
@@ -1452,13 +1481,9 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 
 err_pcie_resume:
 	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
 	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
 	return err;
 }
 
@@ -1492,29 +1517,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = clk_prepare_enable(rockchip->aclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		goto err_aclk_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
-		goto err_aclk_perf_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->hclk_pcie);
-	if (err) {
-		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_hclk_pcie;
-	}
-
-	err = clk_prepare_enable(rockchip->clk_pcie_pm);
-	if (err) {
-		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_pcie_pm;
-	}
+	err = rockchip_pcie_enable_clocks(rockchip);
+	if (err)
+		return err;
 
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
@@ -1618,13 +1623,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		regulator_disable(rockchip->vpcie0v9);
 err_set_vpcie:
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
 	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
 	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
 	return err;
 }
 
-- 
1.9.1
