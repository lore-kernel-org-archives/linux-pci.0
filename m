Return-Path: <SRS0=Q2iE=3O=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=Q2iE=3O=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 6 Apr 2017 17:21:56 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20170406162156.GA10134@red-moon>
References: <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
 <20170406102636.GA9623@red-moon>
 <20170406105312.GE28800@wotan.suse.de>
 <20170406113845.GA10013@red-moon>
 <20170406115906.GF28800@wotan.suse.de>
 <20170406130727.GE17774@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406130727.GE17774@n2100.armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 02:07:27PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 06, 2017 at 01:59:07PM +0200, Luis R. Rodriguez wrote:
> > On Thu, Apr 06, 2017 at 12:38:45PM +0100, Lorenzo Pieralisi wrote:
> > > Ok but where ? linux/io.h or asm-generic/io.h ? As I replied to Russell,
> > > having it in linux/io.h is a bit odd given that it would be the only
> > > ioremap_* implementation declared there, I think we need more
> > > consistency here instead of deviating again from what you did.
> > 
> > asm-generic/io.h is the right place for generics which let you override.
> 
> I disagree for two reasons, and I will refer you to Linus' comments back
> in 2005 at http://yarchive.net/comp/linux/generic.html
> 
> 1) asm-generic/io.h has become an ifdef mess, every single definition in
>    there is conditional.  The reason for this has happened is that
>    architectures can't pick and choose what they want from a single file
>    unless something like that is done.  It would be _far_ better to
>    split this file up by functional group - eg, ISA IO accessors,
>    io(read|write)*(), read|write*(), and so forth.
> 
> 2) We're at the point where we have various .c files around the kernel
>    _directly_ including asm-generic header files, which means the
>    use of asm-generic headers is no longer a choice of the architecture.
> 
> 3) asm-generic/ started out life as the place where example
>    implementations of asm/*.h header files were found, and but has
>    grown into a place where we dump default implementations.  We had
>    a place for default implementations for years, which were the
>    linux/*.h headers.  We have now ended up with a mixture of both
>    techniques, even for something like io.h, we have the messy
>    asm-generic/io.h, the architecture's asm/io.h, and then linux/io.h.
>    We have ended up with both linux/io.h and asm-generic/io.h containing
>    default definitions.
> 
> We've had the rule that where both linux/foo.h and asm/foo.h exist, the
> linux/ counterpart is the preferred include file.  That didn't really
> happen with asm/io.h due to the number of users that there were, but
> when new stuff was added to asm/io.h which we wanted to be generic,
> linux/io.h was created to contain that.  This actually pre-dates the
> "let's clutter up asm-generic with shared arch stuff" push.
> 
> Now, what you say _may_ make sense if we have an
> asm-generic/ioremap-nopost.h header which just defines a default
> ioremap_nopost.h implementation, and architectures would then be able to
> choose whether to include that or not depending on whether they provide
> their own implementation.  No ugly ifdefs are necessary with that
> approach.
> 
> Out of the three choices, I would much rather see the
> asm-generic/ioremap-nopost.h approach.  However, the down-side to that
> is it means all architectures asm/io.h would need to be touched to
> explicitly include that.
> 
> What I'm absolutely certain of, though, is that making asm-generic/io.h
> even worse by adding yet more conditional stuff to it is not a sane way
> forward.

Ok, so:

(1) I can do asm-generic/ioremap-nopost.h, which I assume you want to
    contain something like

static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
{
	return ioremap_nocache(offset, size);
}

Funny bit is that it has to be included by asm*/io.h files _after_
ioremap_nocache has been #defined (that's the reason my approach was
failing miserably even on arches like eg powerpc (see [1] below) that
does have ioremap_nocache), not sure it is going to be very nice to have
an include in the middle of asm*/io.h include files (and I have to patch
all arches which I can do).

Or

(2) I add:

#ifndef ioremap_nopost
static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
{
	return NULL; <-(making it return ioremap_nocache() does not
			work, see [1] for the reason)
}
#endif

in linux/io.h

(3) ioremap_nopost follows Luis' ioremap_uc approach

(1)-(2) bypass completely what Luis did for ioremap_uc(), which implies
that we have yet another way of implementing ioremap_*.

I would like to get this patchset done so if you have an opinion it
is time to state it.

Thanks,
Lorenzo

[1] powerpc build report:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/config-io-mappings-fix-v3
head:   283a324b549a662346c95c05b08983dd5b83354b
commit: e66b493fe93226c02b1a33355f79db7ed6efe718 [2/23] linux/io.h: add ioremap_nopost remap interface
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e66b493fe93226c02b1a33355f79db7ed6efe718
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/io.h:28:0,
                    from arch/powerpc/oprofile/op_model_cell.c:29:
   include/linux/io.h: In function 'ioremap_nopost':
   include/linux/io.h:169:9: error: implicit declaration of function 'ioremap_nocache' [-Werror=implicit-function-declaration]
     return ioremap_nocache(offset, size);
            ^~~~~~~~~~~~~~~
>> include/linux/io.h:169:9: error: return makes pointer from integer without a cast [-Werror=int-conversion]
     return ioremap_nocache(offset, size);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +169 include/linux/io.h

   163  }
   164  #endif
   165 
   166  #ifndef ioremap_nopost
   167  static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
   168  {
 > 169           return ioremap_nocache(offset, size);
   170  }
   171  #endif
   172 
