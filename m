Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45696 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbcBOTjC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Feb 2016 14:39:02 -0500
Date: Mon, 15 Feb 2016 12:39:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 1/2] PCI: Add PCI device flag
 PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS
Message-ID: <20160215123901.1600f86f@t450s.home>
In-Reply-To: <20160215182023.GB12641@localhost>
References: <1455487501-28630-1-git-send-email-jchandra@broadcom.com>
	<20160215182023.GB12641@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 15 Feb 2016 12:20:23 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, iommu list]
> 
> On Mon, Feb 15, 2016 at 03:35:00AM +0530, Jayachandran C wrote:
> > Add a new flag PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS to indicate bridges
> > that should not be considered during DMA alias search. This is
> > to support hardware (in this case Broadcom Vulcan PCIe subsystem)
> > that has internal bridges which have either missing or wrong PCIe
> > capabilities.  

I figured this would come at some point, the right answer is of course
to follow the PCIe spec and implement the required PCIe capability in
the hardware.

> 
> This needs more explanation, like what exactly is wrong with this
> device?  A missing PCIe capability might cause other problems.
> 
> What problem does this fix?  Without these patches, do we merely add
> aliases that are unnecessary?  Do we crash because something goes
> wrong in the pci_pcie_type() switch because of the incorrect
> capability?

The change takes the same code path as it would for a real PCIe bridge
port (downstream/upstream/root), which means they want to skip adding
this bridge as an alias of the device.  So we're adding in aliases that
don't exist, the bridge itself.

If anything I'd suggest a flag that actually tries to address the
problem rather than a symptom of the problem.  For example, maybe the
flag should be PCI_DEV_FLAGS_IS_PCIE.  Maybe pci_is_pcie() should even
take that into account.  That has some trickle through for
pci_pcie_type() and all the accessor functions, but maybe it's a
cleaner solution overall (or maybe it explodes further).  Thanks,

Alex

> > Update the function pci_for_each_dma_alias() to skip bridges with
> > this flag set.
> > 
> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > ---
> > 
> > This patch is an RFC, if there is a better way to do this, please
> > let me know.
> > 
> > Thanks,
> > JC.
> > 
> >  drivers/pci/search.c | 2 ++
> >  include/linux/pci.h  | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index a20ce7d..e5296aa 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -55,6 +55,8 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
> >  			continue;
> >  
> >  		tmp = bus->self;
> > +		if (tmp->dev_flags & PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS)
> > +			continue;
> >  
> >  		/*
> >  		 * PCIe-to-PCI/X bridges alias transactions from downstream
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 27df4a6..b4d8215 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -182,6 +182,8 @@ enum pci_dev_flags {
> >  	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
> >  	/* Get VPD from function 0 VPD */
> >  	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
> > +	/* Bridge should be ignored for alias search  */
> > +	PCI_DEV_FLAGS_BRIDGE_SKIP_ALIAS = (__force pci_dev_flags_t) (1 << 9),
> >  };
> >  
> >  enum pci_irq_reroute_variant {
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  

