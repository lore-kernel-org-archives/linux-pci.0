Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:44421 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932912AbcHaJ2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2016 05:28:37 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: rcar: Don't disable/unprepare clocks on prepare/enable failure
Date: Wed, 31 Aug 2016 11:28:22 +0200
Message-Id: <1472635702-26465-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If clk_prepare_enable() fails, we must not call clk_disable_unprepare()
in the error path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 65db7a2215090ff4..0f5c2b2b4f8dfcd2 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -782,7 +782,7 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	}
 	err = clk_prepare_enable(pcie->clk);
 	if (err)
-		goto fail_clk;
+		return err;
 
 	pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
 	if (IS_ERR(pcie->bus_clk)) {
@@ -792,7 +792,7 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	}
 	err = clk_prepare_enable(pcie->bus_clk);
 	if (err)
-		goto err_map_reg;
+		goto fail_clk;
 
 	i = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	if (!i) {
-- 
1.9.1

