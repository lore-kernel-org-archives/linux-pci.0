Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:44974 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3LBDjt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Dec 2013 22:39:49 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so3890582qac.7
        for <linux-pci@vger.kernel.org>; Sun, 01 Dec 2013 19:39:48 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: marex@denx.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] PCI: imx6: Remove unneeded check of platform_get_resource()
Date: Mon,  2 Dec 2013 01:39:34 -0200
Message-Id: <1385955575-25270-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

When using devm_ioremap_resource(), we do not need to check the return value of
platform_get_resource(), so just remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index bd70af8..5002e23 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -426,11 +426,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		"imprecise external abort");
 
 	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!dbi_base) {
-		dev_err(&pdev->dev, "dbi_base memory resource not found\n");
-		return -ENODEV;
-	}
-
 	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
 	if (IS_ERR(pp->dbi_base)) {
 		ret = PTR_ERR(pp->dbi_base);
-- 
1.8.1.2

