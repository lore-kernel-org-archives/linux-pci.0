Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:13653 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752347AbcAENBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2016 08:01:37 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 4/4] PCI: rcar: Add Gen2 PHY setup to pcie-rcar
Date: Tue,  5 Jan 2016 13:00:31 +0000
Message-Id: <1451998831-27705-5-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For PCIe compliance, the PHY registers need setting as per the
manual.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
  - Added comment about where the PHY settings come from.
---
 drivers/pci/host/pcie-rcar.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 7e13fbb..12be16a 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -104,6 +104,11 @@
 #define H1_PCIEPHYDOUTR		0x040014
 #define H1_PCIEPHYSR		0x040018
 
+/* R-Car Gen2 PHY */
+#define GEN2_PCIEPHYADDR	0x780
+#define GEN2_PCIEPHYDATA	0x784
+#define GEN2_PCIEPHYCTRL	0x78c
+
 #define INT_PCI_MSI_NR	32
 
 #define RCONF(x)	(PCICONF(0)+(x))
@@ -599,6 +604,26 @@ static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
+{
+	/*
+	 * These settings come from the R-Car Series, 2nd Generation User's
+	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
+	 */
+	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
+	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+
+	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
+	/* The following value is for DC connection, no termination resistor */
+	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+
+	return rcar_pcie_hw_init(pcie);
+}
+
 static int rcar_msi_alloc(struct rcar_msi *chip)
 {
 	int msi;
@@ -938,9 +963,9 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 
 static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
-	{ .compatible = "renesas,pcie-rcar-gen2", .data = rcar_pcie_hw_init },
-	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init },
-	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
+	{ .compatible = "renesas,pcie-rcar-gen2", .data = rcar_pcie_hw_init_gen2 },
+	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init_gen2 },
+	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
 	{},
 };
-- 
2.5.0

