Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33715 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbbDITt2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 15:49:28 -0400
Received: by oblw8 with SMTP id w8so148350523obl.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 12:49:27 -0700 (PDT)
Subject: [PATCH] PCI: layerscape: Simplify platform_get_resource_byname()
 failure checking
To: Minghuan Lian <minghuan.Lian@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 09 Apr 2015 14:49:23 -0500
Message-ID: <20150409194923.19293.96454.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_ioremap_resource() validates the resource it receives, so if we check
for devm_ioremap_resource() failure, we need not check for failure of the
preceding platform_get_resource().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 68c9e5e9b0a8..4a6e62f67579 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -127,14 +127,11 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	pcie->dev = &pdev->dev;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	if (!dbi_base) {
-		dev_err(&pdev->dev, "missing *regs* space\n");
-		return -ENODEV;
-	}
-
 	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
-	if (IS_ERR(pcie->dbi))
+	if (IS_ERR(pcie->dbi)) {
+		dev_err(&pdev->dev, "missing *regs* space\n");
 		return PTR_ERR(pcie->dbi);
+	}
 
 	pcie->scfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						     "fsl,pcie-scfg");

