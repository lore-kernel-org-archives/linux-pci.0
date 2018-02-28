Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: dra7xx: Enable x2 mode support for dra74x,
 dra76x and dra72x
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20171219085823.8695-1-kishon@ti.com>
 <20171219085823.8695-4-kishon@ti.com>
 <20180226103058.GB19841@e107981-ln.cambridge.arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ad8c490f-2691-6c58-96a1-59788b88fc84@ti.com>
Date: Wed, 28 Feb 2018 17:34:34 +0530
MIME-Version: 1.0
In-Reply-To: <20180226103058.GB19841@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Monday 26 February 2018 04:00 PM, Lorenzo Pieralisi wrote:
> On Tue, Dec 19, 2017 at 02:28:23PM +0530, Kishon Vijay Abraham I wrote:
>> dra74x/dra76x and dra72x has separate compatible strings. Add support
> 
> s/has/have
> 
>> for these compatible strings in pci-dra7xx driver to perform syscon
>> configurations required to get x2 mode working.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index e77a4ceed74c..3b4427c10228 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -83,11 +83,15 @@
>>  #define MSI_REQ_GRANT					BIT(0)
>>  #define MSI_VECTOR_SHIFT				7
>>  
>> +#define PCIE_1LANE_2LANE_SELECTION			BIT(13)
>> +#define PCIE_B1C0_MODE_SEL				BIT(2)
>> +
>>  struct dra7xx_pcie {
>>  	struct dw_pcie		*pci;
>>  	void __iomem		*base;		/* DT ti_conf */
>>  	int			phy_count;	/* DT phy-names count */
>>  	struct phy		**phy;
>> +	u32			*b1c0_mask;
> 
> This looks unused in the current patch.

yeah, I'll remove it while sending the next revision.
> 
>>  	int			link_gen;
>>  	struct irq_domain	*irq_domain;
>>  	enum dw_pcie_device_mode mode;
>> @@ -95,6 +99,7 @@ struct dra7xx_pcie {
>>  
>>  struct dra7xx_pcie_of_data {
>>  	enum dw_pcie_device_mode mode;
>> +	u32 b1co_mode_sel_mask;
>>  };
>>  
>>  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
>> @@ -533,6 +538,26 @@ static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
>>  	.mode = DW_PCIE_EP_TYPE,
>>  };
>>  
>> +static const struct dra7xx_pcie_of_data dra746_pcie_rc_of_data = {
>> +	.b1co_mode_sel_mask = BIT(2),
> 
> Nit: DT guys are more familiar than me on how this data should be
> encoded but maybe bit offset + length can be better ? I do not know, I
> have no problem leaving them as masks.
> 
>> +	.mode = DW_PCIE_RC_TYPE,
>> +};
>> +
>> +static const struct dra7xx_pcie_of_data dra726_pcie_rc_of_data = {
>> +	.b1co_mode_sel_mask = GENMASK(3, 2),
>> +	.mode = DW_PCIE_RC_TYPE,
>> +};
>> +
>> +static const struct dra7xx_pcie_of_data dra746_pcie_ep_of_data = {
>> +	.b1co_mode_sel_mask = BIT(2),
>> +	.mode = DW_PCIE_EP_TYPE,
>> +};
>> +
>> +static const struct dra7xx_pcie_of_data dra726_pcie_ep_of_data = {
>> +	.b1co_mode_sel_mask = GENMASK(3, 2),
>> +	.mode = DW_PCIE_EP_TYPE,
>> +};
>> +
>>  static const struct of_device_id of_dra7xx_pcie_match[] = {
>>  	{
>>  		.compatible = "ti,dra7-pcie",
>> @@ -542,6 +567,22 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>>  		.compatible = "ti,dra7-pcie-ep",
>>  		.data = &dra7xx_pcie_ep_of_data,
>>  	},
>> +	{
>> +		.compatible = "ti,dra746-pcie-rc",
>> +		.data = &dra746_pcie_rc_of_data,
>> +	},
>> +	{
>> +		.compatible = "ti,dra726-pcie-rc",
>> +		.data = &dra726_pcie_rc_of_data,
>> +	},
>> +	{
>> +		.compatible = "ti,dra746-pcie-ep",
>> +		.data = &dra746_pcie_ep_of_data,
>> +	},
>> +	{
>> +		.compatible = "ti,dra726-pcie-ep",
>> +		.data = &dra726_pcie_ep_of_data,
>> +	},
>>  	{},
>>  };
>>  
>> @@ -587,6 +628,47 @@ static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>>  	return ret;
>>  }
>>  
>> +static int dra7xx_pcie_configure_two_lane(struct device *dev,
>> +					  u32 b1co_mode_sel_mask)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct regmap *pcie_syscon;
>> +	unsigned int pcie_reg;
>> +
>> +	pcie_syscon = syscon_regmap_lookup_by_phandle(np,
>> +						      "ti,syscon-lane-conf");
>> +	if (IS_ERR(pcie_syscon)) {
>> +		dev_err(dev, "unable to get ti,syscon-lane-conf\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_property_read_u32_index(np, "ti,syscon-lane-conf", 1,
>> +				       &pcie_reg)) {
>> +		dev_err(dev, "couldn't get lane configuration reg offset\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_update_bits(pcie_syscon, pcie_reg, PCIE_1LANE_2LANE_SELECTION,
>> +			   PCIE_1LANE_2LANE_SELECTION);
> 
> I do not know if this can create issues but the regmap should clear
> those bits in the error path ?

hmm yeah, maybe we should try to fall back to 1 lane mode.
> 
>> +
>> +	pcie_syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-lane-sel");
>> +	if (IS_ERR(pcie_syscon)) {
>> +		dev_err(dev, "unable to get ti,syscon-lane-sel\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_property_read_u32_index(np, "ti,syscon-lane-sel", 1,
>> +				       &pcie_reg)) {
>> +		dev_err(dev, "couldn't get lane selection reg offset\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_update_bits(pcie_syscon, pcie_reg, b1co_mode_sel_mask,
>> +			   PCIE_B1C0_MODE_SEL);
>> +
>> +	return 0;
>> +}
>> +
>>  static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  {
>>  	u32 reg;
>> @@ -608,6 +690,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  	const struct of_device_id *match;
>>  	const struct dra7xx_pcie_of_data *data;
>>  	enum dw_pcie_device_mode mode;
>> +	u32 b1co_mode_sel_mask;
> 
> Again, do you need this temporary variable (given that you pass the
> value below) ?

I used so that we don't cross the 80 line character limit below.

Thanks
Kishon
