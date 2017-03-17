Return-Path: <SRS0=ddbh=22=suse.de=lurodriguez@kernel.org>
Return-Path: <SRS0=ddbh=22=suse.de=lurodriguez@kernel.org>
Date: Fri, 17 Mar 2017 01:08:03 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Andy Lutomirski <luto@amacapital.net>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH 03/20] asm-generic/io.h: add PCI config space remap
 interface
Message-ID: <20170317000803.GA28800@wotan.suse.de>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-4-lorenzo.pieralisi@arm.com>
 <20170316211243.GE9739@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316211243.GE9739@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 16, 2017 at 04:12:43PM -0500, Bjorn Helgaas wrote:
> [+cc Luis]
> 
> On Mon, Feb 27, 2017 at 03:14:14PM +0000, Lorenzo Pieralisi wrote:
> > The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
> > Posting") mandate non-posted configuration transactions. As further
> > highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
> > Considerations for the Enhanced Configuration Access Mechanism"),
> > through ECAM and ECAM-derivative configuration mechanism, the memory
> > mapped transactions from the host CPU into Configuration Requests on the
> > PCI express fabric may create ordering problems for software because
> > writes to memory address are typically posted transactions (unless the
> > architecture can enforce through virtual address mapping non-posted
> > write transactions behaviour) but writes to Configuration Space are not
> > posted on the PCI express fabric.
> > 
> > Current DT and ACPI host bridge controllers map PCI configuration space
> > (ECAM and ECAM-derivative) into the virtual address space through
> > ioremap() calls, that are non-cacheable device accesses on most
> > architectures, but may provide "bufferable" or "posted" write semantics
> > in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
> > to be buffered in the bus connecting the host CPU to the PCI fabric;
> > this behaviour, as underlined in the PCIe specifications, may trigger
> > transactions ordering rules and must be prevented.
> > 
> > Introduce a new generic and explicit API to create a memory
> > mapping for ECAM and ECAM-derivative config space area that
> > defaults to ioremap_nocache() (which should provide a sane default
> > behaviour) but still allowing architectures on which ioremap_nocache()
> > results in posted write transactions to override the function
> > call with an arch specific implementation that complies with
> > the PCI specifications for configuration transactions.

So... I take it this is actually fixing a series of odd issues also,
do we at least have some reports or actual issues ?

> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  include/asm-generic/io.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 7ef015e..52dda81 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -915,6 +915,15 @@ extern void ioport_unmap(void __iomem *p);
> >  #endif /* CONFIG_GENERIC_IOMAP */
> >  #endif /* CONFIG_HAS_IOPORT_MAP */
> >  
> > +#ifndef pci_remap_cfgspace
> > +#define pci_remap_cfgspace pci_remap_cfgspace
> > +static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
> > +					       size_t size)
> > +{
> > +	return ioremap_nocache(offset, size);
> > +}
> 
> I'm fine with this conceptually, but I think it would make more sense
> if the name weren't specific to PCI or config space, e.g.,
> ioremap_nopost() or something.

Seems reasonable to me -- but are there other buses that could use this already
as well ? Wouldn't these other buses also run into similar issues ? Can someone
also bounce me a copy of the patches that use this ?

While at it, please add some documentation too, the above commit log is huge,
and yet for the person eyeballing the code they won't have any clue why this
was added exactly. Since this is about helping with picking the right
ioremap due to certain semantics / requirements on the PCI config space,
we should clarify then what exactly are the expectations here. The clearer
you are the less in trouble we can get later.

  Luis
