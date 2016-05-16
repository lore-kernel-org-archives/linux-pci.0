Return-Path: <sean.stalley@intel.com>
Return-Path: <sean.stalley@intel.com>
From: "Stalley, Sean" <sean.stalley@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"david.daney@cavium.com" <david.daney@cavium.com>
Subject: RE: [PATCH v4 1/2] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
Date: Mon, 16 May 2016 22:07:54 +0000
Message-ID: <5FE5E296BC647B42A2509AB982F88C1322A9FB06@ORSMSX116.amr.corp.intel.com>
References: <1455238345-5602-1-git-send-email-sean.stalley@intel.com>
 <1455238345-5602-2-git-send-email-sean.stalley@intel.com>
 <20160516203144.GC20759@localhost>
In-Reply-To: <20160516203144.GC20759@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Thanks Bjorn & Martin!

-Sean

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Monday, May 16, 2016 1:32 PM
> To: Stalley, Sean <sean.stalley@intel.com>
> Cc: linux-pci@vger.kernel.org; mj@ucw.cz; bhelgaas@google.com;
> alex.williamson@redhat.com; david.daney@cavium.com
> Subject: Re: [PATCH v4 1/2] pci: Identify Enhanced Allocation (EA) BAR
> Equivalent resources
>=20
> On Thu, Feb 11, 2016 at 04:52:24PM -0800, Sean O. Stalley wrote:
> > From: Alex Williamson <alex.williamson@redhat.com>
> >
> > Resource flags are exposed to userspace via the sysfs "resource" file.
> > lspci reads the sysfs file to determine resource properties.
> > Adding this flag allows lspci to distinguish between [virtual] and
> > [enhanced] resources.
> >
> > If the resource is not aligned, userspace could deduce where the
> > resource is EA based on the size & address fields.
> > However, a flag indicating whether a PCI resource is a traditional BAR
> > or BAR equivalent seems like a much simpler solution and works if the
> > EA resource is aligned.
> >
> > Although this patchset only improves lspci, other uses for this flag
> > have been identified. For example, vfio makes assumptions about
> > alignment and sizing, and runs into problems when attempting to
> > emulate a BAR Equivalent EA resource.
> >
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
>=20
> I applied this to pci/resource and intend to merge it for v4.7.
>=20
> > ---
> >  drivers/pci/pci.c      | 2 +-
> >  include/linux/ioport.h | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > d1a7105..8ff678c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2229,7 +2229,7 @@ void pci_pm_init(struct pci_dev *dev)
> >
> >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)  {
> > -	unsigned long flags =3D IORESOURCE_PCI_FIXED;
> > +	unsigned long flags =3D IORESOURCE_PCI_FIXED |
> IORESOURCE_PCI_EA_BEI;
> >
> >  	switch (prop) {
> >  	case PCI_EA_P_MEM:
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h index
> > 24bea08..88816f9 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -25,7 +25,11 @@ struct resource {
> >
> >  /*
> >   * IO resources have these defined flags.
> > + *
> > + * PCI devices expose these flags to userspace in the "resource"
> > + sysfs file,
> > + * Moving them around could break stuff, so don't do it.
> >   */
> > +
> >  #define IORESOURCE_BITS		0x000000ff	/* Bus-specific bits */
> >
> >  #define IORESOURCE_TYPE_BITS	0x00001f00	/* Resource type */
> > @@ -97,6 +101,7 @@ struct resource {
> >  #define IORESOURCE_IO_SPARSE		(1<<2)
> >
> >  /* PCI ROM control bits (IORESOURCE_BITS) */
> > +
> >  #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled,
> same as PCI_ROM_ADDRESS_ENABLE */
> >  #define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at
> C000:0 */
> >  #define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy,
> resource field overlaid */
> > @@ -105,6 +110,8 @@ struct resource {
> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> >  #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move
> resource */
> >
> > +/* PCI Enhanced Allocation defined BAR equivalent resource */
> > +#define IORESOURCE_PCI_EA_BEI		(1<<5)
> >
> >  /* helpers to define resources */
> >  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)
> 	\
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
