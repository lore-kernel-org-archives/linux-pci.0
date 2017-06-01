Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35221 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdFAKWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2017 06:22:00 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: shawn.lin@rock-chips.com, wenrui.li@rock-chips.com, heiko@sntech.de
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rockchip: Handle return value of clk_prepare_enable
Date: Thu,  1 Jun 2017 15:51:45 +0530
Message-Id: <4ebfc69644f9d6e9e5ff0cfc82e9efa5c476be0e.1496312348.git.arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/host/pcie-rockchip.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0e020b6..0a248cd 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1259,24 +1259,46 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
 
-	clk_prepare_enable(rockchip->clk_pcie_pm);
-	clk_prepare_enable(rockchip->hclk_pcie);
-	clk_prepare_enable(rockchip->aclk_perf_pcie);
-	clk_prepare_enable(rockchip->aclk_pcie);
+	err = clk_prepare_enable(rockchip->clk_pcie_pm);
+	if (err)
+		goto err_pcie_pm;
+
+	err = clk_prepare_enable(rockchip->hclk_pcie);
+	if (err)
+		goto err_hclk_pcie;
+
+	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
+	if (err)
+		goto err_aclk_perf_pcie;
+
+	err = clk_prepare_enable(rockchip->aclk_pcie);
+	if (err)
+		goto err_aclk_pcie;
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
-		return err;
+		goto err_pcie_resume;
 
 	err = rockchip_cfg_atu(rockchip);
 	if (err)
-		return err;
+		goto err_pcie_resume;
 
 	/* Need this to enter L1 again */
 	rockchip_pcie_update_txcredit_mui(rockchip);
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	return 0;
+
+err_pcie_resume:
+	clk_disable_unprepare(rockchip->aclk_pcie);
+err_aclk_pcie:
+	clk_disable_unprepare(rockchip->aclk_perf_pcie);
+err_aclk_perf_pcie:
+	clk_disable_unprepare(rockchip->hclk_pcie);
+err_hclk_pcie:
+	clk_disable_unprepare(rockchip->clk_pcie_pm);
+err_pcie_pm:
+	return err;
 }
 
 static int rockchip_pcie_probe(struct platform_device *pdev)
-- 
1.9.1
