Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35182 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758910AbcG1QPA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 12:15:00 -0400
Received: by mail-pa0-f68.google.com with SMTP id cf3so3763449pad.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Jul 2016 09:14:59 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: designware-plat: Remove redundant return value check of platform_get_resource()
Date: Thu, 28 Jul 2016 16:14:54 +0000
Message-Id: <1469722494-14701-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/pci/host/pcie-designware-plat.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
index c8079dc..17da005 100644
--- a/drivers/pci/host/pcie-designware-plat.c
+++ b/drivers/pci/host/pcie-designware-plat.c
@@ -100,9 +100,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	pp->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	dw_plat_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dw_plat_pcie->mem_base))
 		return PTR_ERR(dw_plat_pcie->mem_base);

