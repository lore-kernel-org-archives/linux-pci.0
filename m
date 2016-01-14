Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58359 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbcANTUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jan 2016 14:20:31 -0500
Message-ID: <1452799229.14628.56.camel@redhat.com>
Subject: Re: [RFC PATCH] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
From: Alex Williamson <alex.williamson@redhat.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	sean.stalley@intel.com, david.daney@cavium.com
Date: Thu, 14 Jan 2016 12:20:29 -0700
In-Reply-To: <5697EEF8.30406@caviumnetworks.com>
References: <20160114172645.23429.9938.stgit@gimli.home>
	 <5697EEF8.30406@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-01-14 at 10:54 -0800, David Daney wrote:
> On 01/14/2016 09:26 AM, Alex Williamson wrote:
> > We've done a pretty good job of abstracting EA from drivers, but
> > there
> > are some properties of BAR Equivalent resources that don't really
> > jive
> > with traditional PCI BARs.  In particular, natural alignment is
> > only
> > encouraged, not required.
> > 
> > Why does this matter?  There are drivers like vfio-pci that will
> > happily gobble up the EA abstraction that's been implemented and
> > expose a device using EA to userspace as if those resources are
> > traditional BARs.  Pretty cool.  The vfio API is bus agnostic, so
> > it
> > doesn't care about alignment.  The problem comes with PCI config
> > space
> > emulation where we don't let userspace manipulate the BAR value,
> > but
> > we do emulate BAR sizing.  The abstraction kind of falls apart if
> > userspace gets garbage when they try to size what appears to be a
> > traditional BAR, but is actually a BAR equivalent.
> > 
> > We could simply round up the size in vfio to make it naturally
> > aligned, but then we're imposing artificial sizes to the user and
> > we
> > have the discontinuity that BAR size emulation and vfio region size
> > reporting don't agree on the size.  I think what we want to do is
> > expose EA to the user, reporting traditional BARs with BEIs as
> > zero-sized and providing additional regions for the user to access
> > each EA region, whether it has a BEI or not.
> > 
> > To facilitate that, a flag indicating whether a PCI resource is a
> > traditional BAR or BAR equivalent seems much nicer than attempting
> > to size the BAR ourselves or deducing it through the EA capability.
> > 
> > Thoughts?
> 
> Is the flag exposed to userspace in any way?
> 
> I haven't dug into what uses the flags.
> 
> One problem we have seen is with the lspci utility which cannot 
> distinguish between SROIV BARs and EA provisioned BARs.
> 
> Would, or could, this be used there?

Perhaps so, the flags would be exposed in sysfs in
/sys/bus/pci/devices/<device>/resource.  Three fields are printed for
each resource: start, end, and flags.  That's definitely something
lspci could consume.  Thanks,

Alex

> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >   drivers/pci/pci.c      |    2 +-
> >   include/linux/ioport.h |    2 ++
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 314db8c..174c734 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
> > 
> >   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> >   {
> > -	unsigned long flags = IORESOURCE_PCI_FIXED;
> > +	unsigned long flags = IORESOURCE_PCI_FIXED |
> > IORESOURCE_PCI_EA_BEI;
> > 
> >   	switch (prop) {
> >   	case PCI_EA_P_MEM:
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 24bea08..5acc194 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -105,6 +105,8 @@ struct resource {
> >   /* PCI control bits.  Shares IORESOURCE_BITS with above PCI
> > ROM.  */
> >   #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do
> > not move resource */
> > 
> > +/* PCI Enhanced Allocation defined BAR equivalent resource */
> > +#define IORESOURCE_PCI_EA_BEI		(1<<5)
> > 
> >   /* helpers to define resources */
> >   #define DEFINE_RES_NAMED(_start, _size, _name, _flags)		
> > 	\
> > 
> 

