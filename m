Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:43504 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbdLTF7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 00:59:50 -0500
Subject: Re: [PATCH v6 09/18] PCI: dwc: dra7xx: Help compiler to remove unused
 code
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171219232940.659-10-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d6d663b1-c76e-5b1d-8bd0-95e712b690ea@ti.com>
Date: Wed, 20 Dec 2017 11:28:55 +0530
MIME-Version: 1.0
In-Reply-To: <20171219232940.659-10-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 20 December 2017 04:59 AM, Niklas Cassel wrote:
> The dra7xx driver supports both host and ep mode.
> When enabling support for only one of the modes, help the compiler
> to remove code for the mode that we have not enabled in the driver.
> 
> By adding if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) return -ENODEV;
> anything after that statement will get silently dropped by the compiler,
> including static functions and structures that are referenced indirectly
> from there.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 07c74ae3614e..224ff8affdce 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -694,6 +694,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  
>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
> +			ret = -ENODEV;
> +			goto err_gpio;
> +		}
> +
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_RC);
>  		ret = dra7xx_add_pcie_port(dra7xx, pdev);
> @@ -701,6 +706,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  			goto err_gpio;
>  		break;
>  	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_EP)) {
> +			ret = -ENODEV;
> +			goto err_gpio;
> +		}
> +
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_EP);
>  
> 
