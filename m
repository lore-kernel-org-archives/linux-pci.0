Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755354AbcJLMrc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:32 -0400
Subject: [PATCH v2 3/6] PCI: altera: Remove redundant
 platform_get_resource() return value check
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:47:23 -0500
Message-ID: <20161012124723.23240.29896.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_ioremap_resource() fails gracefully when given a NULL resource
pointer, so we don't need to check separately for failure from
platform_get_resource_byname().  Remove the redundant check.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index b26695c..931c51e 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -74,7 +74,7 @@
 
 struct altera_pcie {
 	struct platform_device	*pdev;
-	void __iomem		*cra_base;
+	void __iomem		*cra_base;	/* DT Cra */
 	int			irq;
 	u8			root_bus_nr;
 	struct irq_domain	*irq_domain;
@@ -555,11 +555,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	struct resource *cra;
 
 	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
-	if (!cra) {
-		dev_err(dev, "no Cra memory resource defined\n");
-		return -ENODEV;
-	}
-
 	pcie->cra_base = devm_ioremap_resource(dev, cra);
 	if (IS_ERR(pcie->cra_base)) {
 		dev_err(dev, "failed to map cra memory\n");

