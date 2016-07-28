Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33232 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920AbcG1QRT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 12:17:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so3956697pfe.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Jul 2016 09:17:19 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: aardvark: Remove redundant dev_err call in advk_pcie_probe()
Date: Thu, 28 Jul 2016 16:17:14 +0000
Message-Id: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/pci/host/pci-aardvark.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index ef9893f..05c33b5 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -925,10 +925,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcie->base)) {
-		dev_err(&pdev->dev, "Failed to map registers\n");
+	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq, advk_pcie_irq_handler,



