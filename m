Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:14844 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753540AbaCZKMl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 06:12:41 -0400
In-Reply-To: <5331B733.8090802@codethink.co.uk>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <1395766604-30926-3-git-send-email-phil.edworthy@renesas.com> <5331B733.8090802@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF62BCE896.5AFD55D6-ON80257CA7.0037C4A7-80257CA7.00381353@eu.necel.com>
Date: Wed, 26 Mar 2014 10:12:31 +0000
Subject: Re: [PATCH v5 2/9] PCI: host: rcar: Add MSI support
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ben,

On: 25/03/2014 17:05, Ben wrote:
> Subject: Re: [PATCH v5 2/9] PCI: host: rcar: Add MSI support
> 
> On 25/03/14 16:56, Phil Edworthy wrote:
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v5:
> >   - Return IRQ_NONE from MSI isr when there is no pending MSI
> >   - Add additional interrupt bindings
> > +
> > +static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
> > +{
> > +   struct device *dev = chip->chip.dev;
> > +
> > +   mutex_lock(&chip->lock);
> > +
> > +   if (!test_bit(irq, chip->used))
> > +      dev_err(dev, "trying to free unused MSI#%lu\n", irq);
> 
> Does the upper level not check for this?
Yes, the default_teardown_msi_irqs function checks for unused MSIs, so we 
don't really need to check here.


> > +   else
> > +      clear_bit(irq, chip->used);
> > +
> > +   mutex_unlock(&chip->lock);
> 
> 
> > +}
> > +
> > +static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
> > +{
> > +   struct rcar_pcie *pcie = data;
> > +   struct rcar_msi *msi = &pcie->msi;
> > +   unsigned long reg;
> > +
> > +   reg = pci_read_reg(pcie, PCIEMSIFR);
> > +
> > +   /* MSI & INTx share an interrupt - we only handle MSI here */
> > +   if (!reg)
> > +      return IRQ_NONE;
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
> 
> You may want to change this to something that is either rate-limited
> or is say debug level so it does not spam the console if something
> does go wrong.
I'll change that to debug level.

> Also the comment could easily be made one line
>    /* Weird, unknown MSI IRQ, just clear it */
Sure!

Thanks
Phil
