Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] PCI: dwc: dra7xx: Add ifdefs for host/ep
 specific code
To: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-10-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <32dd0d05-4ed0-1c8b-6ea4-ea4d560c5570@ti.com>
Date: Tue, 31 Oct 2017 13:59:55 +0530
MIME-Version: 1.0
In-Reply-To: <20171030124221.20690-10-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 30 October 2017 06:12 PM, Niklas Cassel wrote:
> This way you will not build and include unused code
> when only building for only one mode.
> 
> Moved dra7xx_pcie_enable_wrapper_interrupts() in order
> to avoid adding an extra ifdef block.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> V2:
> * New patch in this series.
> 
>  drivers/pci/dwc/pci-dra7xx.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 009f6aeeee1c..175544d6c3ab 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -171,6 +171,15 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
> +{
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
> +			   INTERRUPTS);
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
> +			   INTERRUPTS);
> +}
> +
> +#ifdef CONFIG_PCI_DRA7XX_HOST
>  static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
>  {
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
> @@ -181,14 +190,6 @@ static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
>  			   MSI | LEG_EP_INTERRUPTS);
>  }
>  
> -static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
> -{
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
> -			   INTERRUPTS);
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
> -			   INTERRUPTS);
> -}
> -
>  static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
>  {
>  	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
> @@ -276,6 +277,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  
>  	return IRQ_HANDLED;
>  }
> +#endif
>  
>  static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>  {
> @@ -336,6 +338,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_PCI_DRA7XX_EP
>  static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -427,7 +430,9 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>  
>  	return 0;
>  }
> +#endif
>  
> +#ifdef CONFIG_PCI_DRA7XX_HOST

This block can also be moved around the file so that there is a single +#ifdef
CONFIG_PCI_DRA7XX_HOST in this file.
>  static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  				       struct platform_device *pdev)
>  {
> @@ -470,6 +475,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  
>  	return 0;
>  }
> +#endif
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
> @@ -517,23 +523,31 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
>  	return ret;
>  }

IMO all the #ifdef's after this point can be removed.
>  
> +#ifdef CONFIG_PCI_DRA7XX_HOST
>  static const struct dra7xx_pcie_of_data dra7xx_pcie_rc_of_data = {
>  	.mode = DW_PCIE_RC_TYPE,
>  };
> +#endif
>  
> +#ifdef CONFIG_PCI_DRA7XX_EP
>  static const struct dra7xx_pcie_of_data dra7xx_pcie_ep_of_data = {
>  	.mode = DW_PCIE_EP_TYPE,
>  };
> +#endif
>  
>  static const struct of_device_id of_dra7xx_pcie_match[] = {
> +#ifdef CONFIG_PCI_DRA7XX_HOST
>  	{
>  		.compatible = "ti,dra7-pcie",
>  		.data = &dra7xx_pcie_rc_of_data,
>  	},
> +#endif
> +#ifdef CONFIG_PCI_DRA7XX_EP
>  	{
>  		.compatible = "ti,dra7-pcie-ep",
>  		.data = &dra7xx_pcie_ep_of_data,
>  	},
> +#endif
>  	{},
>  };
>  
> @@ -548,6 +562,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>   *
>   * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>   */
> +#ifdef CONFIG_PCI_DRA7XX_EP
>  static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>  {
>  	int ret;
> @@ -578,6 +593,7 @@ static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
>  
>  static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  {
> @@ -681,6 +697,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		dra7xx->link_gen = 2;
>  
>  	switch (mode) {
> +#ifdef CONFIG_PCI_DRA7XX_HOST
>  	case DW_PCIE_RC_TYPE:
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_RC);
> @@ -688,6 +705,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto err_gpio;
>  		break;
> +#endif
> +#ifdef CONFIG_PCI_DRA7XX_EP
>  	case DW_PCIE_EP_TYPE:
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_EP);
> @@ -700,6 +719,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto err_gpio;
>  		break;
> +#endif
>  	default:
>  		dev_err(dev, "INVALID device type %d\n", mode);
>  	}
> 

Thanks
Kishon
