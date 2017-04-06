Return-Path: <SRS0=QdZ4=3O=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=QdZ4=3O=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Thu, 6 Apr 2017 14:07:27 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Message-ID: <20170406130727.GE17774@n2100.armlinux.org.uk>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
 <20170406102636.GA9623@red-moon>
 <20170406105312.GE28800@wotan.suse.de>
 <20170406113845.GA10013@red-moon>
 <20170406115906.GF28800@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406115906.GF28800@wotan.suse.de>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 01:59:07PM +0200, Luis R. Rodriguez wrote:
> On Thu, Apr 06, 2017 at 12:38:45PM +0100, Lorenzo Pieralisi wrote:
> > Ok but where ? linux/io.h or asm-generic/io.h ? As I replied to Russell,
> > having it in linux/io.h is a bit odd given that it would be the only
> > ioremap_* implementation declared there, I think we need more
> > consistency here instead of deviating again from what you did.
> 
> asm-generic/io.h is the right place for generics which let you override.

I disagree for two reasons, and I will refer you to Linus' comments back
in 2005 at http://yarchive.net/comp/linux/generic.html

1) asm-generic/io.h has become an ifdef mess, every single definition in
   there is conditional.  The reason for this has happened is that
   architectures can't pick and choose what they want from a single file
   unless something like that is done.  It would be _far_ better to
   split this file up by functional group - eg, ISA IO accessors,
   io(read|write)*(), read|write*(), and so forth.

2) We're at the point where we have various .c files around the kernel
   _directly_ including asm-generic header files, which means the
   use of asm-generic headers is no longer a choice of the architecture.

3) asm-generic/ started out life as the place where example
   implementations of asm/*.h header files were found, and but has
   grown into a place where we dump default implementations.  We had
   a place for default implementations for years, which were the
   linux/*.h headers.  We have now ended up with a mixture of both
   techniques, even for something like io.h, we have the messy
   asm-generic/io.h, the architecture's asm/io.h, and then linux/io.h.
   We have ended up with both linux/io.h and asm-generic/io.h containing
   default definitions.

We've had the rule that where both linux/foo.h and asm/foo.h exist, the
linux/ counterpart is the preferred include file.  That didn't really
happen with asm/io.h due to the number of users that there were, but
when new stuff was added to asm/io.h which we wanted to be generic,
linux/io.h was created to contain that.  This actually pre-dates the
"let's clutter up asm-generic with shared arch stuff" push.

Now, what you say _may_ make sense if we have an
asm-generic/ioremap-nopost.h header which just defines a default
ioremap_nopost.h implementation, and architectures would then be able to
choose whether to include that or not depending on whether they provide
their own implementation.  No ugly ifdefs are necessary with that
approach.

Out of the three choices, I would much rather see the
asm-generic/ioremap-nopost.h approach.  However, the down-side to that
is it means all architectures asm/io.h would need to be touched to
explicitly include that.

What I'm absolutely certain of, though, is that making asm-generic/io.h
even worse by adding yet more conditional stuff to it is not a sane way
forward.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
