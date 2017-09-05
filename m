Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdIESq0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 14:46:26 -0400
Date: Tue, 5 Sep 2017 13:46:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 01/10] PCI: exynos: Fix platform_get_irq() error handling
Message-ID: <20170905184623.GC14367@bhelgaas-glaptop.roam.corp.google.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 31, 2017 at 02:52:01PM -0300, Fabio Estevam wrote:
> platform_get_irq() returns a negative number on failure, so
> adjust the logic to detect such condition and propagate
> the real error value on failure.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks, Fabio.  I applied all these on their respective branches for v4.14,
with the acks received so far.

> ---
>  drivers/pci/dwc/pci-exynos.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index f77f872..5596fde 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -607,9 +607,9 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
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
> @@ -620,9 +620,9 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
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
> 
