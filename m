Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33659 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeDFLIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Apr 2018 07:08:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73so1399765wrb.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Apr 2018 04:08:22 -0700 (PDT)
Subject: [PATCH 3/4] pcie-rcar: add R-Car gen3 PHY support
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
Message-ID: <d8dde257-814f-142c-d58b-91eaf78a7d10@cogentembedded.com>
Date: Fri, 6 Apr 2018 14:08:12 +0300
MIME-Version: 1.0
In-Reply-To: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
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
 drivers/pci/host/pcie-rcar.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

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
 
