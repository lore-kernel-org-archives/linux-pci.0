Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33536 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdGVUYV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2017 16:24:21 -0400
Received: by mail-qt0-f193.google.com with SMTP id 50so9131348qtz.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Jul 2017 13:24:21 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: thomas.petazzoni@free-electrons.com, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] pciarmada: Check the return value from clk_prepare_enable()
Date: Sat, 22 Jul 2017 17:24:02 -0300
Message-Id: <1500755042-19919-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index ea8f34a..7297223 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -226,7 +226,9 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->clk))
 		return PTR_ERR(pcie->clk);
 
-	clk_prepare_enable(pcie->clk);
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-- 
2.7.4
