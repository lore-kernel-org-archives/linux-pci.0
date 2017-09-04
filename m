Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:56094 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbdIDO4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2017 10:56:16 -0400
Subject: Re: [PATCH 04/10] PCI: artpec6: Fix platform_get_irq() error handling
To: Fabio Estevam <fabio.estevam@nxp.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
 <1504201930-3617-4-git-send-email-fabio.estevam@nxp.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <5ab39f9a-fc8d-9e58-db7b-6ebb06151417@axis.com>
Date: Mon, 4 Sep 2017 16:56:11 +0200
MIME-Version: 1.0
In-Reply-To: <1504201930-3617-4-git-send-email-fabio.estevam@nxp.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Niklas Cassel <niklas.cassel@axis.com>

On 08/31/2017 07:52 PM, Fabio Estevam wrote:
> platform_get_irq() returns a negative number on failure, so
> adjust the logic to detect such condition and propagate
> the real error value on failure.
> 
> Cc: Niklas Cassel <niklas.cassel@axis.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pci/dwc/pcie-artpec6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> index 5d81f1d..83d6ee0 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -209,9 +209,9 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq <= 0) {
> +		if (pp->msi_irq < 0) {
>  			dev_err(dev, "failed to get MSI irq\n");
> -			return -ENODEV;
> +			return pp->msi_irq;
>  		}
>  
>  		ret = devm_request_irq(dev, pp->msi_irq,
> 
