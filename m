Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:6943
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751405AbdHaRwp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:45 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 05/10] PCI: spear13xx: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:05 -0300
Message-ID: <1504201930-3617-5-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns a negative number on failure, so
adjust the logic to detect such condition and propagate
the real error value on failure.

Cc: Pratyush Anand <pratyush.anand@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pcie-spear13xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
index 52000bc..709189d 100644
--- a/drivers/pci/dwc/pcie-spear13xx.c
+++ b/drivers/pci/dwc/pcie-spear13xx.c
@@ -201,9 +201,9 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 0);
-	if (!pp->irq) {
+	if (pp->irq < 0) {
 		dev_err(dev, "failed to get irq\n");
-		return -ENODEV;
+		return pp->irq;
 	}
 	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-- 
2.7.4
