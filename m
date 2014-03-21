Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:39182 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751786AbaCUOPq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 10:15:46 -0400
In-Reply-To: <1395400638.4554.5.camel@weser.hi.pengutronix.de>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>	 <1395397968-6242-3-git-send-email-phil.edworthy@renesas.com> <1395400638.4554.5.camel@weser.hi.pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OFFBE32003.3827BA14-ON80257CA2.004D7C1E-80257CA2.004E5338@eu.necel.com>
Date: Fri, 21 Mar 2014 14:15:32 +0000
Subject: Re: [PATCH v4 2/9] PCI: host: rcar: Add MSI support
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

Thanks for the review.

On 21/03/2014 11:18, Lucas wrote:
> Subject: Re: [PATCH v4 2/9] PCI: host: rcar: Add MSI support
> 
> Am Freitag, den 21.03.2014, 10:32 +0000 schrieb Phil Edworthy:
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  drivers/pci/host/pcie-rcar.c | 232 
++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/host/pcie-rcar.h |   5 +
> >  2 files changed, 236 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pcie-rcar.c 
b/drivers/pci/host/pcie-rcar.c
> > index 16670e5..cbbcd77 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> [...]
> > +
> > +static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
> > +{
> > +   struct rcar_pcie *pcie = data;
> > +   struct rcar_msi *msi = &pcie->msi;
> > +   unsigned long reg;
> > +
> > +   reg = pci_read_reg(pcie, PCIEMSIFR);
> > +
> > +   while (reg) {
> > +      unsigned int index = find_first_bit(&reg, 32);
> > +      unsigned int irq;
> > +
> > +      /* clear the interrupt */
> > +      pci_write_reg(pcie, 1 << index, PCIEMSIFR);
> > +
> > +      irq = irq_find_mapping(msi->domain, index);
> > +      if (irq) {
> > +         if (test_bit(index, msi->used))
> > +            generic_handle_irq(irq);
> > +         else
> > +            dev_info(pcie->dev, "unhandled MSI\n");
> > +      } else {
> > +         /*
> > +          * that's weird who triggered this?
> > +          * just clear it
> > +          */
> > +         dev_info(pcie->dev, "unexpected MSI\n");
> > +      }
> > +
> > +      /* see if there's any more pending in this vector */
> > +      reg = pci_read_reg(pcie, PCIEMSIFR);
> > +   }
> > +
> > +   return IRQ_HANDLED;
> > +}
> > +
> From your DT binding it seems you have only one interrupt from the PCIe
> core, shared between the MSI irqs and the PCI legacy interrupts.
> This means this handler may get called without an MSI irq pending, so
> this function really should have a path where it's returning IRQ_NONE.
Ah, yes you are right... though actually there are two interrupts, one has 
some MSI and INTx, the other has the rest of the MSIs.

> Regards,
> Lucas
> 
> -- 
> Pengutronix e.K.                           | Lucas Stach |
> Industrial Linux Solutions                 | http://www.pengutronix.de/ 
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 
|
> 

Thanks
Phil
