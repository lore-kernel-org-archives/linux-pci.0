Return-Path: <SRS0=Jn9M=3S=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=Jn9M=3S=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 10 Apr 2017 15:30:42 +0100
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
Message-ID: <20170410143041.GA4843@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
 <20170406102636.GA9623@red-moon>
 <20170406104737.GC17774@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406104737.GC17774@n2100.armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 11:47:37AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 06, 2017 at 11:26:36AM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Apr 05, 2017 at 01:38:12PM +0100, Lorenzo Pieralisi wrote:
> > > eg: openrisc
> > > 
> > > >> include/asm-generic/io.h:922:9: error: implicit declaration of
> > > >> function 'ioremap_nocache' [-Werror=implicit-function-declaration]
> > >      return ioremap_nocache(offset, size);
> > 
> > Indeed, the static inline ioremap_nocache() fallback does not work
> > on all arches (whether I add the fallback in linux/io.h or
> > asm-generic/io.h is irrelevant), I bump into issues such as the one
> > reported above.
> 
> From what I can see:
> 
> (a) openrisc does define ioremap_nocache() in its asm/io.h
> (b) these do not:
> 
> $ grep -L 'ioremap_nocache' arch/*/include/asm/io.h
> arch/blackfin/include/asm/io.h
> arch/h8300/include/asm/io.h
> arch/m68k/include/asm/io.h
> arch/score/include/asm/io.h
> arch/sparc/include/asm/io.h
> 
> Out of those, blackfin, h8300 and score do not define it, whereas m68k
> and sparc do in other headers included by asm/io.h.  So it looks like
> we have three problem architectures that don't define an ioremap_nocache().
> 
> PCI on blackfin depends on BROKEN, so it's not selectable.  From what I
> can tell, h8300 and score do not allow PCI to be enabled (but maybe its
> buried elsewhere in their Kconfig files, I didn't check.)
> 
> So, I think a way around this is to make ioremap_nopost() conditional
> on PCI in linux/io.h for the time being - if its scope wants to be
> enlarged, then these three architectures would need to have either an
> ioremap_nopost() implementation added, or an ioremap_nocache()
> implementation.

Ok, I implemented asm-generic/ioremap-nopost.h, I do not think we need
a CONFIG_PCI guard (kbuild has not barfed at it, yet), given that
blackfin and h8300 are !MMU and score selects NO_IOMEM.

Patch below is all arches squashed into one commit, I probably have
to split it one per arch which will make this a 50-patch series in
total:

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git/commit/?h=pci/config-io-mappings-fix-v3&id=acc0be820c809101e02ab7cb170f802db53af934

If I hear no complaints I will split patch above one per arch and
repost the series shortly (even though I think I should make two series
out of it, one asm-generic/ioremap-nopost.h boilerplate and second
ARM/ARM64 implementation + PCI drivers).

Lorenzo
