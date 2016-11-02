Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Yuanzhichang
	<yuanzhichang@hisilicon.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com"
	<will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        John Garry
	<john.garry@huawei.com>,
        "zhichang.yuan02@gmail.com"
	<zhichang.yuan02@gmail.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "xuwei (O)"
	<xuwei5@hisilicon.com>
Subject: RE: [PATCH/RESEND V4 2/3] ARM64 LPC: Add missing range exception
 for special ISA
Date: Wed, 2 Nov 2016 21:51:08 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8E0398@lhreml507-mbx>
References: <1478006926-240933-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478006926-240933-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161101165934.GA5149@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161101165934.GA5149@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many Thanks for reviewing this

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 01 November 2016 17:00
> To: Yuanzhichang
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> bhelgaas@google.com; mark.rutland@arm.com; arnd@arndb.de; linux-arm-
> kernel@lists.infradead.org; lorenzo.pieralisi@arm.com; linux-
> kernel@vger.kernel.org; Linuxarm; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-serial@vger.kernel.org; minyard@acm.org;
> benh@kernel.crashing.org; liviu.dudau@arm.com; zourongrong@gmail.com;
> John Garry; Gabriele Paoloni; zhichang.yuan02@gmail.com;
> kantyzc@163.com; xuwei (O)
> Subject: Re: [PATCH/RESEND V4 2/3] ARM64 LPC: Add missing range
> exception for special ISA
>=20
> On Tue, Nov 01, 2016 at 09:28:45PM +0800, zhichang.yuan wrote:
> > Currently if the range property is not specified of_translate_one
> > returns an error. There are some special devices that work on a
> > range of I/O ports where it's is not correct to specify a range
> > property as the cpu addresses are used by special accessors.
> > Here we add a new exception in of_translate_one to return
> > the cpu address if the range property is not there. The exception
> > checks if the parent bus is ISA and if the special accessors are
> > defined.
>=20
> Using "()" after function names helps distinguish them from text.
>=20
> s/it's is/it's/

Sure we'll fix above nits in the next version

>=20
> I haven't been paying attention, so I missed the context.  But "as the
> cpu addresses are used by special accessors" doesn't really make sense
> to me.  In general, *most* acccessors use CPU addresses, i.e.,
> resource addresses.  Accessors don't use bus addresses because we may
> have multiple instances of a bus, and we may reuse bus address ranges
> on the different instances.

Basically our LPC device use a CPU address range (not a bus range as
a bus range is supposed to be remapped into a cpu range using the range
property).

This CPIU address range is [0, PCIBIOS_MIN_IO-1].
This patch effectively does 2 things:
1) reserve the cpu physical range [0, PCIBIOS_MIN_IO-1] so that it cannot
   be used by PCI I/O space (see drivers/pci/pci.c)

2) Avoid to translate the cpu addresses that belongs to LPC (in fact
   for this device we do not specify a range property in the DT): see
   changes in __of_translate_address()

3) Do not retrieve an I/O token for I/O addresses that belong to LPC
   (in fact LPC accessors work directly on the CPU physical addresses):
   see change in __of_address_to_resource()

Probably 1) and 3) can be put in a separate patch with respect to 2)...

What do you think?

>=20
> In the patch, I see a check for "parent bus is ISA"
> ("of_bus_isa_match(parent)"), but I don't see the check for whether
> the special accessors are defined, so I can't quite connect the dots.

See of_isa_indirect_io() called just before of_bus_isa_match(parent)...=20

>=20
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  arch/arm64/include/asm/io.h |  7 +++++++
> >  arch/arm64/kernel/extio.c   | 24 +++++++++++++++++++++++
> >  drivers/of/address.c        | 47
> +++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/pci/pci.c           |  6 +++---
> >  include/linux/of_address.h  | 17 ++++++++++++++++
> >  5 files changed, 96 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/io.h
> b/arch/arm64/include/asm/io.h
> > index 136735d..e480199 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -175,6 +175,13 @@ static inline u64 __raw_readq(const volatile
> void __iomem *addr)
> >  #define outsl outsl
> >
> >  DECLARE_EXTIO(l, u32)
> > +
> > +
> > +#define indirect_io_ison indirect_io_ison
> > +extern int indirect_io_ison(void);
>=20
> This makes it look like "ison" is some new word I'm not familiar with.
> "indirect_io_is_on()" or even "indirect_io_enabled()" would be more
> readable.

