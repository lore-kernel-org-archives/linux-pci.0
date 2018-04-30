Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754265AbeD3Ovh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 10:51:37 -0400
Date: Mon, 30 Apr 2018 15:51:32 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/7] PCI: rockchip: Split out common function to parse
 DT
Message-ID: <20180430145132.GD32033@e107981-ln.cambridge.arm.com>
References: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
 <1524796751-161084-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524796751-161084-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:39:11AM +0800, Shawn Lin wrote:
> Most of the DT properties are used for both of host and
> EP drivrs, so this patch spilt them out to new function,
> rockchip_pcie_parse_dt in pcie-rockchip.c and rename the
> original function to rockchip_pcie_parse_host_dt to avoid
> confusion. No functional changed intended.

If you read this commit log again you would notice that there
are typos and the formatting is non-compliant with:

https://marc.info/?l=linux-pci&m=150905742808166&w=2

I am fine with updating commit logs myself, that's not a problem, but I
wanted to make clear that you can easily spot these issues for future
postings too ;-)

Lorenzo

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> 
>  drivers/pci/host/pcie-rockchip-host.c | 119 ++-----------------------------
>  drivers/pci/host/pcie-rockchip.c      | 129 ++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-rockchip.h      |   2 +
>  3 files changed, 136 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip-host.c b/drivers/pci/host/pcie-rockchip-host.c
> index fae9ecc..cf97130 100644
> --- a/drivers/pci/host/pcie-rockchip-host.c
> +++ b/drivers/pci/host/pcie-rockchip-host.c
> @@ -705,130 +705,20 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
>  }
>  
>  /**
> - * rockchip_pcie_parse_dt - Parse Device Tree
> + * rockchip_pcie_parse_host_dt - Parse Device Tree
>   * @rockchip: PCIe port information
>   *
>   * Return: '0' on success and error value on failure
>   */
> -static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> +static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct device_node *node = dev->of_node;
> -	struct resource *regs;
>  	int err;
>  
> -	regs = platform_get_resource_byname(pdev,
> -					    IORESOURCE_MEM,
> -					    "axi-base");
> -	rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
> -	if (IS_ERR(rockchip->reg_base))
> -		return PTR_ERR(rockchip->reg_base);
> -
> -	regs = platform_get_resource_byname(pdev,
> -					    IORESOURCE_MEM,
> -					    "apb-base");
> -	rockchip->apb_base = devm_ioremap_resource(dev, regs);
> -	if (IS_ERR(rockchip->apb_base))
> -		return PTR_ERR(rockchip->apb_base);
> -
> -	err = rockchip_pcie_get_phys(rockchip);
> +	err = rockchip_pcie_parse_dt(rockchip);
>  	if (err)
>  		return err;
>  
> -	rockchip->lanes = 1;
> -	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
> -	if (!err && (rockchip->lanes == 0 ||
> -		     rockchip->lanes == 3 ||
> -		     rockchip->lanes > 4)) {
> -		dev_warn(dev, "invalid num-lanes, default to use one lane\n");
> -		rockchip->lanes = 1;
> -	}
> -
> -	rockchip->link_gen = of_pci_get_max_link_speed(node);
> -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> -		rockchip->link_gen = 2;
> -
> -	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
> -	if (IS_ERR(rockchip->core_rst)) {
> -		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing core reset property in node\n");
> -		return PTR_ERR(rockchip->core_rst);
> -	}
> -
> -	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
> -	if (IS_ERR(rockchip->mgmt_rst)) {
> -		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing mgmt reset property in node\n");
> -		return PTR_ERR(rockchip->mgmt_rst);
> -	}
> -
> -	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
> -								     "mgmt-sticky");
> -	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
> -		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing mgmt-sticky reset property in node\n");
> -		return PTR_ERR(rockchip->mgmt_sticky_rst);
> -	}
> -
> -	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
> -	if (IS_ERR(rockchip->pipe_rst)) {
> -		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing pipe reset property in node\n");
> -		return PTR_ERR(rockchip->pipe_rst);
> -	}
> -
> -	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
> -	if (IS_ERR(rockchip->pm_rst)) {
> -		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing pm reset property in node\n");
> -		return PTR_ERR(rockchip->pm_rst);
> -	}
> -
> -	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
> -	if (IS_ERR(rockchip->pclk_rst)) {
> -		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing pclk reset property in node\n");
> -		return PTR_ERR(rockchip->pclk_rst);
> -	}
> -
> -	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
> -	if (IS_ERR(rockchip->aclk_rst)) {
> -		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing aclk reset property in node\n");
> -		return PTR_ERR(rockchip->aclk_rst);
> -	}
> -
> -	rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> -	if (IS_ERR(rockchip->ep_gpio)) {
> -		dev_err(dev, "missing ep-gpios property in node\n");
> -		return PTR_ERR(rockchip->ep_gpio);
> -	}
> -
> -	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
> -	if (IS_ERR(rockchip->aclk_pcie)) {
> -		dev_err(dev, "aclk clock not found\n");
> -		return PTR_ERR(rockchip->aclk_pcie);
> -	}
> -
> -	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> -	if (IS_ERR(rockchip->aclk_perf_pcie)) {
> -		dev_err(dev, "aclk_perf clock not found\n");
> -		return PTR_ERR(rockchip->aclk_perf_pcie);
> -	}
> -
> -	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
> -	if (IS_ERR(rockchip->hclk_pcie)) {
> -		dev_err(dev, "hclk clock not found\n");
> -		return PTR_ERR(rockchip->hclk_pcie);
> -	}
> -
> -	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
> -	if (IS_ERR(rockchip->clk_pcie_pm)) {
> -		dev_err(dev, "pm clock not found\n");
> -		return PTR_ERR(rockchip->clk_pcie_pm);
> -	}
> -
>  	err = rockchip_pcie_setup_irq(rockchip);
>  	if (err)
>  		return err;
> @@ -1195,8 +1085,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, rockchip);
>  	rockchip->dev = dev;
> +	rockchip->is_rc = true;
>  
> -	err = rockchip_pcie_parse_dt(rockchip);
> +	err = rockchip_pcie_parse_host_dt(rockchip);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 3d46da9..bcc222b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -12,10 +12,139 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
>  
>  #include "pcie-rockchip.h"
>  
> +int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *node = dev->of_node;
> +	struct resource *regs;
> +	int err;
> +
> +	regs = platform_get_resource_byname(pdev,
> +					    IORESOURCE_MEM,
> +					    "axi-base");
> +	rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
> +	if (IS_ERR(rockchip->reg_base))
> +		return PTR_ERR(rockchip->reg_base);
> +
> +	regs = platform_get_resource_byname(pdev,
> +					    IORESOURCE_MEM,
> +					    "apb-base");
> +	rockchip->apb_base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(rockchip->apb_base))
> +		return PTR_ERR(rockchip->apb_base);
> +
> +	err = rockchip_pcie_get_phys(rockchip);
> +	if (err)
> +		return err;
> +
> +	rockchip->lanes = 1;
> +	err = of_property_read_u32(node, "num-lanes", &rockchip->lanes);
> +	if (!err && (rockchip->lanes == 0 ||
> +		     rockchip->lanes == 3 ||
> +		     rockchip->lanes > 4)) {
> +		dev_warn(dev, "invalid num-lanes, default to use one lane\n");
> +		rockchip->lanes = 1;
> +	}
> +
> +	rockchip->link_gen = of_pci_get_max_link_speed(node);
> +	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> +		rockchip->link_gen = 2;
> +
> +	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
> +	if (IS_ERR(rockchip->core_rst)) {
> +		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing core reset property in node\n");
> +		return PTR_ERR(rockchip->core_rst);
> +	}
> +
> +	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
> +	if (IS_ERR(rockchip->mgmt_rst)) {
> +		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing mgmt reset property in node\n");
> +		return PTR_ERR(rockchip->mgmt_rst);
> +	}
> +
> +	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
> +								     "mgmt-sticky");
> +	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
> +		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing mgmt-sticky reset property in node\n");
> +		return PTR_ERR(rockchip->mgmt_sticky_rst);
> +	}
> +
> +	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
> +	if (IS_ERR(rockchip->pipe_rst)) {
> +		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pipe reset property in node\n");
> +		return PTR_ERR(rockchip->pipe_rst);
> +	}
> +
> +	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
> +	if (IS_ERR(rockchip->pm_rst)) {
> +		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pm reset property in node\n");
> +		return PTR_ERR(rockchip->pm_rst);
> +	}
> +
> +	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
> +	if (IS_ERR(rockchip->pclk_rst)) {
> +		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pclk reset property in node\n");
> +		return PTR_ERR(rockchip->pclk_rst);
> +	}
> +
> +	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
> +	if (IS_ERR(rockchip->aclk_rst)) {
> +		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing aclk reset property in node\n");
> +		return PTR_ERR(rockchip->aclk_rst);
> +	}
> +
> +	if (rockchip->is_rc) {
> +		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +		if (IS_ERR(rockchip->ep_gpio)) {
> +			dev_err(dev, "missing ep-gpios property in node\n");
> +			return PTR_ERR(rockchip->ep_gpio);
> +		}
> +	}
> +
> +	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
> +	if (IS_ERR(rockchip->aclk_pcie)) {
> +		dev_err(dev, "aclk clock not found\n");
> +		return PTR_ERR(rockchip->aclk_pcie);
> +	}
> +
> +	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> +	if (IS_ERR(rockchip->aclk_perf_pcie)) {
> +		dev_err(dev, "aclk_perf clock not found\n");
> +		return PTR_ERR(rockchip->aclk_perf_pcie);
> +	}
> +
> +	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
> +	if (IS_ERR(rockchip->hclk_pcie)) {
> +		dev_err(dev, "hclk clock not found\n");
> +		return PTR_ERR(rockchip->hclk_pcie);
> +	}
> +
> +	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
> +	if (IS_ERR(rockchip->clk_pcie_pm)) {
> +		dev_err(dev, "pm clock not found\n");
> +		return PTR_ERR(rockchip->clk_pcie_pm);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
> +
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
> diff --git a/drivers/pci/host/pcie-rockchip.h b/drivers/pci/host/pcie-rockchip.h
> index d27941e..473e74f 100644
> --- a/drivers/pci/host/pcie-rockchip.h
> +++ b/drivers/pci/host/pcie-rockchip.h
> @@ -222,6 +222,7 @@ struct rockchip_pcie {
>  	u32     mem_size;
>  	phys_addr_t msg_bus_addr;
>  	phys_addr_t mem_bus_addr;
> +	bool is_rc;
>  };
>  
>  static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
> @@ -235,6 +236,7 @@ static void rockchip_pcie_write(struct rockchip_pcie *rockchip, u32 val,
>  	writel(val, rockchip->apb_base + reg);
>  }
>  
> +int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip);
>  void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip);
>  int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip);
> -- 
> 1.9.1
> 
> 
