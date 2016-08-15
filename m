Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36290 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbcHOPbl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2016 11:31:41 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] PCI: tegra: Use of_device_get_match_data()
Date: Mon, 15 Aug 2016 17:31:32 +0200
Message-Id: <20160815153132.520-2-thierry.reding@gmail.com>
In-Reply-To: <20160815153132.520-1-thierry.reding@gmail.com>
References: <20160815153132.520-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

This function was introduced a couple of releases ago to help reduce the
the boilerplate required to get at the SoC specific data.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 7756a792600c..2d520755b1d7 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2201,21 +2201,16 @@ remove:
 
 static int tegra_pcie_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct tegra_pcie *pcie;
 	int err;
 
-	match = of_match_device(tegra_pcie_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
+	pcie->soc = of_device_get_match_data(&pdev->dev);
 	INIT_LIST_HEAD(&pcie->buses);
 	INIT_LIST_HEAD(&pcie->ports);
-	pcie->soc = match->data;
 	pcie->dev = &pdev->dev;
 
 	err = tegra_pcie_parse_dt(pcie);
-- 
2.9.0

