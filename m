Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34729 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbcJRQaw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2016 12:30:52 -0400
Received: by mail-qk0-f193.google.com with SMTP id n189so17262693qke.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2016 09:30:51 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Lucas Stach'" <l.stach@pengutronix.de>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "'Pratyush Anand'" <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>,
        "'Gary Bisson'" <gary.bisson@boundarydevices.com>,
        <kernel@pengutronix.de>, <patchwork-lst@pengutronix.de>
References: <20161018082549.10905-1-l.stach@pengutronix.de>
In-Reply-To: <20161018082549.10905-1-l.stach@pengutronix.de>
Subject: Re: [PATCH resend] PCI: designware: fix register access before host init
Date: Tue, 18 Oct 2016 12:30:49 -0400
Message-ID: <000001d2295c$fcfdfec0$f6f9fc40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 18, 2016 4:26 AM, Lucas Stach wrote:
>
> The function used to determine if iATU unroll is available will read a RC
register.
> This is not possible and will result in a system hang if the RC is still
in reset,
>  so it is only safe to call this function after host_init() has been
called.
>
> Fixes: a0601a470537 (PCI: designware: Add iATU Unroll feature)
> Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

It looks good!

Acked-by: Jingoo Han <jigoohan1@gmail.com>


> ---
>  drivers/pci/host/pcie-designware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c
b/drivers/pci/host/pcie-designware.c
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


