Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34545 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbdCTVsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 17:48:22 -0400
Date: Mon, 20 Mar 2017 16:48:19 -0500
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hch@infradead.org, nsekhar@ti.com
Subject: Re: [PATCH v4 14/23] PCI: dwc: dra7xx: Workaround for errata id i870
Message-ID: <20170320214819.5azzdbgncfemhujo@rob-hp-laptop>
References: <20170313142259.25397-1-kishon@ti.com>
 <20170313142259.25397-15-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170313142259.25397-15-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 07:52:50PM +0530, Kishon Vijay Abraham I wrote:
> According to errata i870, access to the PCIe slave port
> that are not 32-bit aligned will result in incorrect mapping
> to TLP Address and Byte enable fields.
> 
> Accessing non 32-bit aligned data causes incorrect data in the target
> buffer if memcpy is used. Implement the workaround for this
> errata here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 35c18534469c..147d37a7fe58 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -26,6 +26,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/resource.h>
>  #include <linux/types.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -528,6 +530,51 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>  	{},
>  };
>  
> +/*
> + * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
> + * @dra7xx: the dra7xx device where the workaround should be applied
> + *
> + * Access to the PCIe slave port that are not 32-bit aligned will result
> + * in incorrect mapping to TLP Address and Byte enable fields. Therefore,
> + * byte and half-word accesses are not possible to byte offset 0x1, 0x2, or
> + * 0x3.
> + *
> + * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
> + */
> +static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
> +{
> +	int ret;
> +	struct device_node *np = dev->of_node;
> +	struct regmap *regmap;
> +	unsigned int reg;
> +	unsigned int field;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(np,
> +						 "ti,syscon-unaligned-access");
> +	if (IS_ERR(regmap)) {
> +		dev_dbg(dev, "can't get ti,syscon-unaligned-access\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_index(np, "ti,syscon-unaligned-access", 1,
> +				       &reg)) {
> +		dev_err(dev, "couldn't get legacy mode register offset\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_index(np, "ti,syscon-unaligned-access", 2,
> +				       &field)) {
> +		dev_err(dev, "can't get bit field for setting legacy mode\n");
> +		return -EINVAL;
> +	}

If this remains, it's screaming for a helper function. 
of_parse_phandle_with_args already exists, but maybe a syscon specific 
function is in order.

> +
> +	ret = regmap_update_bits(regmap, reg, field, field);
> +	if (ret)
> +		dev_err(dev, "failed to enable unaligned access\n");
> +
> +	return ret;
> +}
> +
>  static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  {
>  	u32 reg;
> @@ -637,6 +684,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	case DW_PCIE_RC_TYPE:
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_RC);
> +

Unnecessary WS change.

>  		ret = dra7xx_add_pcie_port(dra7xx, pdev);
>  		if (ret < 0)
>  			goto err_gpio;
> @@ -644,6 +692,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	case DW_PCIE_EP_TYPE:
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_EP);
> +
> +		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
> +		if (ret)
> +			goto err_gpio;
> +
>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>  		if (ret < 0)
>  			goto err_gpio;
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
