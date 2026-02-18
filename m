Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F13019BE;
	Wed, 18 Feb 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432989; cv=none; b=gwGjM7WdP1Jcpw9bzK1yW5ST/4zs/sVPos/TkHjw4stfQ4iRONPm/x/uT2i8GjlgjTTGUlPY2joFLvRlp/R9dS1WkQBvB5KugRTHwodddVlw7m4JAvh/sTZTUv1Jdmaa0a+aSuhFu6o5/RBYd4oui/zfZ0ErVomGi3Fh104TeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432989; c=relaxed/simple;
	bh=dj3eQKTqmGH29R7zQS8gpeEsE6QcOmVz4CshF/Dp7is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhskIjLSRUwX46B0eciDC9swwSzFkblshGkM7MYJmap5c45GlpEUW6mXEV1JLXbvJ9+JvSyW1vUdrq6bvgqKPCdyZ4vLt/05CARSBwbHO9Kc1saH30tkTHvzvpL92qSX9bycSrwkkQq8f78HOsCvPl7fij07vC48B2FQf4Ug9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwih0YWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwih0YWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA9DC116D0;
	Wed, 18 Feb 2026 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771432988;
	bh=dj3eQKTqmGH29R7zQS8gpeEsE6QcOmVz4CshF/Dp7is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwih0YWGPYmqx/PmT9sZ3jnS9/xW6YwMNTsC5P5U0KGQAMzovasEdfdPDvr1BzUU9
	 2J+F7HoYScit3dce5srGgeRjDCf8vU9EvuOAuheqmmXmwPT7MqdwjZ+U84/NDRkd+p
	 nuLQw+YvQdqj3OKVcWhC40p4EjHSb8LzKbwUHdDQXss3wutU2Wa2Y7v1Bnehko6bzA
	 MQpcRw8BQSDupVUm6ZaLCTatKfRW14+gdP1TvZEZgBdosK2xC/VeS6TJm6mpRgSJZN
	 si2IHtEAjxRSC7/l9qESmuXi9ZAU2YwmUtCf77XEBV0QW8nLNIJV3qNxKX/HQVVDKC
	 g+lNRAD8naQUw==
Date: Wed, 18 Feb 2026 22:12:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 7/8] PCI: xilinx-nwl: Reset the core during probe
Message-ID: <6ugot5mmhaepx5u7b5xatq7d3rwv3nlpl5sfd6hn3whqnojw3o@rc2lietsxpdm>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203002128.935842-8-sean.anderson@linux.dev>

On Mon, Feb 02, 2026 at 07:21:27PM -0500, Sean Anderson wrote:
> The PCIe core must be held in reset when initializing phys.
> Assert/deassert the appropriate resets.
> 
> Resetting the core also resets the PCIe attributes to their default
> values, so initialize those too. For the most part the defaults are
> fine, but there are many attributes that default to an endpoint
> configuration and must be reprogrammed to function as a root device.
> We generally follow the controller programming sequence from UG1085.
> 
> Xilinx was extremely imaginative and named all the registers ATTR_1,
> ATTR_2 etc. (with the fields organized in alphabetical order) so we
> follow the same convention. Only the fields are named, but sometimes a
> field is split across multiple registers. All the BARs are unused but
> some are repurposed as bridge registers when used as a root port.
> 

Can someone from AMD/Xilinx review this patch?

