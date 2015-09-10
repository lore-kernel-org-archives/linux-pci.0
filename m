Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36153 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbIJXnr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 19:43:47 -0400
Received: by ykdt18 with SMTP id t18so54897816ykd.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 16:43:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] PCI: imx6: Return the real error code
Date: Thu, 10 Sep 2015 20:43:28 -0300
Message-Id: <1441928609-21921-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

When devm_request_irq() fails we should better return the real
error code instead of returning a 'fake' one.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 8f3a981..2d0d0fe 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -539,7 +539,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 				       IRQF_SHARED, "mx6-pcie-msi", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI irq\n");
-			return -ENODEV;
+			return ret;
 		}
 	}
 
-- 
1.9.1

