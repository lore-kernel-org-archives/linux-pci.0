Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Mar 2017 11:29:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 03/20] asm-generic/io.h: add PCI config space remap
 interface
Message-ID: <20170322162958.GA24935@bhelgaas-glaptop.roam.corp.google.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-4-lorenzo.pieralisi@arm.com>
 <20170316211243.GE9739@bhelgaas-glaptop.roam.corp.google.com>
 <20170322150403.GA4951@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170322150403.GA4951@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 linux-arch@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, arnd@arndb.de,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 22, 2017 at 03:04:03PM +0000, Lorenzo Pieralisi wrote:
> Hi Bjorn, Arnd,
> 
> On Thu, Mar 16, 2017 at 04:12:43PM -0500, Bjorn Helgaas wrote:
> > [+cc Luis]
> > 
> > On Mon, Feb 27, 2017 at 03:14:14PM +0000, Lorenzo Pieralisi wrote:
> > > The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
> > > Posting") mandate non-posted configuration transactions. As further
> > > highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
> > > Considerations for the Enhanced Configuration Access Mechanism"),
> > > through ECAM and ECAM-derivative configuration mechanism, the memory
> > > mapped transactions from the host CPU into Configuration Requests on the
> > > PCI express fabric may create ordering problems for software because
> > > writes to memory address are typically posted transactions (unless the
> > > architecture can enforce through virtual address mapping non-posted
> > > write transactions behaviour) but writes to Configuration Space are not
> > > posted on the PCI express fabric.
> > > 
> > > Current DT and ACPI host bridge controllers map PCI configuration space
> > > (ECAM and ECAM-derivative) into the virtual address space through
> > > ioremap() calls, that are non-cacheable device accesses on most
> > > architectures, but may provide "bufferable" or "posted" write semantics
> > > in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
> > > to be buffered in the bus connecting the host CPU to the PCI fabric;
> > > this behaviour, as underlined in the PCIe specifications, may trigger
> > > transactions ordering rules and must be prevented.
> > > 
> > > Introduce a new generic and explicit API to create a memory
> > > mapping for ECAM and ECAM-derivative config space area that
> > > defaults to ioremap_nocache() (which should provide a sane default
> > > behaviour) but still allowing architectures on which ioremap_nocache()
> > > results in posted write transactions to override the function
> > > call with an arch specific implementation that complies with
> > > the PCI specifications for configuration transactions.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > >  include/asm-generic/io.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > index 7ef015e..52dda81 100644
> > > --- a/include/asm-generic/io.h
> > > +++ b/include/asm-generic/io.h
> > > @@ -915,6 +915,15 @@ extern void ioport_unmap(void __iomem *p);
> > >  #endif /* CONFIG_GENERIC_IOMAP */
> > >  #endif /* CONFIG_HAS_IOPORT_MAP */
> > >  
> > > +#ifndef pci_remap_cfgspace
> > > +#define pci_remap_cfgspace pci_remap_cfgspace
> > > +static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
> > > +					       size_t size)
> > > +{
> > > +	return ioremap_nocache(offset, size);
> > > +}
> > 
> > I'm fine with this conceptually, but I think it would make more sense
> > if the name weren't specific to PCI or config space, e.g.,
> > ioremap_nopost() or something.
> 
> I would like to respin shortly so I have to make a decision on the
> interface, either:
> 
> (1) I keep it a PCI only interface (which means I can even move it to
>     include/linux/pci.h and arch*/include/asm/pci.h to override it)
> 
> or
> 
> (2) We add it as a generic ioremap_* interface (I am not sure though
>     that's really useful other than to map PCI config space, actually
>     the reasoning behind the naming was to limit its usage to PCI
>     config space mappings)
> 
> I take it as Bjorn is keener on (2), just running a final check before
> putting v2 together to make progress.

The point of this seems to be to use non-posted mappings for both I/O
port space and ECAM (config) space.  So I think the most readable way
would be to have generic definitions like this:

  #ifndef ioremap_nopost
  #define ioremap_nopost ioremap_nocache
  #endif

  #ifndef pgprot_nonposted
  #define pgprot_nonposted(prot) pgprot_noncached(prot)
  #endif

and let ARM/ARM64 implement their own versions of those.  Then the
devm code might fit naturally in lib/devres.c, e.g.,

  void __iomem *devm_ioremap_nopost(...) { ... }

and we probably wouldn't need the pci_remap_cfgspace() wrapper, e.g.,
we could do:

  return ioremap_page_range(..., pgprot_nonposted(PAGE_KERNEL));

  cfg->win = ioremap_nopost(...);

But I might be oversimplifying things.

BTW, I tried to apply the v1 series on my "master" branch (v4.11-rc1)
and patch 19 didn't apply cleanly.  It's trivial and I can fix it up
by hand, so not really a problem, just FYI.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
