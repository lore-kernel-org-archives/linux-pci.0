Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41815 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635AbcECQvE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 May 2016 12:51:04 -0400
Date: Tue, 3 May 2016 11:50:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, bhelgaas@google.com, jszhang@marvell.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] PCI: dra7xx: program outbound atu with correct address
Message-ID: <20160503165059.GB30040@localhost>
References: <1462200880-30129-1-git-send-email-niklass@axis.com>
 <20160502210933.GM24851@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160502210933.GM24851@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 02, 2016 at 04:09:33PM -0500, Bjorn Helgaas wrote:
> On Mon, May 02, 2016 at 04:54:40PM +0200, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@axis.com>
> > 
> > commit 1488aefa37a4 ("PCI: designware: Move Root Complex
> > setup code to dw_pcie_setup_rc()") broke dra7xx
> > by moving code from dw_pcie_host_init to dw_pcie_setup_rc.
> > 
> > Fix this by doing the cpu to bus calculation before calling
> > dw_pcie_setup_rc.
> > 
> > Fixes: 1488aefa37a4 ("PCI: designware: Move Root Complex setup code to dw_pcie_setup_rc()")
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/host/pci-dra7xx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> > index 2ca3a1f..f441130 100644
> > --- a/drivers/pci/host/pci-dra7xx.c
> > +++ b/drivers/pci/host/pci-dra7xx.c
> > @@ -142,13 +142,13 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
> >  
> >  static void dra7xx_pcie_host_init(struct pcie_port *pp)
> >  {
> > -	dw_pcie_setup_rc(pp);
> > -
> >  	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> >  	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> >  	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> >  	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> >  
> > +	dw_pcie_setup_rc(pp);
> 
> This looks correct to me.  Prior to 1488aefa37a4, we had this path,
> which applied the dra7xx mem_base adjustment before programming the
> outbound ATU:
> 
>   dra7xx_add_pcie_port
>     dw_pcie_host_init
>       pp->mem_base = pp->mem->start                 # <-- set pp->mem_base
>       ops->host_init
>       dra7xx_pcie_host_init                         # .host_init
>         dw_pcie_setup_rc
>         pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR      # <-- update pp->mem_base
>       dw_pcie_prog_outbound_atu(pp->mem_base)       # <-- use pp->mem_base
> 
> After 1488aefa37a4, we have this:
> 
>   dra7xx_add_pcie_port
>     dw_pcie_host_init
>       pp->mem_base = pp->mem->start                 # <-- set pp->mem_base
>       ops->host_init
>       dra7xx_pcie_host_init                         # .host_init
>         dw_pcie_setup_rc
>           dw_pcie_prog_outbound_atu(pp->mem_base)   # <-- use pp->mem_base
>         pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR      # <-- update pp->mem_base
> 
> So the dra7xx update is applied after we've already used it.
> 
> If you agree, Kishon, I'll fold Niklas's fix into Jisheng's patch so
> there's no bisection hole for dra7xx.

I merged this (folded into Jisheng's patch on the pci/host-designware
branch, and included in my "next" branch).

Please let me know if it works for you, Niklas, or if you see any
problems.

> >  	dra7xx_pcie_establish_link(pp);
> >  	if (IS_ENABLED(CONFIG_PCI_MSI))
> >  		dw_pcie_msi_init(pp);
> > -- 
> > 2.1.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
