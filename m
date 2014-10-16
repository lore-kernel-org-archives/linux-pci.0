Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58430 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbaJPKjH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Oct 2014 06:39:07 -0400
Message-ID: <1413455945.2165.8.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v6 02/13] PCI: designware: Set func type of host init to
 int
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com
Date: Thu, 16 Oct 2014 12:39:05 +0200
In-Reply-To: <1413445963-24706-3-git-send-email-richard.zhu@freescale.com>
References: <1413445963-24706-1-git-send-email-richard.zhu@freescale.com>
	 <1413445963-24706-3-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 16.10.2014, 15:52 +0800 schrieb Richard Zhu:
> host init maybe failed, change the func type of host_init
> defined in struct pci_host_ops from void to int.
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>

NAK. You are breaking compilation within the series here. If you are
going to change the prototype the dependant changes need to be in the
same patch. So squash in at least patch 3-5 plus the imx6 change.

> ---
>  drivers/pci/host/pcie-designware.c | 7 +++++--
>  drivers/pci/host/pcie-designware.h | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index b1f82ff..1a2b477 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -578,8 +578,11 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	if (pp->ops->host_init)
> -		pp->ops->host_init(pp);
> +	if (pp->ops->host_init) {
> +		ret = pp->ops->host_init(pp);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>  
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index b0bfed0..57ab11d 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -72,7 +72,7 @@ struct pcie_host_ops {
>  	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>  			unsigned int devfn, int where, int size, u32 val);
>  	int (*link_up)(struct pcie_port *pp);
> -	void (*host_init)(struct pcie_port *pp);
> +	int (*host_init)(struct pcie_port *pp);
>  	void (*msi_set_irq)(struct pcie_port *pp, int irq);
>  	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
>  	u32 (*get_msi_data)(struct pcie_port *pp);


