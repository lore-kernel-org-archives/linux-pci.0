Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37915 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbaGBWYl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jul 2014 18:24:41 -0400
Received: by mail-ie0-f179.google.com with SMTP id tr6so10163284ieb.10
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2014 15:24:40 -0700 (PDT)
Date: Wed, 2 Jul 2014 16:24:38 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: jg1.han@samsung.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] PCI: designware: Use IS_ENABLED()
Message-ID: <20140702222438.GE28852@google.com>
References: <1403104613-9867-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403104613-9867-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 18, 2014 at 12:16:53PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We can get rid of the 'ifdef' by using the IS_ENABLED() macro.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with Jingoo and Mohit's acks to pci/host-designware for v3.17,
thanks!

> ---
>  drivers/pci/host/pcie-designware.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 1eaf4df3..dc842fd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -497,9 +497,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  
>  	pci_common_init_dev(pp->dev, &dw_pci);
>  	pci_assign_unassigned_resources();
> -#ifdef CONFIG_PCI_DOMAINS
> -	dw_pci.domain++;
> -#endif
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS))
> +		dw_pci.domain++;
>  
>  	return 0;
>  }
> -- 
> 1.8.3.2
> 
