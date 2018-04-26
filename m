Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:59868 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756501AbeDZOq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 10:46:29 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F3D451E04CE
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2018 16:46:27 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v2] PCI: dwc: dra7xx: Use devm_ioremap_resource instead of devm_ioremap_resource
Date: Thu, 26 Apr 2018 15:45:52 +0100
Message-Id: <5e4256e5861326c5ac87db0c333d5f9bb4f4a6ab.1524753363.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fix aims to replace the use of devm_ioremap() by
devm_ioremap_resource() already discussed on [1].

[1] -> https://lkml.kernel.org/r/20180120001645.GA21343@lenoch

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v1->v2:
 - Changed URL defined on patch description to be as specified in 
Documentation/process/submitting-patches.rst

 drivers/pci/dwc/pci-dra7xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index ed8558d..b410bb4 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -406,14 +406,14 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 	ep->ops = &pcie_ep_ops;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
-	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base)
-		return -ENOMEM;
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
-	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base2)
-		return -ENOMEM;
+	pci->dbi_base2 = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base2))
+		return PTR_ERR(pci->dbi_base2);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
@@ -459,9 +459,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
-	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base)
-		return -ENOMEM;
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	pp->ops = &dra7xx_pcie_host_ops;
 
-- 
2.7.4
