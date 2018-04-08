Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54489 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeDHSFO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 14:05:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id r191so13355342wmg.4
        for <linux-pci@vger.kernel.org>; Sun, 08 Apr 2018 11:05:13 -0700 (PDT)
Subject: [PATCH v2 3/5] pcie-rcar: add R-Car gen3 PHY support
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Message-ID: <3eb7e548-8b21-2347-c742-a007fd9cfed9@cogentembedded.com>
Date: Sun, 8 Apr 2018 21:05:10 +0300
MIME-Version: 1.0
In-Reply-To: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On R-Car gen3 SoCs the PCIe PHY has its own register region -- and I have
written  a generic PHY driver for it, thus we need to add the corresponding
code in  rcar_pcie_hw_init_gen3() and call devm_phy_optional_get() at the
driver's probing time,  so that the existing R-Car gen3 device trees (not
having a PHY node) would still work (we only need  to power up the PHY on
R-Car V3H).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- updated the bindings.

 Documentation/devicetree/bindings/pci/rcar-pci.txt |    5 +++
 drivers/pci/host/pcie-rcar.c                       |   27 +++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

Index: pci/Documentation/devicetree/bindings/pci/rcar-pci.txt
===================================================================
--- pci.orig/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ pci/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -32,6 +32,11 @@ compatible: "renesas,pcie-r8a7743" for t
 	and PCIe bus clocks.
 - clock-names: from common clock binding: should be "pcie" and "pcie_bus".
 
+Optional properties:
+- phys: from common PHY binding: PHY phandle and specifier (only make sense
+	for R-Car gen3 SoCs where the PCIe PHYs have their own register blocks).
+- phy-names: from common PHY binding: should be "pcie".
+
 Example:
 
 SoC-specific DT Entry:
Index: pci/drivers/pci/host/pcie-rcar.c
===================================================================
--- pci.orig/drivers/pci/host/pcie-rcar.c
+++ pci/drivers/pci/host/pcie-rcar.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -140,6 +141,7 @@ static inline struct rcar_msi *to_rcar_m
 /* Structure representing the PCIe interface */
 struct rcar_pcie {
 	struct device		*dev;
+	struct phy		*phy;
 	void __iomem		*base;
 	struct list_head	resources;
 	int			root_bus_nr;
@@ -667,6 +669,21 @@ static int rcar_pcie_hw_init_gen2(struct
 	return rcar_pcie_hw_init(pcie);
 }
 
+static int rcar_pcie_hw_init_gen3(struct rcar_pcie *pcie)
+{
+	int err;
+
+	err = phy_init(pcie->phy);
+	if (err)
+		return err;
+
+	err = phy_power_on(pcie->phy);
+	if (err)
+		return err;
+
+	return rcar_pcie_hw_init(pcie);
+}
+
 static int rcar_msi_alloc(struct rcar_msi *chip)
 {
 	int msi;
@@ -916,6 +933,10 @@ static int rcar_pcie_get_resources(struc
 	struct resource res;
 	int err, i;
 
+	pcie->phy = devm_phy_optional_get(dev, "pcie");
+	if (IS_ERR(pcie->phy))
+		return PTR_ERR(pcie->phy);
+
 	err = of_address_to_resource(dev->of_node, 0, &res);
 	if (err)
 		return err;
@@ -1068,8 +1089,10 @@ static const struct of_device_id rcar_pc
 	  .data = rcar_pcie_hw_init_gen2 },
 	{ .compatible = "renesas,pcie-rcar-gen2",
 	  .data = rcar_pcie_hw_init_gen2 },
-	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
-	{ .compatible = "renesas,pcie-rcar-gen3", .data = rcar_pcie_hw_init },
+	{ .compatible = "renesas,pcie-r8a7795",
+	  .data = rcar_pcie_hw_init_gen3 },
+	{ .compatible = "renesas,pcie-rcar-gen3",
+	  .data = rcar_pcie_hw_init_gen3 },
 	{},
 };
 
