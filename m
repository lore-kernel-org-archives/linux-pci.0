Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Subject: [PATCH v2 3/3] PCI: pcie-rcar: Add support for R-Car H3.
Date: Wed, 25 Nov 2015 15:30:39 +0000
Message-Id: <1448465439-2132-4-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
References: <1448465439-2132-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>

R-Car H3 device is r8a7795

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2: No changes
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
 drivers/pci/host/pcie-rcar.c                       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 29d3b98..ab2e75f 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -2,7 +2,8 @@
 
 Required properties:
 - compatible: should contain one of the following
-	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
+	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791",
+	"renesas,pcie-r8a7795"
 - reg: base address and length of the pcie controller registers.
 - #address-cells: set to <3>
 - #size-cells: set to <2>
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index d12faf4..0c819a00 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -917,6 +917,7 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
 	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init },
 	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
+	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
-- 
2.5.0

