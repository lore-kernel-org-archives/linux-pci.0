Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:59867 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754727AbeDZOqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 10:46:00 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D6D291E04CE
        for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2018 16:45:58 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v2] PCI: dwc: artpec6: Use devm_ioremap_resource instead of devm_ioremap_resource
Date: Thu, 26 Apr 2018 15:45:55 +0100
Message-Id: <999c344268cf8617b3a48822f30d36f759357cc9.1524753344.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fix aims to replace the use of devm_ioremap() by
devm_ioremap_resource() already discussed on [1].

[1] -> https://lkml.kernel.org/r/20180120001645.GA21343@lenoch

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
Change v1->v2:
 - Changed URL defined on patch description to be as specified in 
Documentation/process/submitting-patches.rst

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
