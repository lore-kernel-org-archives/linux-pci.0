Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdHCWCu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 18:02:50 -0400
Date: Thu, 3 Aug 2017 17:02:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, thomas.petazzoni@free-electrons.com,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v2] PCI: armada8k: Check the return value from
 clk_prepare_enable()
Message-ID: <20170803220248.GJ20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500755119-19983-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500755119-19983-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 22, 2017 at 05:25:19PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied with Thomas' ack to pci/host-armada for v4.14, thanks!

> ---
> Changes since v1:
> - Improve Subject style
> 
>  drivers/pci/dwc/pcie-armada8k.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
> index ea8f34a..7297223 100644
> --- a/drivers/pci/dwc/pcie-armada8k.c
> +++ b/drivers/pci/dwc/pcie-armada8k.c
> @@ -226,7 +226,9 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->clk))
>  		return PTR_ERR(pcie->clk);
>  
> -	clk_prepare_enable(pcie->clk);
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret)
> +		return ret;
>  
>  	/* Get the dw-pcie unit configuration/control registers base. */
>  	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
> -- 
> 2.7.4
> 
