Return-Path: <SRS0=QdZ4=3O=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=QdZ4=3O=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Thu, 6 Apr 2017 18:19:19 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Message-ID: <20170406171919.GJ17774@n2100.armlinux.org.uk>
References: <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
 <20170406102636.GA9623@red-moon>
 <20170406105312.GE28800@wotan.suse.de>
 <20170406113845.GA10013@red-moon>
 <20170406115906.GF28800@wotan.suse.de>
 <20170406130727.GE17774@n2100.armlinux.org.uk>
 <20170406162156.GA10134@red-moon>
 <20170406164015.GI17774@n2100.armlinux.org.uk>
 <20170406170951.GA10520@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406170951.GA10520@red-moon>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 06:09:51PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 06, 2017 at 05:40:16PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 06, 2017 at 05:21:56PM +0100, Lorenzo Pieralisi wrote:
> > > Ok, so:
> > > 
> > > (1) I can do asm-generic/ioremap-nopost.h, which I assume you want to
> > >     contain something like
> > > 
> > > static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
> > > {
> > > 	return ioremap_nocache(offset, size);
> > > }
> > > 
> > > Funny bit is that it has to be included by asm*/io.h files _after_
> > > ioremap_nocache has been #defined (that's the reason my approach was
> > > failing miserably even on arches like eg powerpc (see [1] below) that
> > > does have ioremap_nocache),
> > 
> > PowerPC does have ioremap_nocache() though:
> > 
> > /**
> >  * ioremap     -   map bus memory into CPU space
> > ...
> >  * * ioremap_nocache is identical to ioremap
> > extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
> > #define ioremap_nocache(addr, size)     ioremap((addr), (size))
> > 
> > and this include file is included very early on in linux/io.h.  I don't
> > see anything that conditionalises it on anything except __KERNEL__.  So,
> > the report from 0-day really doesn't make any sense to me.
> > 
> > Do we know how we're ending up in linux/io.h line 169 without having
> > picked up the ioremap_nocache() definition provided by PowerPC's
> > asm/io.h ?
> 
> I will debug it further but I *think* it is because:
> 
> eg arch/powerpc/oprofile/op_model_cell.c includes <asm/io.h>
> 
> and <asm/io.h> includes <linux/io.h> before ioremap_nocache is defined

Oh, that's just very wrong.  asm/foo.h should never include linux/foo.h
especially when linux/foo.h already includes asm/foo.h.  I think we
need PowerPC folk to fix this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
