Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Jul 2018 12:02:50 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
Message-ID: <20180718110250.GA21589@red-moon>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627122919.23926-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2018 at 05:59:17PM +0530, Vignesh R wrote:
> Errata i870 is applicable in both EP and RC mode. Therefore rename
> function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
> workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
> common place. So, that errata workaround is applied for both modes of
> operation.
> 
> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 345aab56ce8b..95d9076e3fde 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -542,7 +542,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>  };
>  
>  /*
> - * dra7xx_pcie_ep_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
> + * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
>   * @dra7xx: the dra7xx device where the workaround should be applied
>   *
>   * Access to the PCIe slave port that are not 32-bit aligned will result
> @@ -552,7 +552,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
>   *
>   * To avoid this issue set PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE to 1.
>   */
> -static int dra7xx_pcie_ep_unaligned_memaccess(struct device *dev)
> +static int dra7xx_pcie_unaligned_memaccess(struct device *dev)
>  {
>  	int ret;
>  	struct device_node *np = dev->of_node;
> @@ -695,6 +695,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
>  		dra7xx->link_gen = 2;
>  
> +	ret = dra7xx_pcie_unaligned_memaccess(dev);
> +	if (ret)
> +		dev_err(dev, "WA for Errata i870 not appplied. Update DT\n");

Hi Vignesh,

Nit: s/appplied/applied

Two questions:

- Current code applies the unaligned_memaccess() workaround for all
  compatible variants. This is fine for current controllers (since
  they are all affected), the code path above will have to be
  reworked if there is any other compatible IP re-using the driver
  that does not require the workaround.
- How do you want this series to go upstream ? If it goes via arm-soc,
  which I think it should, here is my ACK on this patch:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Please let me know if I can drop this series from the PCI patchwork.

Thanks,
Lorenzo

> +
>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
> @@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_EP);
>  
> -		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
> -		if (ret)
> -			goto err_gpio;
> -
>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>  		if (ret < 0)
>  			goto err_gpio;
> -- 
> 2.18.0
> 
