Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1484844727.24339.50.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] PCI: imx6: Add code to support i.MX7D
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 19 Jan 2017 17:52:07 +0100
In-Reply-To: <20170119163631.10668-4-andrew.smirnov@gmail.com>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
 <20170119163631.10668-4-andrew.smirnov@gmail.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, yurovsky@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 19.01.2017, 08:36 -0800 schrieb Andrey Smirnov:
> Add various bits of code needed to support i.MX7D variant of the IP.
> 
> Cc: yurovsky@gmail.com
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 188 ++++++++++++++++++---
>  include/linux/mfd/syscon/imx7-gpc.h                |  18 ++
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  include/linux/mfd/syscon/imx7-src.h                |  18 ++
>  5 files changed, 208 insertions(+), 26 deletions(-)
>  create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
>  create mode 100644 include/linux/mfd/syscon/imx7-src.h
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 83aeb1f..20b9382 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
> +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie",
> +  	      "fsl,imx6qp-pcie", "fsl,imx7d-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -34,6 +35,9 @@ Additional required properties for imx6sx-pcie:
>  - clock names: Must include the following additional entries:
>  	- "pcie_inbound_axi"
>  
> +Additional required properties for imx7d-pcie:
> +- pcie-phy-supply: Should specify the regulator supplying PCIe PHY
> +
This isn't a PHY regulator, but a regulator powering the GPC domain
where the PHY is located. This should not be handled in the PCIe driver.
See the previous discussion with i.MX6SX, that is in the same boat.

[...]
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
> -	if (imx6_pcie->variant == IMX6SX)
> +	switch (imx6_pcie->variant) {
> +	case IMX7D: {
> +		int ret;
> +		unsigned int reg, mapping;
> +		struct pcie_port *pp = &imx6_pcie->pp;
> +		struct device *dev = pp->dev;
> +
> +		regulator_set_voltage(imx6_pcie->pcie_phy_regulator,
> +				      1000000, 1000000);
> +		ret = regulator_enable(imx6_pcie->pcie_phy_regulator);
> +		if (ret) {
> +			dev_err(dev, "failed to enable pcie regulator.\n");
> +			return;
> +		}
> +
> +		/*
> +		 * Now that PHY regulator is enabled, do sofware
> +		 * power-up request by mapping PHY in A7 domain and
> +		 * setting power-up request bit
> +		 */
> +		regmap_read(imx6_pcie->gpc, GPC_PGC_CPU_MAPPING, &mapping);
> +		regmap_write(imx6_pcie->gpc, GPC_PGC_CPU_MAPPING,
> +			     mapping | IMX7D_PCIE_PHY_A7_DOMAIN);
> +
> +		regmap_update_bits(imx6_pcie->gpc, GPC_PU_PGC_SW_PUP_REQ,
> +				   IMX7D_PCIE_PHY_SW_PUP_REQ,
> +				   IMX7D_PCIE_PHY_SW_PUP_REQ);
> +		/*
> +		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +		 * for PUP_REQ bit to be cleared
> +		 */
> +		while (!regmap_read(imx6_pcie->gpc,
> +				    GPC_PU_PGC_SW_PUP_REQ, &reg) &&
> +		       reg & IMX7D_PCIE_PHY_SW_PUP_REQ)
> +			;
> +		regmap_write(imx6_pcie->gpc, GPC_PGC_CPU_MAPPING, mapping);

I won't allow code touching the GPC registers to sneak into the PCIe
driver. I know this is the downstream solution, but this really needs a
proper GPC power domain driver, instead of this hack.

Regards,
Lucas


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
