Return-Path: <SRS0=QdZ4=3O=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=QdZ4=3O=armlinux.org.uk=linux+helgaas=kernel.org@kernel.org>
Date: Thu, 6 Apr 2017 13:11:57 +0100
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
Message-ID: <20170406121157.GD17774@n2100.armlinux.org.uk>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
 <20170405105841.GG7909@n2100.armlinux.org.uk>
 <20170405113238.GA2465@red-moon>
 <20170406102636.GA9623@red-moon>
 <20170406105312.GE28800@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406105312.GE28800@wotan.suse.de>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 12:53:12PM +0200, Luis R. Rodriguez wrote:
> On Thu, Apr 06, 2017 at 11:26:36AM +0100, Lorenzo Pieralisi wrote:
> > Indeed, the static inline ioremap_nocache() fallback does not work
> > on all arches (whether I add the fallback in linux/io.h or
> > asm-generic/io.h is irrelevant), I bump into issues such as the one
> > reported above.
> 
> Its also not *safe* to assume on behalf of all architectures a new ioremap
> call is both a good idea and proper.

You may be right in general, but not in this case.

Currently, many drivers use plain ioremap() to map this resource.  We
are replacing that existing call - which is known to work in the majority
of cases - with a new call to cater for different semantics required by
an architecture.

Doing a replace of these ioremap() calls with ioremap_nopost() in this
situation, and then having ioremap_nopost() fail is a recipe for causing
lots and lots of regressions.

The only sane approach is to have ioremap_post() default to modelling the
_existing_ behaviour everywhere that it is used.

Requiring it to fail until architecture folk trip over the failure is
totally insane, and I very strongly disagree with you on this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
