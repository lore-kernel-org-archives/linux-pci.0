Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbaG1OTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Jul 2014 10:19:30 -0400
Message-ID: <1406557161.1011.36.camel@ul30vt.home>
Subject: Re: [PATCH v1 1/3] PCI: export pci_get_dma_device() helper to other
 users
From: Alex Williamson <alex.williamson@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Date: Mon, 28 Jul 2014 08:19:21 -0600
In-Reply-To: <1406539595.8530.20.camel@smile.fi.intel.com>
References: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1406307516.1011.21.camel@ul30vt.home>
	 <1406539595.8530.20.camel@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-07-28 at 12:26 +0300, Andy Shevchenko wrote:
> On Fri, 2014-07-25 at 10:58 -0600, Alex Williamson wrote:
> > On Fri, 2014-07-25 at 16:31 +0300, Andy Shevchenko wrote:
> > > Some chipsets use the function 0 for DMA on other functions of a
> > > multifunctional device. One of the example is Intel EG20T PCH. This is also
> > > applicable to Lynxpoint PCH when LPSS devices are switched to PCI mode.
> > > 
> > > This patch exports a useful helper to get a device of the DMA. This device is
> > > needed to request a DMA channel from a proper controller.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/pci/quirks.c | 2 +-
> > >  include/linux/pci.h  | 9 +++++++++
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 80c2d01..8352e5b 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3517,7 +3517,7 @@ static struct pci_dev *pci_func_0_dma_source(struct pci_dev *dev)
> > >  	if (!PCI_FUNC(dev->devfn))
> > >  		return pci_dev_get(dev);
> > >  
> > > -	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > > +	return pci_get_dma_device(dev);
> > >  }
> > >  
> > >  static const struct pci_dev_dma_source {
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 61978a4..86caab7 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1575,6 +1575,15 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
> > >  static inline void pci_dev_specific_enable_acs(struct pci_dev *dev) { }
> > >  #endif
> > >  
> > > +/*
> > > + * Some chipsets use the function 0 for DMA on other functions of a
> > > + * multifunctional device.
> > > + */
> > > +static inline struct pci_dev *pci_get_dma_device(struct pci_dev *dev)
> > > +{
> > > +	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> > > +}
> > > +
> > >  void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
> > >  void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
> > >  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> > 
> > You've created a very generic function for a very specific problem.  I
> > can't just call this on any random device and expect it to work
> > correctly.
> 
> Right.
> 
> >   What about all the other device which use function 1 for
> > their DMA alias.
> 
> Hmm... I would like to understand what the difference between DMA alias
> and the case when we have MFD where function 0 is real DMA controller
> which serves the other devices in that block is?

There is no difference, the PCI DMA alias code is meant to handle any
case where the requester ID of a DMA is different from the device that
actually initiates the DMA.  That may be a different function on a MFD,
it may be a non-existent devfn, or it may be an upstream device.  Note
that using function 0 as the DMA controller for other functions of a MFD
is a broken design in a world of IOMMUs.  It means that we cannot
distinguish transactions from different functions and we need to
pre-enable these aliases for the device to work correctly.  There's
nothing in the PCIe spec that allows an MFD to use the wrong requester
ID for DMA.

> Another (probably minor) question, why do you still have
> pci_get_dma_source() function in quirks.c?

It's in the process of being removed https://lkml.org/lkml/2014/5/22/725

> >   We've just added infrastructure in PCI to support DMA
> > aliases, see pci_for_each_dma_alias().  Please use this instead.  Quirks
> > can be added to set the dma_alias_devfn and
> > PCI_DEV_FLAGS_DMA_ALIAS_DEVFN to indicate that it's valid.  Thanks,
> 
> Do you mean I have to list all devices that, for example, are listed in
> the spi-topcliff-pch.c?

I'm not sure how you'll incorporate it, but creating a
pci_get_dma_device() helper which assumes a specific broken relationship
for DMA is clearly not a supportable solution.  Thanks,

Alex

