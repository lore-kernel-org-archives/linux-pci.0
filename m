Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16329 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbcANU1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jan 2016 15:27:19 -0500
Date: Thu, 14 Jan 2016 12:23:47 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	david.daney@cavium.com
Subject: Re: [RFC PATCH] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
Message-ID: <20160114202347.GB3381@sean.stalley.intel.com>
References: <20160114172645.23429.9938.stgit@gimli.home>
 <20160114183452.GA3075@sean.stalley.intel.com>
 <1452798962.14628.52.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1452798962.14628.52.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 14, 2016 at 12:16:02PM -0700, Alex Williamson wrote:
> On Thu, 2016-01-14 at 10:34 -0800, Sean O. Stalley wrote:
> > On Thu, Jan 14, 2016 at 10:26:56AM -0700, Alex Williamson wrote:
> > > We've done a pretty good job of abstracting EA from drivers, but
> > > there
> > > are some properties of BAR Equivalent resources that don't really
> > > jive
> > > with traditional PCI BARs.  In particular, natural alignment is
> > > only
> > > encouraged, not required.
> > > 
> > > Why does this matter?  There are drivers like vfio-pci that will
> > > happily gobble up the EA abstraction that's been implemented and
> > > expose a device using EA to userspace as if those resources are
> > > traditional BARs.  Pretty cool.  The vfio API is bus agnostic, so
> > > it
> > > doesn't care about alignment.  The problem comes with PCI config
> > > space
> > > emulation where we don't let userspace manipulate the BAR value,
> > > but
> > > we do emulate BAR sizing.  The abstraction kind of falls apart if
> > > userspace gets garbage when they try to size what appears to be a
> > > traditional BAR, but is actually a BAR equivalent.
> > > 
> > > We could simply round up the size in vfio to make it naturally
> > > aligned, but then we're imposing artificial sizes to the user and
> > > we
> > > have the discontinuity that BAR size emulation and vfio region size
> > > reporting don't agree on the size.  I think what we want to do is
> > > expose EA to the user, reporting traditional BARs with BEIs as
> > > zero-sized and providing additional regions for the user to access
> > > each EA region, whether it has a BEI or not.
> > > 
> > > To facilitate that, a flag indicating whether a PCI resource is a
> > > traditional BAR or BAR equivalent seems much nicer than attempting
> > > to size the BAR ourselves or deducing it through the EA capability.
> > 
> > If vfio does size the resource, EA entries that are aligned could
> > still be emulated as BARs, correct?
> > 
> > I would think that emulating a BAR would be preferred when possible,
> > for backwards-compatibility.
> 
> If a BEI is naturally aligned, I can't think of any problems with
> exposing it as a traditional BAR to userspace.  I agree that there may
> be some compatibility benefits there, so it may be useful to offer both
> options.  I don't think we can combine them though, it would violate
> the EA spec to expose the traditional BAR and and the matching BEI.
> We'd either need to hide the fake BAR or hide the EA entry defining
> that BEI.  A module option could define which is preferred or maybe an
> ioctl.

Would any functionality be lost if vfio:
	- emulates BARs & hide EA entry when EA resources are aligned.
	- exposes EA entries when the resources aren't aligned (no BAR emulation).
?

I'm just wondering if giving userspace the option to pick is necessary,
or if there is a setting that is always ideal.

> > > Thoughts?
> > 
> > I like the idea of adding an EA flag.
> > 
> > There were some cases in the kernel where it would be nice to know if a
> > resource was fixed because it was EA or if something else was fixing it.
> > Adding that flag was discussed during the code review of the EA code,
> > but it was decided that we could get by without it.
> > 
> > IIRC, most of the cases that required the flag had to do with EA entries
> > for bridges. Since bridge support wasn't added, we didn't need the flag.
> 
> By my reading of the spec, not all BEIs need to be fixed, is this just
> a simplification to avoid sizing and mapping a BAR that doesn't exist
> in the traditional sense?  A flag on the resource seems like it would
> be useful for that as well if we ever wanted to add the case where an
> AE BAR equivalent could be remapped.  Thanks,

All of the usable BEIs have a HwInit Base & MaxOffset, and therefore a
fixed range. The "unavailable for use" resources aren't explicitly HwInit,
but the spec doesn't define how/when you can move them.

The spec does define a writeable bit for resources,
but doesn't define how to use it either. I think the intention was to
be able to expand EA in the future to cover movable resources.

Anyway, I think having an explicit flag that says "This Resource is from EA"
that is independent of "This resource is fixed" is a good idea.


Acked-by: Sean O. Stalley <sean.stalley@intel.com>


Thanks,
Sean

> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  drivers/pci/pci.c      |    2 +-
> > >  include/linux/ioport.h |    2 ++
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 314db8c..174c734 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
> > >  
> > >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> > >  {
> > > -	unsigned long flags = IORESOURCE_PCI_FIXED;
> > > +	unsigned long flags = IORESOURCE_PCI_FIXED |
> > > IORESOURCE_PCI_EA_BEI;
> > >  
> > >  	switch (prop) {
> > >  	case PCI_EA_P_MEM:
> > > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > > index 24bea08..5acc194 100644
> > > --- a/include/linux/ioport.h
> > > +++ b/include/linux/ioport.h
> > > @@ -105,6 +105,8 @@ struct resource {
> > >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI
> > > ROM.  */
> > >  #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do
> > > not move resource */
> > >  
> > > +/* PCI Enhanced Allocation defined BAR equivalent resource *
> > > +#define IORESOURCE_PCI_EA_BEI		(1<<5)
> > >  
> > >  /* helpers to define resources */
> > >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)		
> > > 	\
> > > 
> 
