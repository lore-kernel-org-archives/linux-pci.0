Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdLAO3Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Dec 2017 09:29:24 -0500
Date: Fri, 1 Dec 2017 08:29:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] PCI: Remove PCI_REASSIGN_ALL_RSRC use on arm and arm64
Message-ID: <20171201142921.GE19640@bhelgaas-glaptop.roam.corp.google.com>
References: <20171130201505.7811.2713.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171201102757.GA25010@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171201102757.GA25010@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 01, 2017 at 10:27:57AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Nov 30, 2017 at 02:15:05PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > On arm, PCI_REASSIGN_ALL_RSRC is used only in pcibios_assign_all_busses(),
> > which helps decide whether to reconfigure bridge bus numbers.  It has
> > nothing to do with BAR assignments.  On arm64 and powerpc,
> > pcibios_assign_all_busses() tests PCI_REASSIGN_ALL_BUS, which makes more
> > sense.
> > 
> > Align arm with arm64 and powerpc, so they all use PCI_REASSIGN_ALL_BUS for
> > pcibios_assign_all_busses().
> > 
> > Remove PCI_REASSIGN_ALL_RSRC from the Tegra, Versatile, and R-Car drivers.
> > These drivers are used only on arm or arm64, where PCI_REASSIGN_ALL_RSRC is
> > not used after this change, so removing it should have no effect.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  arch/arm/include/asm/pci.h       |    5 +----
> >  arch/arm/kernel/bios32.c         |    2 +-
> >  drivers/pci/host/pci-tegra.c     |    2 +-
> >  drivers/pci/host/pci-versatile.c |    2 +-
> >  drivers/pci/host/pcie-rcar.c     |    2 +-
> 
> What about drivers/pci/host/pci-host-common.c ?

Oh!  You're right!  For some reason I had assumed pci-host-common.c
was used on non-arm arches, but it's not.

I'll do the same there.

> Other than that:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> >  5 files changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> > index 960d9dc4f380..1f0de808d111 100644
> > --- a/arch/arm/include/asm/pci.h
> > +++ b/arch/arm/include/asm/pci.h
> > @@ -10,10 +10,7 @@ extern unsigned long pcibios_min_io;
> >  extern unsigned long pcibios_min_mem;
> >  #define PCIBIOS_MIN_MEM pcibios_min_mem
> >  
> > -static inline int pcibios_assign_all_busses(void)
> > -{
> > -	return pci_has_flag(PCI_REASSIGN_ALL_RSRC);
> > -}
> > +#define pcibios_assign_all_busses()	pci_has_flag(PCI_REASSIGN_ALL_BUS)
> >  
> >  #ifdef CONFIG_PCI_DOMAINS
> >  static inline int pci_proc_domain(struct pci_bus *bus)
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index 0cd0aefb3a8f..ed46ca69813d 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -527,7 +527,7 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
> >  	struct pci_sys_data *sys;
> >  	LIST_HEAD(head);
> >  
> > -	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
> > +	pci_add_flags(PCI_REASSIGN_ALL_BUS);
> >  	if (hw->preinit)
> >  		hw->preinit();
> >  	pcibios_init_hw(parent, hw, &head);
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index f9d3960dc39f..ee193767f77b 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -2382,7 +2382,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
> >  
> >  	tegra_pcie_enable_ports(pcie);
> >  
> > -	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> > +	pci_add_flags(PCI_REASSIGN_ALL_BUS);
> >  	host->busnr = pcie->busn.start;
> >  	host->dev.parent = &pdev->dev;
> >  	host->ops = &tegra_pcie_ops;
> > diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> > index d417acab0ecf..2a2dfcd68e86 100644
> > --- a/drivers/pci/host/pci-versatile.c
> > +++ b/drivers/pci/host/pci-versatile.c
> > @@ -202,7 +202,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
> >  	writel(0, versatile_cfg_base[0] + PCI_INTERRUPT_LINE);
> >  
> >  	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
> > -	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
> > +	pci_add_flags(PCI_REASSIGN_ALL_BUS);
> >  
> >  	list_splice_init(&pci_res, &bridge->windows);
> >  	bridge->dev.parent = dev;
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > index 12796eccb2be..03fabb0552ae 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -459,7 +459,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
> >  
> >  	rcar_pcie_setup(&bridge->windows, pcie);
> >  
> > -	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
> > +	pci_add_flags(PCI_REASSIGN_ALL_BUS);
> >  
> >  	bridge->dev.parent = dev;
> >  	bridge->sysdata = pcie;
> > 
