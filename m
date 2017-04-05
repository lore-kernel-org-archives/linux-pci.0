Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 5 Apr 2017 11:21:27 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 06/22] ARM: implement ioremap_nopost() interface
Message-ID: <20170405102127.GA15147@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-7-lorenzo.pieralisi@arm.com>
 <20170331110813.GA31763@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170331110813.GA31763@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 John Garry <john.garry@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 31, 2017 at 12:08:13PM +0100, Lorenzo Pieralisi wrote:
> Hi Russell,
> 
> On Mon, Mar 27, 2017 at 10:49:34AM +0100, Lorenzo Pieralisi wrote:
> > The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
> > and Posting") define rules for PCI configuration space transactions
> > ordering and posting, that state that configuration writes have to
> > be non-posted transactions.
> > 
> > Current ioremap interface on ARM provides mapping functions that
> > provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
> > memory type) aka posted writes, so PCI host controller drivers have
> > no arch interface to remap PCI configuration space with memory
> > attributes that comply with the PCI specifications for configuration
> > space.
> > 
> > Implement an ARM specific ioremap_nopost() interface that allows to
> > map PCI config memory regions with MT_UNCACHED memory type (ie strongly
> > ordered - non-posted writes), providing a remap function that complies
> > with PCI specifications for config space transactions.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@armlinux.org.uk>
> > ---
> >  arch/arm/include/asm/io.h | 10 ++++++++++
> >  arch/arm/mm/ioremap.c     |  7 +++++++
> >  arch/arm/mm/nommu.c       |  9 +++++++++
> >  3 files changed, 26 insertions(+)
> 
> I have not added your ACK to this patch since I slightly tweaked
> it to adapt it to ioremap_nopost() interface instead of a PCI
> specific one. Furthermore, I mechanically added a ioremap_nopost()
> version for nommu too in the process, would be good to have a look
> if I did that properly please.
> 
> Can I add your ACK on this patch ? If you spot any issues please
> do let me know.

Hi Russell,

please let me know if your ACK on this patch stands as I have to respin
it shortly for hopefully final round of review.

Thanks !
Lorenzo

> Thank you !
> Lorenzo
> 
> > diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> > index 42871fb..49913d1 100644
> > --- a/arch/arm/include/asm/io.h
> > +++ b/arch/arm/include/asm/io.h
> > @@ -352,6 +352,7 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
> >   * mapping has specific properties.
> >   *
> >   * Function		Memory type	Cacheability	Cache hint
> > + * ioremap_nopost()	SO		n/a		n/a
> >   * ioremap()		Device		n/a		n/a
> >   * ioremap_nocache()	Device		n/a		n/a
> >   * ioremap_cache()	Normal		Writeback	Read allocate
> > @@ -372,6 +373,12 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
> >   * compiler may generate unaligned accesses - eg, via inlining its own
> >   * memcpy.
> >   *
> > + * ioremap_nopost() maps memory as strongly ordered, to be used for
> > + * specific mappings (eg PCI config space) that require non-posted
> > + * write transactions. Strongly ordered transactions are ordered wrt
> > + * device mappings, which means that ioremap_nopost() is the same
> > + * as ioremap() except for non-posted writes behaviour.
> > + *
> >   * All normal memory mappings have the following properties:
> >   * - reads can be repeated with no side effects
> >   * - repeated reads return the last value written
> > @@ -407,6 +414,9 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
> >  #define ioremap_wc ioremap_wc
> >  #define ioremap_wt ioremap_wc
> >  
> > +void __iomem *ioremap_nopost(resource_size_t res_cookie, size_t size);
> > +#define ioremap_nopost ioremap_nopost
> > +
> >  void iounmap(volatile void __iomem *iomem_cookie);
> >  #define iounmap iounmap
> >  
> > diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> > index ff0eed2..4ffaf16 100644
> > --- a/arch/arm/mm/ioremap.c
> > +++ b/arch/arm/mm/ioremap.c
> > @@ -463,6 +463,13 @@ void iounmap(volatile void __iomem *cookie)
> >  }
> >  EXPORT_SYMBOL(iounmap);
> >  
> > +void __iomem *ioremap_nopost(resource_size_t res_cookie, size_t size)
> > +{
> > +	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
> > +				   __builtin_return_address(0));
> > +}
> > +EXPORT_SYMBOL_GPL(ioremap_nopost);
> > +
> >  #ifdef CONFIG_PCI
> >  static int pci_ioremap_mem_type = MT_DEVICE;
> >  
> > diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> > index 3b5c7aa..dfd736a 100644
> > --- a/arch/arm/mm/nommu.c
> > +++ b/arch/arm/mm/nommu.c
> > @@ -21,6 +21,8 @@
> >  #include <asm/mpu.h>
> >  #include <asm/procinfo.h>
> >  
> > +#include <asm/mach/map.h>
> > +
> >  #include "mm.h"
> >  
> >  unsigned long vectors_base;
> > @@ -433,6 +435,13 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
> >  }
> >  EXPORT_SYMBOL(ioremap_wc);
> >  
> > +void __iomem *ioremap_nopost(resource_size_t res_cookie, size_t size)
> > +{
> > +	return __arm_ioremap_caller(res_cookie, size, MT_UNCACHED,
> > +				    __builtin_return_address(0));
> > +}
> > +EXPORT_SYMBOL(ioremap_nopost);
> > +
> >  void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
> >  {
> >  	return (void *)phys_addr;
> > -- 
> > 2.10.0
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
