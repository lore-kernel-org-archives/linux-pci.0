Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:52302 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbaJNSiz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:38:55 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn15so15822574igb.9
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:38:55 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:38:51 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/18] Delayed m68k setup of PCI IRQs to bus scan time
Message-ID: <20141014183851.GI10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-10-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-10-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:37AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> Currently PCI IRQs are assigned during mcf_pci_init which is only run
> at boot time, this causes devices which are connected after boot time
> to not receive an IRQ, this patch set fixes this by registering an IRQ
> assignment function to be run later at device enable time.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/m68k/platform/coldfire/pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/platform/coldfire/pci.c b/arch/m68k/platform/coldfire/pci.c
> index df96792..058ca86 100644
> --- a/arch/m68k/platform/coldfire/pci.c
> +++ b/arch/m68k/platform/coldfire/pci.c
> @@ -316,10 +316,16 @@ static int __init mcf_pci_init(void)
>  	rootbus->resource[0] = &mcf_pci_io;
>  	rootbus->resource[1] = &mcf_pci_mem;
>  
> -	pci_fixup_irqs(pci_common_swizzle, mcf_pci_map_irq);
>  	pci_bus_size_bridges(rootbus);
>  	pci_bus_assign_resources(rootbus);
>  	return 0;
>  }
>  
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->swizzle_irq = pci_common_swizzle;
> +	bridge->map_irq = mcf_pci_map_irq;
> +	return 0;
> +}
> +
>  subsys_initcall(mcf_pci_init);
> -- 
> 2.1.0
> 

Awesome, very nice and simple!
