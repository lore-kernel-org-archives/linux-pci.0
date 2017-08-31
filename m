Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:16416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750968AbdHaRwn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:43 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 03/10] PCI: armada8k: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:03 -0300
Message-ID: <1504201930-3617-3-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

platform_get_irq() returns a negative number on failure, so
adjust the logic to detect such condition and propagate
the real error value on failure.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index f47e1a0..370d057 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -178,9 +178,9 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	pp->ops = &armada8k_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 0);
-	if (!pp->irq) {
+	if (pp->irq < 0) {
 		dev_err(dev, "failed to get irq for port\n");
-		return -ENODEV;
+		return pp->irq;
 	}
 
 	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
-- 
2.7.4
