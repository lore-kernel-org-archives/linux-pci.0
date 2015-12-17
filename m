Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:42408 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S966642AbbLQNXm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 08:23:42 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 4/4] PCI: rcar: Add Gen2 PHY setup to pcie-rcar
Date: Thu, 17 Dec 2015 13:22:37 +0000
Message-Id: <1450358557-28376-5-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For PCIe compliance, the PHY registers need setting as per the
manual.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 02a5993..61e112e 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -103,6 +103,11 @@
 #define H1_PCIEPHYDOUTR		0x040014
 #define H1_PCIEPHYSR		0x040018
 
+/* R-Car Gen2 PHY */
+#define GEN2_PCIEPHYADDR	0x780
+#define GEN2_PCIEPHYDATA	0x784
+#define GEN2_PCIEPHYCTRL	0x78c
+
 #define INT_PCI_MSI_NR	32
 
 #define RCONF(x)	(PCICONF(0)+(x))
@@ -593,6 +598,22 @@ static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
+{
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
@@ -932,9 +953,9 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 
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

