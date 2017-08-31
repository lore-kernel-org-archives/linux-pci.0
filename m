Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:23168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751375AbdHaRwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:41 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/10] PCI: dra7xx: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:02 -0300
Message-ID: <1504201930-3617-2-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error
value instead of always returning -EINVAL.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index e0dd98d..1e2aaed 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -450,7 +450,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
-		return -EINVAL;
+		return pp->irq;
 	}
 
 	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
-- 
2.7.4
