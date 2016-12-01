Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49078 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753431AbcLAQ2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2016 11:28:22 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH pci/next] PCI: rcar: Add gen3 fallback compatibility string for pcie-rcar
Date: Thu,  1 Dec 2016 17:28:13 +0100
Message-Id: <1480609693-25746-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add fallback compatibility string for the  R-Car Gen 3 family.  This is in
keeping with the both the existing fallback compatibility string for the
R-Car Gen 2 family and the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 drivers/pci/host/pcie-rcar.c                       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 6cf99690eef9..eee518db90b9 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -7,6 +7,7 @@ compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7793" for the R8A7793 SoC;
 	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
+	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
 
 	    When compatible with the generic version, nodes must list the
 	    SoC-specific version corresponding to the platform first
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 62700d1896f4..962aa3942107 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1077,6 +1077,8 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	  .data = rcar_pcie_hw_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7791",
 	  .data = rcar_pcie_hw_init_gen2 },
+	{ .compatible = "renesas,pcie-rcar-gen3",
+	  .data = rcar_pcie_hw_init_hw_init },
 	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
 	{},
 };
-- 
2.7.0.rc3.207.g0ac5344