- Mani

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/pci/controller/pcie-xilinx-nwl.c | 177 +++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 7cfdc21e6f40..b78fbad1efa5 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci-ecam.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/irqchip/chained_irq.h>
>  
>  #include "../pci.h"
> @@ -133,6 +134,54 @@
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
>  #define CFG_PCIE_CACHE			GENMASK(7, 0)
>  
> +#define PCIE_ATTR2_AER_CAP_PERMIT_ROOTERR_UPDATE	BIT(0)
> +
> +#define PCIE_ATTR25_CPL_TIMEOUT_DISABLE_SUPPORTED	BIT(9)
> +#define PCIE_ATTR25_INTX_IMPLEMENTED			BIT(8)
> +#define PCIE_ATTR25_CLASS_CODE				GENMASK(7, 0)
> +
> +#define PCIE_ATTR27_DEV_CAP_ENDPOINT_L1_LATENCY		GENMASK(5, 3)
> +
> +#define PCIE_ATTR34_HEADER_TYPE				GENMASK(7, 0)
> +
> +#define PCIE_ATTR35_LINK_CAP_DLL_ACTIVE_REPORTING	BIT(15)
> +
> +#define PCIE_ATTR37_LINK_CAP_MAX_LINK_SPEED		GENMASK(13, 10)
> +#define PCIE_ATTR37_LINK_CAP_MAX_LINK_SPEED_2_5		1
> +#define PCIE_ATTR37_LINK_CAP_MAX_LINK_SPEED_5_0		2
> +#define PCIE_ATTR37_LINK_CAP_BANDWIDTH_NOTIFICATION	BIT(9)
> +
> +#define PCIE_ATTR50_CAP_DEVICE_PORT_TYPE		GENMASK(7, 4)
> +#define PCIE_ATTR50_CAP_NEXTPTR				GENMASK(15, 8)
> +
> +#define PCIE_ATTR53_CAP_NEXTPTR				GENMASK(7, 0)
> +
> +#define PCIE_ATTR93_LL_REPLAY_TIMEOUT_EN		BIT(15)
> +
> +#define PCIE_ATTR97_LTSSM_MAX_LINK_WIDTH		GENMASK(11, 6)
> +#define PCIE_ATTR97_LINK_CAP_MAX_LINK_WIDTH		GENMASK(5, 0)
> +
> +#define PCIE_ATTR100_UPSTREAM_FACING			BIT(6)
> +
> +#define PCIE_ATTR101_EN_MSG_ROUTE			GENMASK(15, 5)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_PME_TURN_OFF		BIT(15)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_UNLOCK		BIT(14)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_PME_TO_ACK		BIT(13)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_PM_PME		BIT(12)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_INTD			BIT(11)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_INTC			BIT(10)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_INTB			BIT(9)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_INTA			BIT(8)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_ERR_FATAL		BIT(7)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_ERR_NONFATAL		BIT(6)
> +#define PCIE_ATTR101_EN_MSG_ROUTE_ERR_COR		BIT(5)
> +#define PCIE_ATTR101_DISABLE_BAR_FILTERING		BIT(1)
> +
> +#define PCIE_ATTR106_VC0_TOTAL_CREDITS_NPH		GENMASK(13, 7)
> +#define PCIE_ATTR106_VC0_TOTAL_CREDITS_CH		GENMASK(6, 0)
> +
> +#define PCIE_ATTR109_VC0_TOTAL_CREDITS_PH		GENMASK(6, 0)
> +
>  #define INT_PCI_MSI_NR			(2 * 32)
>  
>  /* Readin the PS_LINKUP */
> @@ -159,6 +208,7 @@ struct nwl_pcie {
>  	void __iomem *pcireg_base;
>  	void __iomem *ecam_base;
>  	struct phy *phy[4];
> +	struct reset_control *ctrl_reset;
>  	phys_addr_t phys_breg_base;	/* Physical Bridge Register Base */
>  	phys_addr_t phys_pcie_reg_base;	/* Physical PCIe Controller Base */
>  	phys_addr_t phys_ecam_base;	/* Physical Configuration Base */
> @@ -173,6 +223,115 @@ struct nwl_pcie {
>  	raw_spinlock_t leg_mask_lock;
>  };
>  
> +static void nwl_pcie_write_attr(struct nwl_pcie *pcie, u32 attr, u16 val)
> +{
> +	writel(val, pcie->pcireg_base + attr * 4);
> +}
> +
> +static void nwl_pcie_modify_attr(struct nwl_pcie *pcie, u32 attr, u16 clear,
> +				u16 set)
> +{
> +	u32 val = readl(pcie->pcireg_base + attr * 4);
> +
> +	nwl_pcie_write_attr(pcie, attr, (val & ~clear) | set);
> +}
> +
> +static void nwl_pcie_attr_init(struct nwl_pcie *pcie)
> +{
> +	unsigned int width;
> +
> +	for (width = ARRAY_SIZE(pcie->phy); width; width--)
> +		if (pcie->phy[width - 1])
> +			break;
> +
> +	/* Set TLP header to type-1 */
> +	nwl_pcie_modify_attr(pcie, 34, PCIE_ATTR34_HEADER_TYPE, PCI_HEADER_TYPE_BRIDGE);
> +	nwl_pcie_modify_attr(pcie, 100, PCIE_ATTR100_UPSTREAM_FACING, 0);
> +
> +	/* Disable BAR0/1 */
> +	nwl_pcie_write_attr(pcie, 7, 0);
> +	nwl_pcie_write_attr(pcie, 8, 0);
> +	nwl_pcie_write_attr(pcie, 9, 0);
> +	nwl_pcie_write_attr(pcie, 10, 0);
> +	/* Enable primary/secondary/subordinate busses, disable latency timer */
> +	nwl_pcie_write_attr(pcie, 11, 0xffff);
> +	nwl_pcie_write_attr(pcie, 12, 0x00ff);
> +	nwl_pcie_write_attr(pcie, 13, 0x0000); /* Disable I/O window */
> +	nwl_pcie_write_attr(pcie, 14, 0x0000); /* Enable secondary status */
> +	/* Enable memory window */
> +	nwl_pcie_write_attr(pcie, 15, (u16)PCI_MEMORY_RANGE_MASK);
> +	nwl_pcie_write_attr(pcie, 16, (u16)PCI_MEMORY_RANGE_MASK);
> +	/* Enable 64-bit prefetchable window */
> +	nwl_pcie_write_attr(pcie, 17,
> +			    (u16)PCI_PREF_RANGE_MASK | PCI_PREF_RANGE_TYPE_64);
> +	nwl_pcie_write_attr(pcie, 18,
> +			    (u16)PCI_PREF_RANGE_MASK | PCI_PREF_RANGE_TYPE_64);
> +	nwl_pcie_modify_attr(pcie, 101, 0, PCIE_ATTR101_DISABLE_BAR_FILTERING);
> +
> +	/* Set class code to PCI_CLASS_BRIDGE_PCI_NORMAL */
> +	nwl_pcie_write_attr(pcie, 24, PCI_CLASS_BRIDGE_PCI_NORMAL & 0xffff);
> +	nwl_pcie_modify_attr(pcie, 25, PCIE_ATTR25_CLASS_CODE,
> +			     PCIE_ATTR25_CPL_TIMEOUT_DISABLE_SUPPORTED |
> +			     PCI_BASE_CLASS_BRIDGE);
> +
> +	/* Enable PCIe capability */
> +	nwl_pcie_modify_attr(pcie, 53, PCIE_ATTR53_CAP_NEXTPTR, 0x60);
> +	nwl_pcie_modify_attr(pcie, 50,
> +			     PCIE_ATTR50_CAP_NEXTPTR |
> +			     PCIE_ATTR50_CAP_DEVICE_PORT_TYPE,
> +			     FIELD_PREP(PCIE_ATTR50_CAP_DEVICE_PORT_TYPE,
> +					PCI_EXP_TYPE_ROOT_PORT));
> +
> +	/* Disable MSI(-X) capability */
> +	nwl_pcie_write_attr(pcie, 41, 0);
> +	nwl_pcie_write_attr(pcie, 43, 0);
> +	nwl_pcie_write_attr(pcie, 44, 0);
> +	nwl_pcie_write_attr(pcie, 45, 0);
> +	nwl_pcie_write_attr(pcie, 46, 0);
> +	nwl_pcie_write_attr(pcie, 48, 0);
> +
> +	/* Disable DSN capability */
> +	nwl_pcie_write_attr(pcie, 31, 0);
> +	nwl_pcie_write_attr(pcie, 82, PCI_CFG_SPACE_SIZE);
> +
> +	/* Enable AER */
> +	nwl_pcie_modify_attr(pcie, 2, 0,
> +			     PCIE_ATTR2_AER_CAP_PERMIT_ROOTERR_UPDATE);
> +
> +	/* Disable L1 latency for root port */
> +	nwl_pcie_modify_attr(pcie, 27,
> +			     PCIE_ATTR27_DEV_CAP_ENDPOINT_L1_LATENCY, 0);
> +
> +	/* Enable bandwidth notification */
> +	nwl_pcie_modify_attr(pcie, 37, 0,
> +			     PCIE_ATTR37_LINK_CAP_BANDWIDTH_NOTIFICATION);
> +
> +	/* Set max link width */
> +	nwl_pcie_write_attr(pcie, 97,
> +			    FIELD_PREP(PCIE_ATTR97_LTSSM_MAX_LINK_WIDTH, width) |
> +			    FIELD_PREP(PCIE_ATTR97_LINK_CAP_MAX_LINK_WIDTH, width));
> +
> +	/* Route misc. TLPs to controller */
> +	nwl_pcie_modify_attr(pcie, 101, PCIE_ATTR101_EN_MSG_ROUTE,
> +			     PCIE_ATTR101_EN_MSG_ROUTE_INTA |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_INTB |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_INTC |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_INTD |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_PM_PME |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_PME_TO_ACK |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_UNLOCK |
> +			     PCIE_ATTR101_EN_MSG_ROUTE_PME_TURN_OFF);
> +
> +	/* Initialize completion credits */
> +	nwl_pcie_write_attr(pcie, 105, 205); /* CD */
> +	nwl_pcie_write_attr(pcie, 106,
> +			    FIELD_PREP(PCIE_ATTR106_VC0_TOTAL_CREDITS_NPH, 12) |
> +			    FIELD_PREP(PCIE_ATTR106_VC0_TOTAL_CREDITS_CH, 36));
> +	nwl_pcie_write_attr(pcie, 107, 24); /* NPD */
> +	nwl_pcie_write_attr(pcie, 108, 181); /* PD */
> +	nwl_pcie_modify_attr(pcie, 109, PCIE_ATTR109_VC0_TOTAL_CREDITS_PH, 32);
> +}
> +
>  static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off)
>  {
>  	return readl(pcie->breg_base + off);
> @@ -806,6 +965,9 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  	irq_set_chained_handler_and_data(pcie->irq_intx,
>  					 nwl_pcie_leg_handler, pcie);
>  
> +	pcie->ctrl_reset = devm_reset_control_get_optional(dev, "ctrl");
> +	if (IS_ERR(pcie->ctrl_reset))
> +		return PTR_ERR(pcie->ctrl_reset);
>  
>  	for (i = 0; i < ARRAY_SIZE(pcie->phy); i++) {
>  		pcie->phy[i] = devm_of_phy_get_by_index(dev, dev->of_node, i);
> @@ -852,6 +1014,12 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->clk))
>  		return PTR_ERR(pcie->clk);
>  
> +	err = reset_control_assert(pcie->ctrl_reset);
> +	if (err) {
> +		dev_err(dev, "could not enter reset\n");
> +		return err;
> +	}
> +
>  	err = clk_prepare_enable(pcie->clk);
>  	if (err) {
>  		dev_err(dev, "can't enable PCIe ref clock\n");
> @@ -864,6 +1032,15 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  		goto err_clk;
>  	}
>  
> +	if (pcie->ctrl_reset)
> +		nwl_pcie_attr_init(pcie);
> +
> +	err = reset_control_deassert(pcie->ctrl_reset);
> +	if (err) {
> +		dev_err(dev, "could not release from reset\n");
> +		goto err_phy_init;
> +	}
> +
>  	err = nwl_pcie_phy_power_on(pcie);
>  	if (err) {
>  		dev_err(dev, "could not power on PHYs\n");
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

-- 
மணிவண்ணன் சதாசிவம்
