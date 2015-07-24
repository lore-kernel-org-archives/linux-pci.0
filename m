Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34357 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbGXFaB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 01:30:01 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
	linux-omap@vger.kernel.org
Subject: [PATCH 2/4] PCI: dra7xx: Mark the msi cascade handler IRQF_NO_THREAD
Date: Fri, 24 Jul 2015 13:29:34 +0800
Message-Id: <1437715776-2243-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The cascade handler must run in hard interrupt context, otherwise
it will cause dead lock if we force threading of all the interrupt
handlers via kernel command parameter "threadirqs".

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/pci/host/pci-dra7xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 80db09e47800..66aa9286cfc8 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -284,7 +284,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	}
 
 	ret = devm_request_irq(&pdev->dev, pp->irq,
-			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
+			       dra7xx_pcie_msi_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "dra7-pcie-msi",	pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-- 
2.1.0

