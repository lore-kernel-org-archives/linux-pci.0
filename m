Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51848 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeEUNLo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 09:11:44 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 4/4] PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
Date: Mon, 21 May 2018 15:11:23 +0200
Message-Id: <20180521131123.2009-4-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the rcar_pcie_enable() fails and MSIs are enabled, the setup done in
rcar_pcie_enable_msi() is never undone. Add a function to tear down the
MSI setup by disabling the MSI handling in the PCIe block, deallocating
the pages requested for the MSIs and zapping the IRQ mapping.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 3cc84f7e05f7..5c365f743df5 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -900,6 +900,28 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	return err;
 }
 
+static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+	int irq, i;
+
+	/* Disable all MSI interrupts */
+	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
+
+	/* Disable address decoding of the MSI interrupt, MSIFE */
+	rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
+
+	free_pages(msi->pages, 0);
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
 static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1156,10 +1178,14 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_pcie_enable(pcie);
 	if (err)
-		goto err_clk_disable;
+		goto err_msi_teardown;
 
 	return 0;
 
+err_msi_teardown:
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rcar_pcie_teardown_msi(pcie);
+
 err_clk_disable:
 	clk_disable_unprepare(pcie->bus_clk);
 
-- 
2.16.2
