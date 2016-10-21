Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755700AbcJUPbr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 11:31:47 -0400
Date: Fri, 21 Oct 2016 10:31:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH resend] PCI: designware: fix register access before host
 init
Message-ID: <20161021153142.GB9007@localhost>
References: <20161018082549.10905-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161018082549.10905-1-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 18, 2016 at 10:25:49AM +0200, Lucas Stach wrote:
> The function used to determine if iATU unroll is available will read
> a RC register. This is not possible and will result in a system hang
> if the RC is still in reset, so it is only safe to call this function
> after host_init() has been called.

I'm sure Joao tested a0601a470537 somewhere, so I assume this hang only
happens on certain systems?

I'm wondering if this is suggesting something that's currently done
differently across the drivers but could be done more similarly.

> Fixes: a0601a470537 (PCI: designware: Add iATU Unroll feature)
> Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pcie-designware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 035f50c03281..74510508fafc 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> -
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
>  
> +	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> +
>  	pp->root_bus_nr = pp->busn->start;
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
