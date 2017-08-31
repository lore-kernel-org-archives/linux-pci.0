Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:25824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751405AbdHaRwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:49 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 08/10] PCI: altera: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:08 -0300
Message-ID: <1504201930-3617-8-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns a negative number on failure, so
adjust the logic to detect such condition and propagate
the real error value on failure.

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pcie-altera.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 6fced59..b468b8ccc 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -558,9 +558,9 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq <= 0) {
+	if (pcie->irq < 0) {
 		dev_err(dev, "failed to get IRQ: %d\n", pcie->irq);
-		return -EINVAL;
+		return pcie->irq;
 	}
 
 	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
-- 
2.7.4
