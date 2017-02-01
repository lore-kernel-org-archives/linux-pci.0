Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60025 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753003AbdBAR5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2017 12:57:14 -0500
Message-ID: <1485971830.23471.17.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] PCI: imx6: Add code to support i.MX7D
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pci@vger.kernel.org, yurovsky@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 01 Feb 2017 18:57:10 +0100
In-Reply-To: <20170201165559.22436-4-andrew.smirnov@gmail.com>
References: <20170201165559.22436-1-andrew.smirnov@gmail.com>
         <20170201165559.22436-4-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 01.02.2017, 08:55 -0800 schrieb Andrey Smirnov:
> Add various bits of code needed to support i.MX7D variant of the IP.
> 
> Cc: yurovsky@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 136 +++++++++++++++++----
>  include/linux/mfd/syscon/imx7-gpc.h                |  18 +++
>  include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
>  include/linux/mfd/syscon/imx7-src.h                |  18 +++
>  5 files changed, 156 insertions(+), 26 deletions(-)
>  create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
>  create mode 100644 include/linux/mfd/syscon/imx7-src.h
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 83aeb1f..9f57759 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,7 +4,11 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
> +- compatible:
> +	- "fsl,imx6q-pcie"
> +	- "fsl,imx6sx-pcie",
> +	- "fsl,imx6qp-pcie"
> +	- "fsl,imx7d-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 3ef8093..e64ddd9 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -17,6 +17,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> +#include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> +#include <linux/mfd/syscon/imx7-src.h>
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_device.h>
> @@ -27,6 +29,7 @@
>  #include <linux/signal.h>
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
> +#include <linux/pm_domain.h>

I don't think you need this include. PM domain handling should be done
by the linux driver core if the pcie node is placed in the proper
power-domain.

The pcie driver should only indirectly handle pm domains via the runtime
pm kernel facilities.

>  
>  #include "pcie-designware.h"
>  
> @@ -36,6 +39,7 @@ enum imx6_pcie_variants {
>  	IMX6Q,
>  	IMX6SX,
>  	IMX6QP,
> +	IMX7D,
>  };
>  
>  struct imx6_pcie {
> @@ -47,6 +51,7 @@ struct imx6_pcie {
>  	struct clk		*pcie_inbound_axi;
>  	struct clk		*pcie;
>  	struct regmap		*iomuxc_gpr;
> +	struct regmap		*src;
>  	enum imx6_pcie_variants variant;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2_3p5db;
> @@ -56,6 +61,11 @@ struct imx6_pcie {
>  	int			link_gen;
>  };
>  
> +/* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> +#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
> +#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
> +#define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
> +
>  /* PCIe Root Complex registers (memory-mapped) */
>  #define PCIE_RC_LCR				0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
> @@ -251,6 +261,16 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  	u32 val, gpr1, gpr12;
>  
>  	switch (imx6_pcie->variant) {
> +	case IMX7D:
> +		regmap_update_bits(imx6_pcie->src,
> +				   SRC_PCIEPHY_RCR,
> +				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_G_RST,
> +				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_G_RST);
> +		regmap_update_bits(imx6_pcie->src,
> +				   SRC_PCIEPHY_RCR,
> +				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_BTN,
> +				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_BTN);
> +		break;

I suppose those are just some random bits tossed together, that can't
reasonably be abstracted by a reset controller, right? In that case I'm
fine with the code as is.

>  	case IMX6SX:
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> @@ -333,11 +353,33 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  		break;
> +	case IMX7D:
> +		break;
>  	}
>  
>  	return ret;
>  }
>  
[...]

> diff --git a/include/linux/mfd/syscon/imx7-gpc.h b/include/linux/mfd/syscon/imx7-gpc.h
> new file mode 100644
> index 0000000..38e1c9a9
> --- /dev/null
> +++ b/include/linux/mfd/syscon/imx7-gpc.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2017 Impinj
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_IMX7_GPC_H
> +#define __LINUX_IMX7_GPC_H
> +
> +#define GPC_PGC_CPU_MAPPING	0xec
> +#define GPC_PU_PGC_SW_PUP_REQ	0xf8
> +
> +#define IMX7D_PCIE_PHY_A7_DOMAIN	BIT(3)
> +#define IMX7D_PCIE_PHY_SW_PUP_REQ	BIT(1)
> +
> +#endif

This file isn't referenced in the patch anymore. Please remove.

Regards,
Lucas
