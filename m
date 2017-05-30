Return-Path: <SRS0=BnMe=5E=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=BnMe=5E=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com"
	<will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>,
        John Garry <john.garry@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)"
	<xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "zhichang.yuan"
	<yuanzhichang@hisilicon.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>
Subject: RE: [PATCH v9 1/7] LIB: Introduce a generic PIO mapping method
Date: Tue, 30 May 2017 15:09:13 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A771E6@FRAEML521-MBX.china.huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170526205744.GA21531@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170526205744.GA21531@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 26 May 2017 21:58
> To: Gabriele Paoloni
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; rafael@kernel.org;
> arnd@arndb.de; linux-arm-kernel@lists.infradead.org;
> lorenzo.pieralisi@arm.com; mark.rutland@arm.com; minyard@acm.org;
> benh@kernel.crashing.org; John Garry; linux-kernel@vger.kernel.org;
> xuwei (O); Linuxarm; linux-acpi@vger.kernel.org; zhichang.yuan; linux-
> pci@vger.kernel.org; olof@lixom.net; brian.starkey@arm.com
> Subject: Re: [PATCH v9 1/7] LIB: Introduce a generic PIO mapping method
>=20
> On Thu, May 25, 2017 at 12:37:22PM +0100, Gabriele Paoloni wrote:
> > From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> >
> > In 'commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> > pci_pio_to_address()")' a new I/O space management was supported.
> With that
> > driver, the I/O ranges configured for PCI/PCIE hosts on some
> architectures
> > can be mapped to logical PIO, converted easily between CPU address
> and the
> > corresponding logicial PIO. Based on this, PCI I/O devices can be
> accessed
> > in a memory read/write way through the unified in/out accessors.
> >
> > But on some archs/platforms, there are bus hosts which access I/O
> > peripherals with host-local I/O port addresses rather than memory
> > addresses after memory-mapped.
> > To support those devices, a more generic I/O mapping method is
> introduced
> > here. Through this patch, both the CPU addresses and the host-local
> port
> > can be mapped into the logical PIO space with different logical/fake
> PIOs.
> > After this, all the I/O accesses to either PCI MMIO devices or host-
> local
> > I/O peripherals can be unified into the existing I/O accessors
> defined in
> > asm-generic/io.h and be redirected to the right device-specific hooks
> > based on the input logical PIO.
> >
> > Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > ---
> >  include/asm-generic/io.h  |  50 +++++++++
> >  include/linux/logic_pio.h | 110 ++++++++++++++++++
> >  lib/Kconfig               |  26 +++++
> >  lib/Makefile              |   2 +
> >  lib/logic_pio.c           | 280
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 468 insertions(+)
> >  create mode 100644 include/linux/logic_pio.h
> >  create mode 100644 lib/logic_pio.c
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 7ef015e..f7fbec3 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > ...
>=20
> >  #ifndef inb
> > +#ifdef CONFIG_INDIRECT_PIO
> > +#define inb logic_inb
> > +#else
> >  #define inb inb
> >  static inline u8 inb(unsigned long addr)
> >  {
> >  	return readb(PCI_IOBASE + addr);
> >  }
> > +#endif /* CONFIG_INDIRECT_PIO */
> >  #endif
> >
> >  #ifndef inw
> > +#ifdef CONFIG_INDIRECT_PIO
> > +#define inw logic_inw
>=20
> Cosmetic: could these ifdefs all be collected in one place, e.g.,
>=20
>   #ifdef CONFIG_INDIRECT_PIO
>   #define inb logic_inb
>   #define inw logic_inw
>   #define inl logic_inl
>   ...
>   #endif
>=20
> to avoid cluttering every one of the default definitions?  Could the
> collection be in logic_pio.h itself, next to the extern declarations?

Yes I think it should be doable. I will rework this in the next patchset

>=20
> > +#else
> >  #define inw inw
> >  static inline u16 inw(unsigned long addr)
> >  {
> >  	return readw(PCI_IOBASE + addr);
> >  }
> > +#endif /* CONFIG_INDIRECT_PIO */
> >  #endif
>=20
> >  #ifndef insb_p
> > diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
> > new file mode 100644
> > index 0000000..8e4dc65
> > --- /dev/null
> > +++ b/include/linux/logic_pio.h
> > ...
>=20
> > +extern u8 logic_inb(unsigned long addr);
>=20
> I think you only build the definitions for these if
> CONFIG_INDIRECT_PIO, so the declarations could be under that #idef,
> too.

Yes agreed

>=20
> In PCI code, I omit the "extern" from function declarations.  This
> isn't PCI code, and I don't know if there's a real consensus on this,
> but there is some precedent: 5bd085b5fbd8 ("x86: remove "extern" from
> function prototypes in <asm/proto.h>")
>=20

To be honest I have no clue...

If you look at include/asm-generic/io.h we have extern declarations...

BTW I can remove the extern and then let's see if somebody complains...


> > +#ifdef CONFIG_LOGIC_PIO
> > +extern struct logic_pio_hwaddr
> > +*find_io_range_by_fwnode(struct fwnode_handle *fwnode);
>=20
> If you have to split the line (this one would fit without the
> "extern"), the "*" goes with the type, e.g.,
>=20
>   struct logic_pio_hwaddr *
>   find_io_range_by_fwnode(struct fwnode_handle *fwnode);
>=20
> More occurrences below.

Ok I will rework these

>=20
> > diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> > new file mode 100644
> > index 0000000..4a960cd
> > --- /dev/null
> > +++ b/lib/logic_pio.c
> > ...
>=20
> > +#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> > +#define BUILD_LOGIC_PIO(bw, type)\
> > +type logic_in##bw(unsigned long addr)\
> > +{\
> > +	type ret =3D -1;\
> > +\
> > +	if (addr < MMIO_UPPER_LIMIT) {\
> > +		ret =3D read##bw(PCI_IOBASE + addr);\
> > +	} else {\
> > +		struct logic_pio_hwaddr *entry =3D find_io_range(addr);\
> > +\
> > +		if (entry && entry->ops)\
> > +			ret =3D entry->ops->pfin(entry->devpara,\
> > +					addr, sizeof(type));\
> > +		else\
> > +			WARN_ON_ONCE(1);\
> > +	}	\
> > +	return ret;\
> > +}	\
>=20
> I think these would be slightly easier to read if the line continuation
> backslashes were aligned at the right, as with
> ACPI_DECLARE_PROBE_ENTRY(), __atomic_op_acquire(), DECLARE_EWMA(),
> etc.

Ok agreed I will rework this too

Many Thanks
Gab

>=20
> Bjorn
