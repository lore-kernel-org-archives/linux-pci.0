Return-Path: <SRS0=ddbh=22=suse.de=lurodriguez@kernel.org>
Return-Path: <SRS0=ddbh=22=suse.de=lurodriguez@kernel.org>
Date: Fri, 17 Mar 2017 01:33:21 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Andy Lutomirski <luto@amacapital.net>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Will Deacon <will.deacon@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, linux-arch@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Mason <jonmason@broadcom.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH 02/20] PCI: fix pci_remap_iospace() remap attribute
Message-ID: <20170317003321.GB28800@wotan.suse.de>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-3-lorenzo.pieralisi@arm.com>
 <20170316214844.GA17769@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316214844.GA17769@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 16, 2017 at 04:48:44PM -0500, Bjorn Helgaas wrote:
> [+cc Luis]
> 
> On Mon, Feb 27, 2017 at 03:14:13PM +0000, Lorenzo Pieralisi wrote:
> > According to the PCI local bus specifications (Revision 3.0, 3.2.5),
> > I/O Address space transactions are non-posted. On architectures where
> > I/O space is implemented through a chunk of memory mapped space mapped
> > to PCI address space (ie IA64/ARM/ARM64) the memory mapping for the
> > region backing I/O Address Space transactions determines the I/O
> > transactions attributes (before the transactions actually reaches the
> > PCI bus where it is handled according to the PCI specifications).
> > 
> > Current pci_remap_iospace() interface, that is used to map the PCI I/O
> > Address Space into virtual address space, use pgprot_device() as memory
> > attribute for the virtual address mapping, that in some architectures
> > (ie ARM64) provides non-cacheable but write bufferable mappings (ie
> > posted writes), 

<sarcasm>
Gee wiz, I am glad this is so well documented.
</sarcasm>

> > which clash with the non-posted write behaviour for I/O
> > Address Space mandated by the PCI specifications.
> > 
> > Update the prot ioremap_page_range() parameter in pci_remap_iospace()
> > to pgprot_noncached to ensure that the virtual mapping backing
> > I/O Address Space guarantee non-posted write transactions issued
> > when addressing I/O Address Space through the MMIO mapping.

How did we end up with pgprot_device() then in the first place Liviu Dudau [0] ?
I ask for two reasons:

a) should we then use a Fixes tag for this patch ?
b) it does not seem clear what the semantics for pgprot_device() or even
   pgprot_noncached(). Can you add some ?

8b921acfeffdb ("PCI: Add pci_remap_iospace() to map bus I/O resources")

Also this patch claims archs can override this call alone, as its __weak.
So is the right thing to do to change pci_remap_iospace() to pgprot_noncached()
or is it for archs to add their own pci_remap_iospace()? If so why ? Without
proper semantics defined for these helpers this is all fuzzy.

> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  drivers/pci/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index bd98674..bfb3c6e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3375,7 +3375,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> >  		return -EINVAL;
> >  
> >  	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
> > -				  pgprot_device(PAGE_KERNEL));
> > +				  pgprot_noncached(PAGE_KERNEL));
> 
> pgprot_device() is equivalent to pgprot_noncached() on all arches
> except ARM64, and I trust you're doing the right thing on ARM64, so
> I'm fine with this from a PCI perspective.
> 
> I do find this puzzling because I naively expected pgprot_noncached()
> to match up with ioremap_nocache(), and apparently it doesn't.
> 
> For example, ARM64 ioremap_nocache() uses PROT_DEVICE_nGnRE, which
> doesn't match the MT_DEVICE_nGnRnE in pgprot_noncached().
> 
> The point of these patches is to use non-posted mappings.  Apparently
> you can do that with pgprot_noncached() here, but ioremap_nocache()
> isn't enough for the config space mappings?

This is for iospace it seems, so the other patch I think was for
config space.

  Luis

> I suppose that's a consequence of the pgprot_noncached() vs
> ioremap_nocache() mismatch, but this is all extremely confusing.
> 
> >  #else
> >  	/* this architecture does not have memory mapped I/O space,
> >  	   so this function should never be called */
> > -- 
> > 2.10.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
