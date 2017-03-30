Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 30 Mar 2017 11:47:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
Message-ID: <20170330164732.GA8437@bhelgaas-glaptop.roam.corp.google.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
 <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328144543.GA18046@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170328144543.GA18046@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 28, 2017 at 03:45:43PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Mar 27, 2017 at 08:41:10PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 27, 2017 at 10:49:30AM +0100, Lorenzo Pieralisi wrote:

> > >  #define ioremap_uc ioremap_uc
> > > +#define ioremap_nopost ioremap_nocache
> > 
> > These are all the same as the default from asm-generic.h.  Do we really
> > need these definitions in alpha, avr32, frv, ia64, x86?
> 
> Those arches do not include asm-generic.h (I suppose for a good reason)

OK, that explains it.  I'm not at all sure there's a good reason for
those arches not using asm-generic.h, but I haven't looked at the code
to see.

> but a definition is needed anyway if we want code using ioremap_nopost()
> to be unconditional. This is one way of doing it, there are others not
> sure they are any better, I am open to suggestions.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
