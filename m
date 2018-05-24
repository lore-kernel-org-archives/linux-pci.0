Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34980 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033374AbeEXOgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2018 10:36:36 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/6] PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
Date: Thu, 24 May 2018 16:36:21 +0200
Message-Id: <20180524143624.26718-4-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the rcar_pcie_enable() fails and MSIs are enabled, the setup done in
rcar_pcie_enable_msi() is never undone. Add a function to tear down the
MSI setup by disabling the MSI handling in the PCIe block, deallocating
the pages requested for the MSIs and zapping the IRQ mapping.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: No change
V3: No change
V4: Rebase on top of Lorenzo's pci/rcar, fix up the rebase breakage
    induced by patches therein
---
 drivers/pci/host/pcie-rcar.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 6bb1cdec26be..d6a7e8482dcf 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -923,6 +923,28 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
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
@@ -1151,10 +1173,14 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
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
