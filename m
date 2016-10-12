Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754902AbcJLN6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:58:46 -0400
Subject: [PATCH v2 5/7] PCI: layerscape: Move struct pcie_port setup to
 probe function
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:58:02 -0500
Message-ID: <20161012135802.29815.48363.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Do the basic pcie_port setup in the probe function for consistency with
other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 2b31296..2d77104 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -216,13 +216,10 @@ static const struct of_device_id ls_pcie_of_match[] = {
 static int __init ls_add_pcie_port(struct ls_pcie *pcie,
 				   struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct pcie_port *pp = &pcie->pp;
+	struct device *dev = pp->dev;
 	int ret;
 
-	pp->dev = dev;
-	pp->ops = pcie->drvdata->ops;
-
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -237,6 +234,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 	struct ls_pcie *pcie;
+	struct pcie_port *pp;
 	struct resource *dbi_base;
 	int ret;
 
@@ -248,6 +246,10 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pp = &pcie->pp;
+	pp->dev = dev;
+	pp->ops = pcie->drvdata->ops;
+
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
 	if (IS_ERR(pcie->pp.dbi_base)) {

