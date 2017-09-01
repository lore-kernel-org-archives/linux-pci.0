Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33755 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbdIANRv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2017 09:17:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id k126so154248qkb.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Sep 2017 06:17:50 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Fabio Estevam'" <fabio.estevam@nxp.com>, <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
Subject: Re: [PATCH 01/10] PCI: exynos: Fix platform_get_irq() error handling
Date: Fri, 1 Sep 2017 09:17:48 -0400
Message-ID: <000001d32324$b5466280$1fd32780$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(CC'ed Joao Pinto)

On Thursday, August 31, 2017 1:52 PM, Fabio Estevam wrote:
> 
> platform_get_irq() returns a negative number on failure, so
> adjust the logic to detect such condition and propagate
> the real error value on failure.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pci-exynos.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index f77f872..5596fde 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -607,9 +607,9 @@ static int __init exynos_add_pcie_port(struct
> exynos_pcie *ep,
>  	int ret;
> 
>  	pp->irq = platform_get_irq(pdev, 1);
> -	if (!pp->irq) {
> +	if (pp->irq < 0) {
>  		dev_err(dev, "failed to get irq\n");
> -		return -ENODEV;
> +		return pp->irq;
>  	}
>  	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
>  				IRQF_SHARED, "exynos-pcie", ep);
> @@ -620,9 +620,9 @@ static int __init exynos_add_pcie_port(struct
> exynos_pcie *ep,
> 
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq(pdev, 0);
> -		if (!pp->msi_irq) {
> +		if (pp->msi_irq < 0) {
>  			dev_err(dev, "failed to get msi irq\n");
> -			return -ENODEV;
> +			return pp->msi_irq;
>  		}
> 
>  		ret = devm_request_irq(dev, pp->msi_irq,
> --
> 2.7.4
