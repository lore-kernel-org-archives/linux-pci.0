Return-Path: <SRS0=Hsbi=3O=suse.de=lurodriguez@kernel.org>
Return-Path: <SRS0=Hsbi=3O=suse.de=lurodriguez@kernel.org>
Date: Thu, 6 Apr 2017 13:59:07 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
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
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
Message-ID: <20170406115906.GF28800@wotan.suse.de>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
 <20170406102636.GA9623@red-moon>
 <20170406105312.GE28800@wotan.suse.de>
 <20170406113845.GA10013@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406113845.GA10013@red-moon>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 12:38:45PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 06, 2017 at 12:53:12PM +0200, Luis R. Rodriguez wrote:
> > On Thu, Apr 06, 2017 at 11:26:36AM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Apr 05, 2017 at 01:38:12PM +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Apr 05, 2017 at 11:58:41AM +0100, Russell King - ARM Linux wrote:
> > > > > On Tue, Mar 28, 2017 at 03:45:43PM +0100, Lorenzo Pieralisi wrote:
> > > > > > On Mon, Mar 27, 2017 at 08:41:10PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, Mar 27, 2017 at 10:49:30AM +0100, Lorenzo Pieralisi wrote:
> > > > > > > > diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> > > > > > > > index 7afb0e2..50b292f 100644
> > > > > > > > --- a/arch/x86/include/asm/io.h
> > > > > > > > +++ b/arch/x86/include/asm/io.h
> > > > > > > > @@ -171,6 +171,7 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
> > > > > > > >  extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size);
> > > > > > > >  extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
> > > > > > > >  #define ioremap_uc ioremap_uc
> > > > > > > > +#define ioremap_nopost ioremap_nocache
> > > > > > > 
> > > > > > > These are all the same as the default from asm-generic.h.  Do we really
> > > > > > > need these definitions in alpha, avr32, frv, ia64, x86?
> > > > > > 
> > > > > > Those arches do not include asm-generic.h (I suppose for a good reason)
> > > > > > but a definition is needed anyway if we want code using ioremap_nopost()
> > > > > > to be unconditional. This is one way of doing it, there are others not
> > > > > > sure they are any better, I am open to suggestions.
> > > > > 
> > > > > We do have linux/io.h, which should be included in preference to asm/io.h.
> > > > > linux/io.h has existed for years, but I still see (from time to time)
> > > > > patches adding drivers that (imho incorrectly) use asm/io.h.
> > > > > 
> > > > > Also, this:
> > > > > 
> > > > > > > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > > > > > > index 7ef015e..0e81938 100644
> > > > > > > > --- a/include/asm-generic/io.h
> > > > > > > > +++ b/include/asm-generic/io.h
> > > > > > > > @@ -915,6 +915,10 @@ extern void ioport_unmap(void __iomem *p);
> > > > > > > >  #endif /* CONFIG_GENERIC_IOMAP */
> > > > > > > >  #endif /* CONFIG_HAS_IOPORT_MAP */
> > > > > > > >  
> > > > > > > > +#ifndef ioremap_nopost
> > > > > > > > +#define ioremap_nopost ioremap_nocache
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >  #ifndef xlate_dev_kmem_ptr
> > > > > > > >  #define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
> > > > > > > >  static inline void *xlate_dev_kmem_ptr(void *addr)
> > > > > 
> > > > > could well be located in linux/io.h, which would make it available
> > > > > everywhere.
> > > > > 
> > > > > I'd suggest one change to this though:
> > > > > 
> > > > > #ifndef ioremap_nopost
> > > > > static inline void __iomem *ioremap_nopost(resource_size_t offset,
> > > > > 					   unsigned long size)
> > > > > {
> > > > > 	return ioremap_nocache(offset, size);
> > > > > }
> > > > > #endif
> > > > > 
> > > > > This way, if someone forgets to define ioremap_nopost() in their
> > > > > asm/io.h but provides a definition or extern prototype for
> > > > > ioremap_nopost(), we end up with a compile error to highlight the
> > > > > error, rather than the error being hidden by the preprocessor.
> > > > 
> > > > Yes, I could add ioremap_nopost() to linux/io.h I did not do it because
> > > > linux/io.h, for whatever reason, does not seem to contain ioremap_*
> > > > prototypes; this does not mean we should not add it there but that
> > > > would look odd (with all others ioremap_* in asm/io.h), all I am
> > > > saying. This stuff requires some clean-up regardless, for the records.
> > > > 
> > > > As for the static inline, I did that and that did not make the
> > > > kbuild robot happy at all on some arches:
> > > > 
> > > > eg: openrisc
> > > > 
> > > > >> include/asm-generic/io.h:922:9: error: implicit declaration of
> > > > >> function 'ioremap_nocache' [-Werror=implicit-function-declaration]
> > > >      return ioremap_nocache(offset, size);
> > > 
> > > Indeed, the static inline ioremap_nocache() fallback does not work
> > > on all arches (whether I add the fallback in linux/io.h or
> > > asm-generic/io.h is irrelevant), I bump into issues such as the one
> > > reported above.
> > 
> > Its also not *safe* to assume on behalf of all architectures a new ioremap
> > call is both a good idea and proper.
> > 
> > > I could make it:
> > > 
> > > #ifndef ioremap_nopost
> > > static inline void __iomem *ioremap_nopost(resource_size_t offset,
> > > 					   unsigned long size)
> > > {
> > > 	return NULL;
> > > }
> > > #endif
> > > 
> > > which would force arches to define ioremap_nopost() (if they need it).
> > 
> > Yes, please do this.
> 
> Ok but where ? linux/io.h or asm-generic/io.h ? As I replied to Russell,
> having it in linux/io.h is a bit odd given that it would be the only
> ioremap_* implementation declared there, I think we need more
> consistency here instead of deviating again from what you did.

asm-generic/io.h is the right place for generics which let you override.

> > > This is what I *assume* was done for ioremap_uc() in asm-generic/io.h,
> > > but honestly history is hard to follow here.
> > > 
> > > Thoughts ?
> > 
> > Hard to follow ?
> 
> I was referring to the whole asm-generic/io.h history.
> 
> > I think commit 8c7ea50c010b2 ("x86/mm, asm-generic: Add IOMMU ioremap_uc()
> > variant default") makes it very clear that historically we have made bad
> > assumptions and these assumptions are not safe, so the only correct thing we
> > can do to not stall development is to do what you did above, and each
> > architecture then can add support for its proper mapping. Its up to each
> > architecture maintainer to be attentive and review these patches, if they don't
> > get to it, this will just not work for the new driver that needs it, such is
> > life, its better than having incorrect defaults spread for all architectures.
> > 
> > The old strategy was very sloppy. Its why I tried to be as clear as possible on
> > both the commit log and headers about this. If the commit log and headers were
> > not clear, please help clarify this more somehow in your patches.
> 
> I see your point and I can replicate (probably I will have to patch
> microblaze too since some of the PCI drivers patches in this series
> that I updated to use ioremap_nopost() will run on it too) 

Cool right so if you add support for the archs for the drivers that you know
use this new ioremap then there is no regressions, and then only if a new
driver gets added and an arch needs this they will also need this, but that
is precisely the sort of requirement thought process we want.

> what you
> did for ioremap_uc() for ioremap_nopost(), I am ok with that, I need
> to know if we all are.

Sure. And again, if consensus is built (again) on that strategy please
update the docs to ensure that this is even clearer for the next person.
I thought it was rather clear now but it does not seem so.

  Luis
