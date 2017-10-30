Return-Path: <linux-kernel-owner@vger.kernel.org>
To: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] PCI: rcar: Use common error handling code in
 rcar_pcie_enable_msi()
Message-ID: <c598933b-b14f-91a1-c7a3-f4a46ec98e77@users.sourceforge.net>
Date: Mon, 30 Oct 2017 08:35:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 30 Oct 2017 08:28:06 +0100

Adjust a jump target so that a specific error message is stored only once
at the end of this function implementation.
Replace two calls of the function "dev_err" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pci/host/pcie-rcar.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 12796eccb2be..38101f8bebf1 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -873,18 +873,14 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto err;
-	}
+	if (err < 0)
+		goto report_request_failure;
 
 	err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto err;
-	}
+	if (err < 0)
+		goto report_request_failure;
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
@@ -898,7 +894,8 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	return 0;
 
-err:
+report_request_failure:
+	dev_err(dev, "failed to request IRQ: %d\n", err);
 	irq_domain_remove(msi->domain);
 	return err;
 }
-- 
2.14.3
