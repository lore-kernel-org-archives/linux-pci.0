Return-Path: <SRS0=Q2iE=3O=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=Q2iE=3O=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 6 Apr 2017 11:26:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Henderson <rth@twiddle.net>,
	Tony Luck <tony.luck@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	John Garry <john.garry@huawei.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Jon Mason <jonmason@broadcom.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
Message-ID: <20170406102636.GA9623@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170405113238.GA2465@red-moon>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 05, 2017 at 01:38:12PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 05, 2017 at 11:58:41AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Mar 28, 2017 at 03:45:43PM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Mar 27, 2017 at 08:41:10PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Mar 27, 2017 at 10:49:30AM +0100, Lorenzo Pieralisi wrote:
> > > > > diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> > > > > index 7afb0e2..50b292f 100644
> > > > > --- a/arch/x86/include/asm/io.h
> > > > > +++ b/arch/x86/include/asm/io.h
> > > > > @@ -171,6 +171,7 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
> > > > >  extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size);
> > > > >  extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
> > > > >  #define ioremap_uc ioremap_uc
> > > > > +#define ioremap_nopost ioremap_nocache
> > > > 
> > > > These are all the same as the default from asm-generic.h.  Do we really
> > > > need these definitions in alpha, avr32, frv, ia64, x86?
> > > 
> > > Those arches do not include asm-generic.h (I suppose for a good reason)
> > > but a definition is needed anyway if we want code using ioremap_nopost()
> > > to be unconditional. This is one way of doing it, there are others not
> > > sure they are any better, I am open to suggestions.
> > 
> > We do have linux/io.h, which should be included in preference to asm/io.h.
> > linux/io.h has existed for years, but I still see (from time to time)
> > patches adding drivers that (imho incorrectly) use asm/io.h.
> > 
> > Also, this:
> > 
> > > > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > > > index 7ef015e..0e81938 100644
> > > > > --- a/include/asm-generic/io.h
> > > > > +++ b/include/asm-generic/io.h
> > > > > @@ -915,6 +915,10 @@ extern void ioport_unmap(void __iomem *p);
> > > > >  #endif /* CONFIG_GENERIC_IOMAP */
> > > > >  #endif /* CONFIG_HAS_IOPORT_MAP */
> > > > >  
> > > > > +#ifndef ioremap_nopost
> > > > > +#define ioremap_nopost ioremap_nocache
> > > > > +#endif
> > > > > +
> > > > >  #ifndef xlate_dev_kmem_ptr
> > > > >  #define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
> > > > >  static inline void *xlate_dev_kmem_ptr(void *addr)
> > 
> > could well be located in linux/io.h, which would make it available
> > everywhere.
> > 
> > I'd suggest one change to this though:
> > 
> > #ifndef ioremap_nopost
> > static inline void __iomem *ioremap_nopost(resource_size_t offset,
> > 					   unsigned long size)
> > {
> > 	return ioremap_nocache(offset, size);
> > }
> > #endif
> > 
> > This way, if someone forgets to define ioremap_nopost() in their
> > asm/io.h but provides a definition or extern prototype for
> > ioremap_nopost(), we end up with a compile error to highlight the
> > error, rather than the error being hidden by the preprocessor.
> 
> Yes, I could add ioremap_nopost() to linux/io.h I did not do it because
> linux/io.h, for whatever reason, does not seem to contain ioremap_*
> prototypes; this does not mean we should not add it there but that
> would look odd (with all others ioremap_* in asm/io.h), all I am
> saying. This stuff requires some clean-up regardless, for the records.
> 
> As for the static inline, I did that and that did not make the
> kbuild robot happy at all on some arches:
> 
> eg: openrisc
> 
> >> include/asm-generic/io.h:922:9: error: implicit declaration of
> >> function 'ioremap_nocache' [-Werror=implicit-function-declaration]
>      return ioremap_nocache(offset, size);

Indeed, the static inline ioremap_nocache() fallback does not work
on all arches (whether I add the fallback in linux/io.h or
asm-generic/io.h is irrelevant), I bump into issues such as the one
reported above.

I could make it:

#ifndef ioremap_nopost
static inline void __iomem *ioremap_nopost(resource_size_t offset,
					   unsigned long size)
{
	return NULL;
}
#endif

which would force arches to define ioremap_nopost() (if they need it).

This is what I *assume* was done for ioremap_uc() in asm-generic/io.h,
but honestly history is hard to follow here.

Thoughts ?

Thanks,
Lorenzo
