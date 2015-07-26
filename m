Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49980 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbbGZS7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 26 Jul 2015 14:59:23 -0400
Date: Sun, 26 Jul 2015 20:00:03 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Jayachandran C." <jchandra@broadcom.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	James Morse <James.Morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH v2 2/2] ARM: pci: kill pcibios_msi_controller
Message-ID: <20150726190003.GA9733@red-moon>
References: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437754383-8162-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20150726152528.GB2357@jayachandranc.netlogicmicro.com>
 <20150726181646.GA9584@red-moon>
 <20150726184345.GA27049@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150726184345.GA27049@jayachandranc.netlogicmicro.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 26, 2015 at 07:43:46PM +0100, Jayachandran C. wrote:
> On Sun, Jul 26, 2015 at 07:16:46PM +0100, Lorenzo Pieralisi wrote:
> > On Sun, Jul 26, 2015 at 04:25:29PM +0100, Jayachandran C. wrote:
> > > On Fri, Jul 24, 2015 at 05:13:03PM +0100, Lorenzo Pieralisi wrote:
> > > > On ARM PCI systems relying on the pcibios API to initialize PCI host
> > > > controllers, the pcibios_msi_controller weak callback is used to look-up
> > > > the msi_controller pointer, through pci_sys_data msi_ctrl pointer.
> > > > 
> > > > pci_sys_data is an ARM specific structure, which prevents using the
> > > > same mechanism (so same PCI host controller drivers) on ARM64 systems.
> > > > 
> > > > Since the struct pci_bus already contains an msi_controller pointer and
> > > > the kernel already uses it to look-up the msi controller,
> > > > this patch converts ARM host controller and related pcibios/host bridges
> > > > initialization routines so that the msi_controller pointer look-up can be
> > > > carried out by PCI core code through the struct pci_bus msi pointer,
> > > > removing the need for the arch specific pcibios_msi_controller callback
> > > > and the related pci_sys_data msi_ctrl pointer.
> > > > 
> > > > ARM is the only arch relying on the pcibios_msi_controller() weak
> > > > function, hence this patch removes the default weak implementation
> > > > from PCI core code since it becomes of no use.
> > > > 
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > > > Cc: Pratyush Anand <pratyush.anand@gmail.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Simon Horman <horms@verge.net.au>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > > ---
> > > > v1->v2
> > > > 
> > > > - Added patch to replace panic statements with WARN
> > > > - Removed unused pcibios_msi_controller() and pci_msi_controller() from
> > > >   core code
> > > > - Dropped RFT status
> > > > 
> > > > v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356028.html
> > > > 
> > > >  arch/arm/include/asm/mach/pci.h    |  3 ---
> > > >  arch/arm/kernel/bios32.c           | 29 +++++++++++++----------------
> > > >  drivers/pci/host/pcie-designware.c |  9 +++++++--
> > > >  drivers/pci/host/pcie-xilinx.c     | 12 ++++++++++--
> > > >  drivers/pci/msi.c                  | 17 +----------------
> > > >  5 files changed, 31 insertions(+), 39 deletions(-)
> > > > 
> > > [...]
> > > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > > index f66be86..0d20142 100644
> > > > --- a/drivers/pci/msi.c
> > > > +++ b/drivers/pci/msi.c
> > > > @@ -77,24 +77,9 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
> > > >  
> > > >  /* Arch hooks */
> > > >  
> > > > -struct msi_controller * __weak pcibios_msi_controller(struct pci_dev *dev)
> > > > -{
> > > > -	return NULL;
> > > > -}
> > > > -
> > > > -static struct msi_controller *pci_msi_controller(struct pci_dev *dev)
> > > > -{
> > > > -	struct msi_controller *msi_ctrl = dev->bus->msi;
> > > > -
> > > > -	if (msi_ctrl)
> > > > -		return msi_ctrl;
> > > > -
> > > > -	return pcibios_msi_controller(dev);
> > > > -}
> > > > -
> > > >  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> > > >  {
> > > > -	struct msi_controller *chip = pci_msi_controller(dev);
> > > > +	struct msi_controller *chip = dev->bus->msi;
> > > >  	int err;
> > > >  
> > > >  	if (!chip || !chip->setup_irq)
> > > 
> > > Don't you have to go to the top level bus and get the ->msi pointer? Something
> > > like:
> > > 
> > > 	for (bus = dev->bus; bus != NULL; bus = bus->parent)
> > > 		if (bus->msi)
> > > 			return bus->msi;
> > > 
> > > I have not been following this closely, so I may have missed some patches.
> > 
> > The msi pointer is initialized from parent to child in
> > pci_alloc_child_bus(), so PCI core does that for us,
> > that's my understanding.
> > 
> > It works the same as sysdata pointer, which is why
> > pcibios_msi_controller works in the current kernel.
> 
> Thanks.
> 
> > On a side note, are you able to prepare a new version
> > of your set to enable the PCI generic host on ARM64
> > (and remove pci_sys_data and related ifdef CONFIG_ARM
> > from it) ?
> > 
> > We are not far from removing the pci_sys_data dependency,
> > if you can't prepare a new version of your series let me
> > know I can do it on your behalf.
> 
> I will post an updated patch with a minor fix. I will also
> add a patch for parsing msi-parent and setting ->msi on
> the root bus.

There is no need for any msi parsing in the PCI generic host,
Marc implemented mechanism for us in core code:

https://lkml.org/lkml/2015/7/7/724

Thanks,
Lorenzo
