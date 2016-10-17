Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932335AbcJQKju (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 06:39:50 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: layerscape: Fix drvdata usage before assignment
Date: Mon, 17 Oct 2016 11:39:32 +0100
Message-Id: <1476700772-18745-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit fefe6733e516 ("PCI: layerscape: Move struct pcie_port setup
to probe function") changed the init ordering of the pcie structure,
but started to use the pcie->drvdata field before initializing it.
Mayhem follows.

Fix this by moving the drvdata assignment right before the first use.
Tested on LS2085a.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/host/pci-layerscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 856d428..27602a3 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -270,6 +270,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 
 	pp = &pcie->pp;
 	pp->dev = dev;
+	pcie->drvdata = match->data;
 	pp->ops = pcie->drvdata->ops;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
@@ -279,7 +280,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->pp.dbi_base);
 	}
 
-	pcie->drvdata = match->data;
 	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
 
 	if (!ls_pcie_is_bridge(pcie))
-- 
2.1.4

