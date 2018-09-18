Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbeIRPNn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 11:13:43 -0400
Date: Tue, 18 Sep 2018 10:41:47 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
Message-ID: <20180918094147.GA26886@e107981-ln.cambridge.arm.com>
References: <20180917180635.26996-1-vigneshr@ti.com>
 <20180917180635.26996-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180917180635.26996-3-vigneshr@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2018 at 11:36:35PM +0530, Vignesh R wrote:
> Errata i870 is applicable in both EP and RC mode. Therefore rename
> function dra7xx_pcie_ep_unaligned_memaccess(), that implements errata
> workaround, to dra7xx_pcie_unaligned_memaccess() and call it from a
> common place. So, that errata workaround is applied for both modes of
> operation.
> 
> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index ce9224a36f62..43711561a199 100644
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
> +		dev_err(dev, "WA for Errata i870 not applied. Update DT\n");

Hi Vignesh,

I am not sure you want this code merged into an -rc given that without
a DTS update is basically pointless (and for that bindings should at
least be merged too as a fix).

I would also like to understand why a dev_err() is sufficient, can the
controller work without the WA applied ?

Nit: Lastly, in the dev_err() message, it is your call/code but I would not
print "update DT", kernel log is not a command prompt but that's just my
opinion so it is up to you.

Thanks,
Lorenzo

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
> 2.19.0
> 
