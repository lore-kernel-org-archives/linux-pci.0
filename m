Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55306 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeEWKw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 06:52:29 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi failpath
Date: Wed, 23 May 2018 12:52:20 +0200
Message-Id: <20180523105220.25518-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rcar_pcie_enable_msi() creates IRQ mappings using irq_create_mapping()
before requesting the IRQs using devm_request_irq(). If devm_request_irq()
fails for some reason, rcar_pcie_enable_msi() does not remove the mapping.

Pull out the code for disposing IRQ mappings from rcar_pcie_teardown_msi()
into a separate function and call it from both rcar_pcie_teardown_msi()
and rcar_pcie_enable_msi() failpath to remove the mappings correctly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 3aa6fe5f2d64..e738d65c22e9 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -843,6 +843,20 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = rcar_msi_map,
 };
 
+static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+	int i, irq;
+
+	for (i = 0; i < INT_PCI_MSI_NR; i++) {
+		irq = irq_find_mapping(msi->domain, i);
+		if (irq > 0)
+			irq_dispose_mapping(irq);
+	}
+
+	irq_domain_remove(msi->domain);
+}
+
 static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -897,14 +911,13 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	return 0;
 
 err:
-	irq_domain_remove(msi->domain);
+	rcar_pcie_unmap_msi(pcie);
 	return err;
 }
 
 static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
 {
 	struct rcar_msi *msi = &pcie->msi;
-	int irq, i;
 
 	/* Disable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
@@ -914,13 +927,7 @@ static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
 
 	free_pages(msi->pages, 0);
 
-	for (i = 0; i < INT_PCI_MSI_NR; i++) {
-		irq = irq_find_mapping(msi->domain, i);
-		if (irq > 0)
-			irq_dispose_mapping(irq);
-	}
-
-	irq_domain_remove(msi->domain);
+	rcar_pcie_unmap_msi(pcie);
 }
 
 static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
-- 
2.16.2
