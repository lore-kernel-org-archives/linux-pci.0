Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] PCI: rcar: Consolidate register space lookup and ioremap
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 22 Aug 2016 14:27:28 -0500
Message-ID: <20160822192728.5055.58901.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move the devm_ioremap_resource() of R-Car register space next to the
of_address_to_resource() that extracts the resource.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 65db7a2..e58bbbc 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -775,6 +775,10 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	if (err)
 		return err;
 
+	pcie->base = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(pcie->base))
+		return PTR_ERR(pcie->base);
+
 	pcie->clk = devm_clk_get(&pdev->dev, "pcie");
 	if (IS_ERR(pcie->clk)) {
 		dev_err(pcie->dev, "cannot get platform clock\n");
@@ -810,12 +814,6 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
 	}
 	pcie->msi.irq2 = i;
 
-	pcie->base = devm_ioremap_resource(&pdev->dev, &res);
-	if (IS_ERR(pcie->base)) {
-		err = PTR_ERR(pcie->base);
-		goto err_map_reg;
-	}
-
 	return 0;
 
 err_map_reg:
