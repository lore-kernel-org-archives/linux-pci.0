Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17037 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaKFBLL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Nov 2014 20:11:11 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEL00A8IFAMEF30@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 06 Nov 2014 10:11:10 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: dra7xx: Add dra7xx prefix before add_pcie_port
Date: Thu, 06 Nov 2014 10:11:44 +0900
Message-id: <001301cff95e$a124f6b0$e36ee410$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The add_pcie_port function is dra7xx-specific. Add exynos prefix
to avoid collision in global name space.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pci-dra7xx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 52b34fe..5b4a644 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -270,8 +270,8 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int add_pcie_port(struct dra7xx_pcie *dra7xx,
-			  struct platform_device *pdev)
+static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
+				struct platform_device *pdev)
 {
 	int ret;
 	struct pcie_port *pp;
@@ -398,7 +398,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dra7xx);
 
-	ret = add_pcie_port(dra7xx, pdev);
+	ret = dra7xx_add_pcie_port(dra7xx, pdev);
 	if (ret < 0)
 		goto err_add_port;
 
-- 
1.7.9.5


