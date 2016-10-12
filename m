Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933757AbcJLNdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:33:37 -0400
Subject: [PATCH v2 6/7] PCI: dra7xx: Move struct pcie_port setup to probe
 function
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Wed, 12 Oct 2016 08:33:22 -0500
Message-ID: <20161012133322.27714.21257.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Do the basic pcie_port setup in the probe function for consistency with
other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index efb24b8..bb77c35 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -267,13 +267,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
 	int ret;
-	struct pcie_port *pp;
+	struct pcie_port *pp = &dra7xx->pp;
+	struct device *dev = pp->dev;
 	struct resource *res;
-	struct device *dev = &pdev->dev;
-
-	pp = &dra7xx->pp;
-	pp->dev = dev;
-	pp->ops = &dra7xx_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
@@ -320,6 +316,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct resource *res;
 	struct dra7xx_pcie *dra7xx;
+	struct pcie_port *pp;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	char name[10];
@@ -331,6 +328,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!dra7xx)
 		return -ENOMEM;
 
+	pp = &dra7xx->pp;
+	pp->dev = dev;
+	pp->ops = &dra7xx_pcie_host_ops;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");

