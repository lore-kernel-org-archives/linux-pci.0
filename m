Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932853AbcJLNSv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:18:51 -0400
Subject: [PATCH v2 08/10] PCI: designware-plat: Remove redundant
 dw_plat_pcie.mem_base
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:18:47 -0500
Message-ID: <20161012131847.26443.52325.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the struct dw_plat_pcie.mem_base member, which is only used as a
temporary.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware-plat.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
index 17da005..d9d01e7 100644
--- a/drivers/pci/host/pcie-designware-plat.c
+++ b/drivers/pci/host/pcie-designware-plat.c
@@ -25,8 +25,7 @@
 #include "pcie-designware.h"
 
 struct dw_plat_pcie {
-	void __iomem		*mem_base;
-	struct pcie_port	pp;
+	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
 };
 
 static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
@@ -100,11 +99,9 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	pp->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dw_plat_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dw_plat_pcie->mem_base))
-		return PTR_ERR(dw_plat_pcie->mem_base);
-
-	pp->dbi_base = dw_plat_pcie->mem_base;
+	pp->dbi_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pp->dbi_base))
+		return PTR_ERR(pp->dbi_base);
 
 	ret = dw_plat_add_pcie_port(pp, pdev);
 	if (ret < 0)