Sure agreed

>=20
> > +
> > +#define chk_indirect_range chk_indirect_range
> > +extern int chk_indirect_range(u64 taddr);
> >  #endif
> >
> >
> > diff --git a/arch/arm64/kernel/extio.c b/arch/arm64/kernel/extio.c
> > index 80cafd5..55df8dc 100644
> > --- a/arch/arm64/kernel/extio.c
> > +++ b/arch/arm64/kernel/extio.c
> > @@ -19,6 +19,30 @@
> >
> >  struct extio_ops *arm64_extio_ops;
> >
> > +/**
> > + * indirect_io_ison - check whether indirectIO can work well. This
> function only call
> > + *		before the target I/O address was obtained.
> > + *
> > + * Returns 1 when indirectIO can work.
> > + */
> > +int indirect_io_ison()
> > +{
> > +	return arm64_extio_ops ? 1 : 0;
> > +}
> > +
> > +/**
> > + * check_indirect_io - check whether the input taddr is for
> indirectIO.
>=20
> Comment name ("check_indirect_io") doesn't match actual function name
> ("chk_indirect_range").
>=20
> One of my pet peeves: "check" is completely worthless as part of a
> function name because it doesn't help the reader figure out the sense
> of the result.  What does a "true" result mean?  Name it something
> like "address_is_indirect()" so it reads naturally when the caller
> does something like "if (address_is_indirect())"

Yes it makes sense, we can change to " address_is_indirect"

>=20
> > + * @taddr: the io address to be checked.
> > + *
> > + * Returns 1 when taddr is in the range; otherwise return 0.
> > + */
> > +int chk_indirect_range(u64 taddr)
> > +{
> > +	if (arm64_extio_ops->start > taddr || arm64_extio_ops->end <
> taddr)
> > +		return 0;
> > +
> > +	return 1;
> > +}
> >
> >  BUILD_EXTIO(b, u8)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 02b2903..0bee822 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -479,6 +479,39 @@ static int of_empty_ranges_quirk(struct
> device_node *np)
> >  	return false;
> >  }
> >
> > +
> > +/*
> > + * Check whether the current device being translating use
> indirectIO.
>=20
> What does "the current device" mean?  I assume you're talking about
> "any device on 'bus'"?  And apparently the caller is inquiring about a
> particular address, too?

Effectively we check if the device is lying on a ISA bus, if the accessors
struct pointer is set, if the parent device is an ISA bus and if the device
physical addresses are within the range reserved for LPC...

So we check all the conditions that allow us to say that this device
is lying on a special ISA bus device

>=20
> > + * return 1 if the check is past, or 0 represents fail checking.
>=20
> This doesn't really make sense.  I assume you mean something like
> "return 1 if 'address' uses indirectIO; 0 otherwise"?

Yes the comment is quite bad; we'll change this in the next version

>=20
> > + */
> > +static int of_isa_indirect_io(struct device_node *parent,
> > +				struct of_bus *bus, __be32 *addr,
> > +				int na, u64 *presult)
> > +{
> > +	unsigned int flags;
> > +	unsigned int rlen;
> > +
> > +	/* whether support indirectIO */
> > +	if (!indirect_io_ison())
> > +		return 0;
> > +
> > +	if (!of_bus_isa_match(parent))
> > +		return 0;
> > +
> > +	flags =3D bus->get_flags(addr);
> > +	if (!(flags & IORESOURCE_IO))
> > +		return 0;
> > +
> > +	/* there is ranges property, apply the normal translation
> directly. */
> > +	if (of_get_property(parent, "ranges", &rlen))
> > +		return 0;
> > +
> > +	*presult =3D of_read_number(addr + 1, na - 1);
> > +
> > +	return chk_indirect_range(*presult);
> > +}
> > +
> >  static int of_translate_one(struct device_node *parent, struct
> of_bus *bus,
> >  			    struct of_bus *pbus, __be32 *addr,
> >  			    int na, int ns, int pna, const char *rprop)
> > @@ -532,7 +565,7 @@ static int of_translate_one(struct device_node
> *parent, struct of_bus *bus,
> >  	}
> >  	memcpy(addr, ranges + na, 4 * pna);
> >
> > - finish:
> > +finish:
> >  	of_dump_addr("parent translation for:", addr, pna);
> >  	pr_debug("with offset: %llx\n", (unsigned long long)offset);
> >
> > @@ -595,6 +628,15 @@ static u64 __of_translate_address(struct
> device_node *dev,
> >  			result =3D of_read_number(addr, na);
> >  			break;
> >  		}
> > +		/*
> > +		 * For indirectIO device which has no ranges property, get
> > +		 * the address from reg directly.
> > +		 */
> > +		if (of_isa_indirect_io(dev, bus, addr, na, &result)) {
> > +			pr_info("isa indirectIO matched(%s)..addr =3D
> 0x%llx\n",
> > +				of_node_full_name(dev), result);
> > +			break;
> > +		}
> >
> >  		/* Get new parent bus and counts */
> >  		pbus =3D of_match_bus(parent);
> > @@ -688,8 +730,9 @@ static int __of_address_to_resource(struct
> device_node *dev,
> >  	if (taddr =3D=3D OF_BAD_ADDR)
> >  		return -EINVAL;
> >  	memset(r, 0, sizeof(struct resource));
> > -	if (flags & IORESOURCE_IO) {
> > +	if (flags & IORESOURCE_IO && taddr >=3D PCIBIOS_MIN_IO) {
> >  		unsigned long port;
> > +
> >  		port =3D pci_address_to_pio(taddr);
> >  		if (port =3D=3D (unsigned long)-1)
> >  			return -EINVAL;
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ba34907..1a08511 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3263,7 +3263,7 @@ int __weak pci_register_io_range(phys_addr_t
> addr, resource_size_t size)
> >
> >  #ifdef PCI_IOBASE
> >  	struct io_range *range;
> > -	resource_size_t allocated_size =3D 0;
> > +	resource_size_t allocated_size =3D PCIBIOS_MIN_IO;
>=20
> I don't understand what's going on here.  PCIBIOS_MIN_IO is an
> *address*, so you're setting a *size* to an address.  Maybe this just
> needs an explanation.  The connection to the rest of this patch isn't
> obvious.  If it could be split to a separate patch, so much the
> better; then you'd have a nice place to describe it.

Please see my first comment above...this is needed to reserve the
cpu address range for the LPC...

>=20
> >  	/* check if the range hasn't been previously recorded */
> >  	spin_lock(&io_range_lock);
> > @@ -3312,7 +3312,7 @@ phys_addr_t pci_pio_to_address(unsigned long
> pio)
> >
> >  #ifdef PCI_IOBASE
> >  	struct io_range *range;
> > -	resource_size_t allocated_size =3D 0;
> > +	resource_size_t allocated_size =3D PCIBIOS_MIN_IO;
> >
> >  	if (pio > IO_SPACE_LIMIT)
> >  		return address;
> > @@ -3335,7 +3335,7 @@ unsigned long __weak
> pci_address_to_pio(phys_addr_t address)
> >  {
> >  #ifdef PCI_IOBASE
> >  	struct io_range *res;
> > -	resource_size_t offset =3D 0;
> > +	resource_size_t offset =3D PCIBIOS_MIN_IO;
> >  	unsigned long addr =3D -1;
> >
> >  	spin_lock(&io_range_lock);
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 3786473..0ba7e21 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -24,6 +24,23 @@ struct of_pci_range {
> >  #define for_each_of_pci_range(parser, range) \
> >  	for (; of_pci_range_parser_one(parser, range);)
> >
> > +
> > +#ifndef indirect_io_ison
> > +#define indirect_io_ison indirect_io_ison
> > +static inline int indirect_io_ison(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +#ifndef chk_indirect_range
> > +#define chk_indirect_range chk_indirect_range
> > +static inline int chk_indirect_range(u64 taddr)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  /* Translate a DMA address from device space to CPU space */
> >  extern u64 of_translate_dma_address(struct device_node *dev,
> >  				    const __be32 *in_addr);
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
