Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938836AbcJGQWb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:22:31 -0400
Subject: [PATCH 05/10] PCI: altera: Remove redundant platform_get_resource()
 return value check
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:22:27 -0500
Message-ID: <20161007162226.22796.41217.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 5362ac1..d2c7f55 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -78,7 +78,7 @@
 
 struct altera_pcie {
 	struct platform_device	*pdev;
-	void __iomem		*cra_base;
+	void __iomem		*cra_base;	/* DT Cra */
 	int			irq;
 	u8			root_bus_nr;
 	struct irq_domain	*irq_domain;
@@ -547,11 +547,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *altera)
 	struct platform_device *pdev = altera->pdev;
 
 	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
-	if (!cra) {
-		dev_err(&pdev->dev, "no Cra memory resource defined\n");
-		return -ENODEV;
-	}
-
 	altera->cra_base = devm_ioremap_resource(&pdev->dev, cra);
 	if (IS_ERR(altera->cra_base)) {
 		dev_err(&pdev->dev, "failed to map cra memory\n");

