Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941091AbcJGQfF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:35:05 -0400
Subject: [PATCH 8/9] PCI: dra7xx: Move struct pcie_port setup to probe
 function
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Fri, 07 Oct 2016 11:35:01 -0500
Message-ID: <20161007163501.24926.55838.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 87c89178..b0d427c 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -266,15 +266,11 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct pcie_port *pp;
+	struct pcie_port *pp = &dra7xx->pp;
+	struct device *dev = pp->dev;
 	struct resource *res;
 	int ret;
 
-	pp = &dra7xx->pp;
-	pp->dev = dev;
-	pp->ops = &dra7xx_pcie_host_ops;
-
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
@@ -314,6 +310,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct dra7xx_pcie *dra7xx;
+	struct pcie_port *pp;
 	u32 reg;
 	int ret;
 	int irq;
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

