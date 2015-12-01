Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42978 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbbLAHZI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 02:25:08 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 3/4] PCI: rcar: Add Gen2 fallback compatibility string
Date: Tue,  1 Dec 2015 16:24:31 +0900
Message-Id: <1448954672-27236-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add fallback compatibility string for R-Car Gen 2 Family.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 13 ++++++++++---
 drivers/pci/host/pcie-rcar.c                       |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 29d3b989d3b0..872cea085be8 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -1,8 +1,15 @@
 * Renesas RCar PCIe interface
 
 Required properties:
-- compatible: should contain one of the following
-	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
+compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
+	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
+	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
+	    "renesas,pcie-gen2" for a generic R-Car Gen2 compatible device.
+
+	    When compatible with the generic version, nodes must list the
+	    SoC-specific version corresponding to the platform first
+	    followed by the generic version.
+
 - reg: base address and length of the pcie controller registers.
 - #address-cells: set to <3>
 - #size-cells: set to <2>
@@ -25,7 +32,7 @@ Example:
 SoC specific DT Entry:
 
 	pcie: pcie@fe000000 {
-		compatible = "renesas,pcie-r8a7791";
+		compatible = "renesas,pcie-r8a7791", "renesas,pcie-gen2";
 		reg = <0 0xfe000000 0 0x80000>;
 		#address-cells = <3>;
 		#size-cells = <2>;
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index f4fa6c537448..17ee0422ddb1 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -917,6 +917,7 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 
 static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
+	{ .compatible = "renesas,pcie-gen2", .data = rcar_pcie_hw_init },
 	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init },
 	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
 	{},
-- 
2.1.4

