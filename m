Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:40885 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530AbbCFEzH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2015 23:55:07 -0500
Received: by oiba3 with SMTP id a3so15839212oib.7
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2015 20:55:06 -0800 (PST)
Date: Thu, 5 Mar 2015 22:54:56 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, tinamdar@apm.com
Subject: Re: [PATCH] pci: host: xgene: fix incorrectly returned address by
 map_bus
Message-ID: <20150306045456.GC20077@google.com>
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

Applied to for-linus for v4.0, with acks from Tanmay and Rob.  Thanks!

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
