Return-Path: <SRS0=5qTW=25=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=5qTW=25=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 20 Mar 2017 16:26:27 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
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
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 02/20] PCI: fix pci_remap_iospace() remap attribute
Message-ID: <20170320162627.GE7632@red-moon>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-3-lorenzo.pieralisi@arm.com>
 <20170316214844.GA17769@bhelgaas-glaptop.roam.corp.google.com>
 <20170317003321.GB28800@wotan.suse.de>
 <20170320160636.GB24572@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170320160636.GB24572@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 20, 2017 at 11:06:36AM -0500, Bjorn Helgaas wrote:

[...]

> > > > @@ -3375,7 +3375,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > > >  		return -EINVAL;
> > > >  
> > > >  	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
> > > > -				  pgprot_device(PAGE_KERNEL));
> > > > +				  pgprot_noncached(PAGE_KERNEL));
> > > 
> > > ...
> > > I do find this puzzling because I naively expected pgprot_noncached()
> > > to match up with ioremap_nocache(), and apparently it doesn't.
> > > 
> > > For example, ARM64 ioremap_nocache() uses PROT_DEVICE_nGnRE, which
> > > doesn't match the MT_DEVICE_nGnRnE in pgprot_noncached().
> > > 
> > > The point of these patches is to use non-posted mappings.  Apparently
> > > you can do that with pgprot_noncached() here, but ioremap_nocache()
> > > isn't enough for the config space mappings?
> > 
> > This is for iospace it seems, so the other patch I think was for
> > config space.
> 
> I understand that 02/20 is for PCI I/O port space and 03/20 is for PCI
> config space.  I'm confused because I thought we wanted the same
> non-posted mapping for both, but looks like they're different.
> 
> Patch 02/20 uses ioremap_page_range(..., pgprot_noncached(PAGE_KERNEL))
> to map PCI I/O port space:
> 
>   #define pgprot_noncached(prot) \
>           __pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE) | PTE_PXN | PTE_UXN)
> 
> Patch 03/20 uses ioremap_nocache() to map PCI config space:
> 
>   #define ioremap_nocache(addr, size)     __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
> 
> So the I/O port mapping uses MT_DEVICE_nGnRnE, while the config space
> mapping uses PROT_DEVICE_nGnRE, which looks different.

On ARM64 (PATCH 4) and ARM (PATCH 5) we override pci_remap_cfgspace()
with implementations that provide non-posted writes bus attributes,
PATCH 3 is just there to provide a "safe" (well, I need input on that)
fall-back.

Thanks,
Lorenzo
