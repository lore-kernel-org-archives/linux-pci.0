Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759645AbdJQTZn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 15:25:43 -0400
Date: Tue, 17 Oct 2017 14:25:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 4/4] PCI: dwc: pci-dra7xx: Enable x2 mode support
Message-ID: <20171017192541.GL5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171010101606.15951-1-kishon@ti.com>
 <20171010101606.15951-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010101606.15951-5-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

s/PCI: dwc: pci-dra7xx: Enable x2 mode support/
  PCI: dra7xx: Enable x2 mode support for dra74x and dra76x/

Looks OK to me otherwise, but Rob had a comment about the DT names, so
I'll wait for that resolution.

On Tue, Oct 10, 2017 at 03:46:06PM +0530, Kishon Vijay Abraham I wrote:
> Perform syscon configurations to get x2 mode to working in dra74x
> (and dra76x).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 78a87a8f1362..a43c904310f3 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
> +#include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -83,6 +84,9 @@
>  #define MSI_REQ_GRANT					BIT(0)
>  #define MSI_VECTOR_SHIFT				7
>  
> +#define PCIE_1LANE_2LANE_SELECTION			BIT(13)
> +#define PCIE_B1C0_MODE_SEL				BIT(2)
> +
>  struct dra7xx_pcie {
>  	struct dw_pcie		*pci;
>  	void __iomem		*base;		/* DT ti_conf */
> @@ -95,6 +99,10 @@ struct dra7xx_pcie {
>  
>  struct dra7xx_pcie_of_data {
>  	enum dw_pcie_device_mode mode;
> +	u32 b1co_mode_sel_mask;
> +};
> +
> +struct dra7xx_pcie_data {
>  };
>  
>  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
> @@ -533,6 +541,16 @@ static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
>  	.mode = DW_PCIE_EP_TYPE,
>  };
>  
> +static const struct dra7xx_pcie_of_data dra746_pcie_rc_of_data = {
> +	.b1co_mode_sel_mask = BIT(2),
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct dra7xx_pcie_of_data dra746_pcie_ep_of_data = {
> +	.b1co_mode_sel_mask = BIT(2),
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct of_device_id of_dra7xx_pcie_match[] = {
>  	{
>  		.compatible = "ti,dra7-pcie",
> @@ -544,11 +562,11 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>  	},
>  	{
>  		.compatible = "ti,dra746-pcie-rc",
> -		.data = &dra7xx_pcie_rc_of_data,
> +		.data = &dra746_pcie_rc_of_data,
>  	},
>  	{
>  		.compatible = "ti,dra746-pcie-ep",
> -		.data = &dra7xx_pcie_ep_of_data,
> +		.data = &dra746_pcie_ep_of_data,
>  	},
>  	{
>  		.compatible = "ti,dra726-pcie-rc",
> @@ -603,6 +621,44 @@ static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>  	return ret;
>  }
>  
> +static int dra7xx_pcie_configure_two_lane(struct device *dev,
> +					  u32 b1co_mode_sel_mask)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct regmap *pcie_syscon;
> +	unsigned int pcie_reg;
> +
> +	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "syscon-lane-conf");
> +	if (IS_ERR(pcie_syscon)) {
> +		dev_err(dev, "unable to get syscon-lane-conf\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_index(np, "syscon-lane-conf", 1, &pcie_reg)) {
> +		dev_err(dev, "couldn't get lane configuration reg offset\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(pcie_syscon, pcie_reg, PCIE_1LANE_2LANE_SELECTION,
> +			   PCIE_1LANE_2LANE_SELECTION);
> +
> +	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "syscon-lane-sel");
> +	if (IS_ERR(pcie_syscon)) {
> +		dev_err(dev, "unable to get syscon-lane-sel\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32_index(np, "syscon-lane-sel", 1, &pcie_reg)) {
> +		dev_err(dev, "couldn't get lane selection reg offset\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(pcie_syscon, pcie_reg, b1co_mode_sel_mask,
> +			   PCIE_B1C0_MODE_SEL);
> +
> +	return 0;
> +}
> +
>  static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  {
>  	u32 reg;
> @@ -624,6 +680,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	const struct dra7xx_pcie_of_data *data;
>  	enum dw_pcie_device_mode mode;
> +	u32 b1co_mode_sel_mask;
>  
>  	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
>  	if (!match)
> @@ -631,6 +688,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  
>  	data = (struct dra7xx_pcie_of_data *)match->data;
>  	mode = (enum dw_pcie_device_mode)data->mode;
> +	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
>  
>  	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
>  	if (!dra7xx)
> @@ -689,6 +747,12 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	dra7xx->pci = pci;
>  	dra7xx->phy_count = phy_count;
>  
> +	if (phy_count == 2) {
> +		ret = dra7xx_pcie_configure_two_lane(dev, b1co_mode_sel_mask);
> +		if (ret < 0)
> +			goto err_link;
> +	}
> +
>  	ret = dra7xx_pcie_enable_phy(dra7xx);
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> -- 
> 2.11.0
> 
