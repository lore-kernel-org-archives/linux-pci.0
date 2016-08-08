Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38932 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbcHHXT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 19:19:28 -0400
Date: Mon, 8 Aug 2016 18:19:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
	Matthew Minter <matt@masarand.com>
Subject: Re: [RFC] pci: Provide a domain limited version of pdev_fixup_irq
Message-ID: <20160808231922.GA7259@localhost>
References: <1467978595-25386-1-git-send-email-phil.edworthy@renesas.com>
 <20160721093514.GA7982@red-moon>
 <HK2PR0601MB1393B3642136B01087628DC9F51B0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HK2PR0601MB1393B3642136B01087628DC9F51B0@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Matthew]

On Mon, Aug 08, 2016 at 09:31:05AM +0000, Phil Edworthy wrote:
> Hi Lorenzo,
> 
> Thanks for the link, I'll wait to see how this pans out.

I'm not sure anything is happening there.  Last time I looked
(http://lkml.kernel.org/r/20151223230433.GA27708@localhost), I thought
there were some issues.

>From Lorenzo's response, it sounds like he thought maybe I should
apply it anyway, but I dropped the ball and haven't done anything with
it.

I'll take another look at it.

> > -----Original Message-----
> > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> > owner@vger.kernel.org] On Behalf Of Lorenzo Pieralisi
> > Sent: 21 July 2016 10:35
> > To: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-
> > renesas-soc@vger.kernel.org
> > Subject: Re: [RFC] pci: Provide a domain limited version of pdev_fixup_irq
> > 
> > Hi Phil,
> > 
> > On Fri, Jul 08, 2016 at 12:49:55PM +0100, Phil Edworthy wrote:
> > > Hi Bjorn,
> > >
> > > I've marked this as RFC as I guess there might be a better way to do
> > > this, but I'm not sure how. I would appreciate your thoughts on this.
> > 
> > There is a more generic solution to this issue, that has been
> > hanging in the balance for a while:
> > 
> > http://marc.info/?l=linux-pci&m=144557674601373&w=2
> > 
> > We should bring it to completion since pci_fixup_irqs() should
> > really be replaced, this is just another example of the bugs
> > it can trigger.
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks
> > > Phil
> > >
> > > ---
> > > pdev_fixup_irq() performs interrupt swizzling on all PCI devices,
> > > no matter that the device may be on a completely unrelated PCI
> > > Host controller.
> > >
> > > When you have multiple PCI Host controllers, pdev_fixup_irq() can
> > > clobber the dev->irq of devices it should not be changing.
> > > This has been seen when performing suspend/resume on boards with
> > > two R-Car PCIe Host controllers, resulting in a NULL ptr access
> > > in __pci_restore_msi_state. This happens because dev->irq has been
> > > overwritten with 0, and irq_get_msi_desc(dev->irq) returns NULL.
> > >
> > > This patch introduces a new function, pci_fixup_irqs_local(), that
> > > performs the same operation as pdev_fixup_irq(), but only changes
> > > the dev->irq of device on the same domain.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > ---
> > >  drivers/pci/setup-irq.c | 25 ++++++++++++++++++++++---
> > >  include/linux/pci.h     |  3 +++
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> > > index 95c225b..90ea8fa 100644
> > > --- a/drivers/pci/setup-irq.c
> > > +++ b/drivers/pci/setup-irq.c
> > > @@ -22,7 +22,8 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int
> > irq)
> > >  	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> > >  }
> > >
> > > -static void pdev_fixup_irq(struct pci_dev *dev,
> > > +static void pdev_fixup_irq(int domain_nr,
> > > +			   struct pci_dev *dev,
> > >  			   u8 (*swizzle)(struct pci_dev *, u8 *),
> > >  			   int (*map_irq)(const struct pci_dev *, u8, u8))
> > >  {
> > > @@ -48,8 +49,15 @@ static void pdev_fixup_irq(struct pci_dev *dev,
> > >  		if (irq == -1)
> > >  			irq = 0;
> > >  	}
> > > -	dev->irq = irq;
> > > +	/* Since pci_fixup_irqs() can be called more than once due to multiple
> > > +	 * host controllers, and we scan all PCI devices, not just those
> > > +	 * attached to this controller, make sure we don't clobber dev->irq
> > > +	 * that has nothing to do with this domain.
> > > +	 */
> > > +	if (domain_nr >= 0 && dev->bus->domain_nr != domain_nr)
> > > +		return;
> > >
> > > +	dev->irq = irq;
> > >  	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
> > >
> > >  	/* Always tell the device, so the driver knows what is
> > > @@ -63,6 +71,17 @@ void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
> > >  	struct pci_dev *dev = NULL;
> > >
> > >  	for_each_pci_dev(dev)
> > > -		pdev_fixup_irq(dev, swizzle, map_irq);
> > > +		pdev_fixup_irq(-1, dev, swizzle, map_irq);
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_fixup_irqs);
> > > +
> > > +void pci_fixup_irqs_local(struct pci_bus *bus,
> > > +		    u8 (*swizzle)(struct pci_dev *, u8 *),
> > > +		    int (*map_irq)(const struct pci_dev *, u8, u8))
> > > +{
> > > +	struct pci_dev *dev = NULL;
> > > +
> > > +	for_each_pci_dev(dev)
> > > +		pdev_fixup_irq(bus->domain_nr, dev, swizzle, map_irq);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_fixup_irqs_local);
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 8badb66..37a97df 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1134,6 +1134,9 @@ void pdev_enable_device(struct pci_dev *);
> > >  int pci_enable_resources(struct pci_dev *, int mask);
> > >  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
> > >  		    int (*)(const struct pci_dev *, u8, u8));
> > > +void pci_fixup_irqs_local(struct pci_bus *,
> > > +		    u8 (*)(struct pci_dev *, u8 *),
> > > +		    int (*)(const struct pci_dev *, u8, u8));
> > >  #define HAVE_PCI_REQ_REGIONS	2
> > >  int __must_check pci_request_regions(struct pci_dev *, const char *);
> > >  int __must_check pci_request_regions_exclusive(struct pci_dev *, const char
> > *);
> > > --
> > > 2.5.0
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
