Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42978 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbbLAHZF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 02:25:05 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 1/4] PCI: rcar-gen2: Add generic compatibility string
Date: Tue,  1 Dec 2015 16:24:29 +0900
Message-Id: <1448954672-27236-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add fallback compatibility string for R-Car Gen 2 Family.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 11 +++++++++--
 drivers/pci/host/pci-rcar-gen2.c                        |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 891463cb09c2..b19be08a8113 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -8,7 +8,14 @@ OHCI and EHCI controllers.
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
-	      "renesas,pci-r8a7794" for the R8A7794 SoC.
+	      "renesas,pci-r8a7794" for the R8A7794 SoC;
+	      "renesas,pci-gen2" for a generic R-Car Gen2 compatible device.
+
+
+	      When compatible with the generic version, nodes must list the
+	      SoC-specific version corresponding to the platform first
+	      followed by the generic version.
+
 - reg:	A list of physical regions to access the device: the first is
 	the operational registers for the OHCI/EHCI controllers and the
 	second is for the bridge configuration and control registers.
@@ -32,7 +39,7 @@ Optional properties:
 Example SoC configuration:
 
 	pci0: pci@ee090000  {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-gen2";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		reg = <0x0 0xee090000 0x0 0xc00>,
 		      <0x0 0xee080000 0x0 0x1100>;
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 62951165dcbb..a93403823353 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -430,6 +430,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 }
 
 static struct of_device_id rcar_pci_of_match[] = {
+	{ .compatible = "renesas,pci-gen2", },
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
-- 
2.1.4

