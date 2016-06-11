Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jun 2016 14:10:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: niklass@axis.com, jespern@axis.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux-arm-kernel@axis.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: add DT binding for Axis
 ARTPEC-6 PCIe controller
Message-ID: <20160611191033.GL16462@localhost>
References: <1462794507-30262-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462794507-30262-1-git-send-email-niklass@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 09, 2016 at 01:48:27PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> This commit adds the Device Tree binding documentation that allows to
> describe the PCIe controller found in the Axis ARTPEC-6 SoC.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

I applied both of these, with Rob's ack on the first, to
pci/host-artpec for v4.8, thanks!

I made the following minor edits; hopefully I didn't break anything:

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
index f91b916..330a45b 100644
--- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
@@ -1,11 +1,11 @@
 * Axis ARTPEC-6 PCIe interface
 
-This PCIe host controller is based on the Synopsys Designware PCIe IP
+This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
 - compatible: "axis,artpec6-pcie", "snps,dw-pcie"
-- reg: base addresses and lengths of the pcie controller (DBI),
+- reg: base addresses and lengths of the PCIe controller (DBI),
 	the phy controller, and configuration address space.
 - reg-names: Must include the following entries:
 	- "dbi"
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1a2de8f..033d9ad 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -250,5 +250,8 @@ config PCIE_ARTPEC6
 	depends on MACH_ARTPEC6
 	select PCIE_DW
 	select PCIEPORTBUS
+	help
+	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
+	  SoCs.  This PCIe controller uses the DesignWare core.
 
 endmenu
diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index d53dbaf..19adc77 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -61,7 +61,7 @@ struct artpec6_pcie {
 #define PHY_STATUS			0x118
 #define PHY_COSPLLLOCK			(1 << 0)
 
-#define ARTPEC6_CPU_TO_BUS_ADDR		0x0FFFFFFF
+#define ARTPEC6_CPU_TO_BUS_ADDR		0x0fffffff
 
 static int artpec6_pcie_establish_link(struct pcie_port *pp)
 {
@@ -241,35 +241,26 @@ static int __init artpec6_pcie_probe(struct platform_device *pdev)
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
-	if (IS_ERR(pp->dbi_base)) {
-		ret = PTR_ERR(pp->dbi_base);
-		goto fail;
-	}
+	if (IS_ERR(pp->dbi_base))
+		return PTR_ERR(pp->dbi_base);
 
 	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
 	artpec6_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
-	if (IS_ERR(artpec6_pcie->phy_base)) {
-		ret = PTR_ERR(artpec6_pcie->phy_base);
-		goto fail;
-	}
+	if (IS_ERR(artpec6_pcie->phy_base))
+		return PTR_ERR(artpec6_pcie->phy_base);
 
 	artpec6_pcie->regmap =
 		syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						"axis,syscon-pcie");
-	if (IS_ERR(artpec6_pcie->regmap)) {
-		ret = PTR_ERR(artpec6_pcie->regmap);
-		goto fail;
-	}
+	if (IS_ERR(artpec6_pcie->regmap))
+		return PTR_ERR(artpec6_pcie->regmap);
 
 	ret = artpec6_add_pcie_port(pp, pdev);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	platform_set_drvdata(pdev, artpec6_pcie);
 	return 0;
-
-fail:
-	return ret;
 }
 
 static const struct of_device_id artpec6_pcie_of_match[] = {
