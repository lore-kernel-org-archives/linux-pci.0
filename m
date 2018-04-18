Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43228 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeDRIGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Apr 2018 04:06:36 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH] PCI: dwc: artpec6: Use devm_ioremap_resource instead of devm_ioremap_resource
Date: Wed, 18 Apr 2018 09:06:33 +0100
Message-Id: <828d8a53d85be073672fec67ee6980818dc459ab.1524038460.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fix aims to replace the use of devm_ioremap() by
devm_ioremap_resource() already discussed on [1].

[1] -> https://patchwork.kernel.org/patch/10173831/

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/dwc/pcie-artpec6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index e66cede..321b56c 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -463,9 +463,9 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
 	ep->ops = &pcie_ep_ops;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
-	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base2)
-		return -ENOMEM;
+	pci->dbi_base2 = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base2))
+		return PTR_ERR(pci->dbi_base2);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
-- 
2.7.4
