Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:57938 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdF2BZX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2017 21:25:23 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] PCI: rockchip: control optional 12v power supply
Date: Thu, 29 Jun 2017 09:22:23 +0800
Message-Id: <1498699343-65467-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
References: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is trying to get vpcie12v from DT and control
it if available.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 199edd5..c545213 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -221,6 +221,7 @@ struct rockchip_pcie {
 	struct	clk *aclk_perf_pcie;
 	struct	clk *hclk_pcie;
 	struct	clk *clk_pcie_pm;
+	struct	regulator *vpcie12v; /* 12V power supply */
 	struct	regulator *vpcie3v3; /* 3.3V power supply */
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
@@ -1013,6 +1014,13 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
+	if (IS_ERR(rockchip->vpcie12v)) {
+		if (PTR_ERR(rockchip->vpcie12v) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(dev, "no vpcie12v regulator found\n");
+	}
+
 	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(rockchip->vpcie3v3)) {
 		if (PTR_ERR(rockchip->vpcie3v3) == -EPROBE_DEFER)
@@ -1042,11 +1050,19 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 	struct device *dev = rockchip->dev;
 	int err;
 
+	if (!IS_ERR(rockchip->vpcie12v)) {
+		err = regulator_enable(rockchip->vpcie12v);
+		if (err) {
+			dev_err(dev, "fail to enable vpcie12v regulator\n");
+			goto err_out;
+		}
+	}
+
 	if (!IS_ERR(rockchip->vpcie3v3)) {
 		err = regulator_enable(rockchip->vpcie3v3);
 		if (err) {
 			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
-			goto err_out;
+			goto err_disable_12v;
 		}
 	}
 
@@ -1074,6 +1090,9 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 err_disable_3v3:
 	if (!IS_ERR(rockchip->vpcie3v3))
 		regulator_disable(rockchip->vpcie3v3);
+err_disable_12v:
+	if (!IS_ERR(rockchip->vpcie12v))
+		regulator_disable(rockchip->vpcie12v);
 err_out:
 	return err;
 }
@@ -1497,6 +1516,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 err_free_res:
 	pci_free_resource_list(&res);
 err_vpcie:
+	if (!IS_ERR(rockchip->vpcie12v))
+		regulator_disable(rockchip->vpcie12v);
 	if (!IS_ERR(rockchip->vpcie3v3))
 		regulator_disable(rockchip->vpcie3v3);
 	if (!IS_ERR(rockchip->vpcie1v8))
@@ -1533,6 +1554,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
 	clk_disable_unprepare(rockchip->aclk_pcie);
 
+	if (!IS_ERR(rockchip->vpcie12v))
+		regulator_disable(rockchip->vpcie12v);
 	if (!IS_ERR(rockchip->vpcie3v3))
 		regulator_disable(rockchip->vpcie3v3);
 	if (!IS_ERR(rockchip->vpcie1v8))
-- 
1.9.1
