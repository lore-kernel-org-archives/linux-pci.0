Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 28 Jan 2017 14:54:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie: ti: Provide patch to force GEN1 PCIe operation
Message-ID: <20170128205459.GD20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1484486354-4585-1-git-send-email-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484486354-4585-1-git-send-email-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2017 at 02:19:14PM +0100, Lukasz Majewski wrote:
> Some devices (due to e.g. bad PCIe signal integrity) require to run
> with forced GEN1 speed on PCIe bus.
> 
> This patch changes the speed explicitly on dra7 based devices when
> proper device tree attribute is defined for the PCIe controller.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Hi Lukasz, there was a lot of discussion after this, so I'm going to
drop this version and wait for a new one (if one is still needed).
I think I saw a URL with more scenario details; please include that if
appropriate (ideally the details would be in a permanent public place
like the kernel.org bugzilla).

> ---
> 
> Patch applies on newest origin/master
> SHA1: f4d3935e4f4884ba80561db5549394afb8eef8f7
> 
> Tested at AM5728
> 
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |  1 +
>  drivers/pci/host/pci-dra7xx.c                    | 23 +++++++++++++++++++++++
>  drivers/pci/host/pcie-designware.h               |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 60e2516..9f97409 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -25,6 +25,7 @@ PCIe Designware Controller
>  
>  Optional Property:
>   - gpios : Should be added if a gpio line is required to drive PERST# line
> + - to,pcie-is-gen1: Indicates that forced gen1 port operation is needed.
>  
>  Example:
>  axi {
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 9595fad..eec5fae 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -63,6 +63,13 @@
>  #define	LINK_UP						BIT(16)
>  #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
>  
> +#define         PCIECTRL_EP_DBICS_LNK_CAP                       0x007C
> +#define         MAX_LINK_SPEEDS_MASK				GENMASK(3, 0)
> +#define         MAX_LINK_SPEEDS_GEN1                            BIT(0)
> +
> +#define         PCIECTRL_PL_WIDTH_SPEED_CTL                     0x080C
> +#define         CFG_DIRECTED_SPEED_CHANGE                       BIT(17)
> +
>  struct dra7xx_pcie {
>  	struct pcie_port	pp;
>  	void __iomem		*base;		/* DT ti_conf */
> @@ -270,6 +277,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  	struct pcie_port *pp = &dra7xx->pp;
>  	struct device *dev = pp->dev;
>  	struct resource *res;
> +	u32 val;
>  
>  	pp->irq = platform_get_irq(pdev, 1);
>  	if (pp->irq < 0) {
> @@ -296,6 +304,18 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  	if (!pp->dbi_base)
>  		return -ENOMEM;
>  
> +	if (pp->is_gen1) {
> +		dev_info(dev, "GEN1 forced\n");
> +
> +		val = readl(pp->dbi_base + PCIECTRL_EP_DBICS_LNK_CAP);
> +		set_mask_bits(&val, MAX_LINK_SPEEDS_MASK, MAX_LINK_SPEEDS_GEN1);
> +		writel(val, pp->dbi_base + PCIECTRL_EP_DBICS_LNK_CAP);
> +
> +		val = readl(pp->dbi_base + PCIECTRL_PL_WIDTH_SPEED_CTL);
> +		val &= ~CFG_DIRECTED_SPEED_CHANGE;
> +		writel(val, pp->dbi_base + PCIECTRL_PL_WIDTH_SPEED_CTL);
> +	}
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize host\n");
> @@ -404,6 +424,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		goto err_gpio;
>  	}
>  
> +	if (of_property_read_bool(np, "ti,pcie-is-gen1"))
> +		pp->is_gen1 = true;
> +
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
>  	reg &= ~LTSSM_EN;
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index a567ea2..2fb0b18 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -50,6 +50,7 @@ struct pcie_port {
>  	struct irq_domain	*irq_domain;
>  	unsigned long		msi_data;
>  	u8			iatu_unroll_enabled;
> +	u8                      is_gen1;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
