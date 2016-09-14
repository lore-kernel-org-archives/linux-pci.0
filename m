Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759948AbcINVXI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 17:23:08 -0400
Date: Wed, 14 Sep 2016 16:23:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, jespern@axis.com, linux-arm-kernel@axis.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] PCI: artpec6: drop __init from artpec6_add_pcie_port
Message-ID: <20160914212303.GC16581@localhost>
References: <1473407130-21934-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473407130-21934-1-git-send-email-niklass@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 09:45:30AM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
> artpec6_add_pcie_port is called from artpec6_pcie_probe.
> artpec6_pcie_probe does not have the __init section marker.
> It is wrong to have the marker on artpec6_add_pcie_port
> when the marker is not on artpec6_pcie_probe.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Applied to pci/host-artpec for v4.9, thanks!

> ---
>  drivers/pci/host/pcie-artpec6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
> index 16ba70b7..39bf1a6 100644
> --- a/drivers/pci/host/pcie-artpec6.c
> +++ b/drivers/pci/host/pcie-artpec6.c
> @@ -191,8 +191,8 @@ static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
>  	return dw_handle_msi_irq(pp);
>  }
>  
> -static int __init artpec6_add_pcie_port(struct pcie_port *pp,
> -					struct platform_device *pdev)
> +static int artpec6_add_pcie_port(struct pcie_port *pp,
> +				 struct platform_device *pdev)
>  {
>  	int ret;
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
