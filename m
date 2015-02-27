Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:43366 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbB0AV4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 19:21:56 -0500
Received: by iebtr6 with SMTP id tr6so23297843ieb.10
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 16:21:55 -0800 (PST)
Date: Thu, 26 Feb 2015 18:21:51 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, tinamdar@apm.com
Subject: Re: [PATCH] pci: host: xgene: fix incorrectly returned address by
 map_bus
Message-ID: <20150227002151.GG25765@google.com>
References: <1424214840-26498-1-git-send-email-fkan@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424214840-26498-1-git-send-email-fkan@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 17, 2015 at 03:14:00PM -0800, Feng Kan wrote:
> The generic accessor functions for pci-xgene uses map_bus
> call that returns the base address but did not add the additional
> offset.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/pci/host/pci-xgene.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index aab5547..ee082c0 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>  	return false;
>  }
>  
> -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  			      int offset)
>  {
>  	struct xgene_pcie_port *port = bus->sysdata;
> @@ -137,7 +137,7 @@ static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  		return NULL;
>  
>  	xgene_pcie_set_rtdid_reg(bus, devfn);
> -	return xgene_pcie_get_cfg_base(bus);
> +	return xgene_pcie_get_cfg_base(bus) + offset;

Where's the locking here?  ECAM doesn't need locking because the
bus/dev/fn/offset is all encoded in the MMIO address.  But it looks
like X-Gene doesn't work that way and bus/dev/fn is in the RTDID register.

So it seems like X-Gene needs locking that not everybody needs.  Are you
relying on higher-level locking somewhere?

>  }
>  
>  static struct pci_ops xgene_pcie_ops = {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
