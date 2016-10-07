Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941341AbcJGQmm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:42:42 -0400
Subject: [PATCH 6/7] PCI: layerscape: Move struct pcie_port setup to probe
 function
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:42:33 -0500
Message-ID: <20161007164233.26341.56205.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Do the basic pcie_port setup in the probe function for consistency with
other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index bf1ce11..9b74485 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -218,9 +218,6 @@ static int __init ls_add_pcie_port(struct ls_pcie *ls,
 	struct pcie_port *pp = &ls->pp;
 	int ret;
 
-	pp->dev = &pdev->dev;
-	pp->ops = ls->drvdata->ops;
-
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(pp->dev, "failed to initialize host\n");
@@ -235,6 +232,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 	struct ls_pcie *ls;
+	struct pcie_port *pp;
 	struct resource *dbi_base;
 	int ret;
 
@@ -246,6 +244,12 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!ls)
 		return -ENOMEM;
 
+	ls->drvdata = match->data;
+
+	pp = &ls->pp;
+	pp->dev = dev;
+	pp->ops = ls->drvdata->ops;
+
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	ls->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(ls->pp.dbi_base)) {
@@ -253,7 +257,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(ls->pp.dbi_base);
 	}
 
-	ls->drvdata = match->data;
 	ls->lut = ls->pp.dbi_base + ls->drvdata->lut_offset;
 
 	if (!ls_pcie_is_bridge(ls))
@@ -264,7 +267,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, ls);
-
 	return 0;
 }
 

