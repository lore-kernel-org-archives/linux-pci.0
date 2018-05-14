Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:38457 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbeENRck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 13:32:40 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 412201E073A
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 19:32:39 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 1/2] PCI: dwc: artpec6: Use devm_ioremap_resource instead of devm_ioremap
Date: Mon, 14 May 2018 18:32:34 +0100
Message-Id: <4dc752242caf078dd2ef22adfab6716aa7365684.1526319075.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
References: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
References: <cover.1526319075.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fix aims to replace the use of devm_ioremap() by
devm_ioremap_resource() already discussed on [1].

[1] -> https://lkml.kernel.org/r/20180120001645.GA21343@lenoch

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
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
