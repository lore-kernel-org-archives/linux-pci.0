Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdEFMpg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 6 May 2017 08:45:36 -0400
Date: Sat, 6 May 2017 13:45:30 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: <kishon@ti.com>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [RFC] pci: using new interrupt API to enable MSI and MSI-X
Message-ID: <20170506134530.73e014c0@why.wild-wind.fr.eu.org>
In-Reply-To: <6617cd15-5d79-cad8-879b-a8c953ba9a41@synopsys.com>
References: <806903036508ae5246084cbc3b796083d76f8917.1493992929.git.jpinto@synopsys.com>
        <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
        <6617cd15-5d79-cad8-879b-a8c953ba9a41@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 5 May 2017 16:54:30 +0100
Joao Pinto <Joao.Pinto@synopsys.com> wrote:

> Mark,
> 
> Às 3:57 PM de 5/5/2017, Marc Zyngier escreveu:
> > Joao,
> > 
> > On 05/05/17 15:11, Joao Pinto wrote:  
> 
> snip (...)
> 
> > It looks to me like the first mistake is just above. You don't seem to
> > propagate the mask/unmask operations into the parent domain, so your
> > interrupts are never enabled... You'd need something like this:
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index 28ed32ba4f1b..d42b8b12f168 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -45,12 +45,22 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> >  	return dw_pcie_write(pci->dbi_base + where, size, val);
> >  }
> >  
> > +static void dw_msi_mask_irq(struct irq_data *d)
> > +{
> > +	pci_msi_mask_irq(d);
> > +	irq_chip_mask_parent(d);
> > +}
> > +
> > +static void dw_msi_unmask_irq(struct irq_data *d)
> > +{
> > +	pci_msi_unmask_irq(d);
> > +	irq_chip_unmask_parent(d);
> > +}
> > +
> >  static struct irq_chip dw_msi_irq_chip = {
> >  	.name = "PCI-MSI",
> > -	.irq_enable = pci_msi_unmask_irq,
> > -	.irq_disable = pci_msi_mask_irq,
> > -	.irq_mask = pci_msi_mask_irq,
> > -	.irq_unmask = pci_msi_unmask_irq,
> > +	.irq_mask = dw_msi_mask_irq,
> > +	.irq_unmask = dw_msi_unmask_irq,
> >  };
> > 
> > I haven't dug any further, but this should be fixed first.
> > 
> > Thanks,
> > 
> > 	M.
> >   
> 
> I added the changes that you suggested and firstly it crashed, and then I found
> out that in the domain parent structure (dw_pci_msi_bottom_irq_chip) did not
> have irq_mask and irq_unmask functions. I put it like this, just for testing:
> 
> static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> 	.name			= "DW MSI",
> 	.irq_compose_msi_msg	= dw_pci_compose_msi_msg,
> 	.irq_set_affinity	= dw_pci_msi_set_affinity,
> +	.irq_mask		= pci_msi_mask_irq,
> +	.irq_unmask		= pci_msi_unmask_irq,
> };
> 
> Maybe irq_mask and irq_unmask should not be pci_msi_mask_irq /
> pci_msi_unmask_irq, but I did not find any existing case that needed it. Do we
> have any documentation about IRQ domains that I can check?

We have some documentation in Documentation/IRQ-domain.txt, though it
is old an incomplete. But there is enough there to show you your
mistake. You have two domains:

Top level domain: the PCI-MSI domain, in charge of the PCI-specific
stuff, and particularly the masking/unmasking of MSIs. That's the
purpose of the patch above.

Bottom domain: your DW-MSI domain, which is only concerned with the
details of your piece of HW. Obviously, calling pci_msi*irq is wrong
there, since it is already called by the top level domain, and is
hardly HW specific.

So what you need there is the code that masks/unmasks an MSI for your
HW, and nothing else.

> 
> Interrupts
>  45:          0   PCI-MSI   0  aerdrv
>  46:          0   PCI-MSI 524288  xhci_hcd
> 
> The MSI seems to be well configured in the Bridge and in the Endpoint, so some
> glue is missing in the driver.

Yup, see above.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
