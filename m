Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:32865 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab3EFVem (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 May 2013 17:34:42 -0400
Message-ID: <1367876070.15842.60.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc/powernv: Don't configure IO window on PHB3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	yinghai@kernel.org, bhelgaas@google.com
Date: Tue, 07 May 2013 07:34:30 +1000
In-Reply-To: <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
	 <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-05-06 at 21:44 +0800, Gavin Shan wrote:
> We needn't configure IO windows for the corresponding PEs on PHB3
> since that doesn't support IO.

Here too, no need for such a flag, just check that
pci_controller->io_resource.flags is 0.

BTW. Please work on top of the patch I sent already that avoids adding
bogus resources to pci_host_bridge when their flags are 0. I'll send
it to Linus today.

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 0c3fa29..b4f3edb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -894,7 +894,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>  		    res->start > res->end)
>  			continue;
>  
> -		if (res->flags & IORESOURCE_IO) {
> +		/* We needn't setup IO windows for PHB3 */
> +		if (!(pe->pbus->bus_flags & PCI_BUS_FLAGS_NO_IO) &&
> +		    res->flags & IORESOURCE_IO) {
>  			region.start = res->start - phb->ioda.io_pci_base;
>  			region.end   = res->end - phb->ioda.io_pci_base;
>  			index = region.start / phb->ioda.io_segsize;


